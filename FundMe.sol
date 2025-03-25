// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//This will be a little gas efficient contract based on teachings of Patrick Collins.
//So the purpose is to make sure people can fund this contract and the owner can withdraw those funds.
import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

error insufficientFunds();//We will use this to check the minimum USD requirements to be funded.
error NotOwner();
contract FundMe{
    using PriceConverter for uint256;

    uint256 public constant MIN_USD=5e18;
    address[] public funders;//A list to track funders
    mapping(address=>uint256) public addressToAmountFunded;//A map to get sender value from sender address.
    address public immutable contract_owner;
    
    //This sets the owner at deployment time.
    //After that the owner is not changeable.
    constructor(){
        contract_owner=msg.sender;
    }

//So payable allows us to the send the contract the desired funds.
function fund() public payable {
 
 //So we use error to revert the transaction if if condition is satisfied.
 if(msg.value.getConversionRate()<MIN_USD){
    revert insufficientFunds();
   }

  addressToAmountFunded[msg.sender]+=msg.value;//This will add the previous funds of the sender to their newly send funds.
  funders.push(msg.sender);//So we will add the address of sender to funders list.
}

//This part of the code does not contribute to the functionality of the contract but just a way to interact with the chainlink priceFeed.
//This helps to cross check if the Aggregator is working properly.

function getVersion() public view returns (uint256) {
  AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
  return priceFeed.version();
}

//we need a helping function which can help us to check for owner before calling the withdraw function.
modifier onlyOwner(){
    if(msg.sender!=contract_owner){revert NotOwner();}
    _;
}

function withdrawFunds () public onlyOwner{
//Now before withdrawing we need to empty the values of all the funders w.r.t their address.
for(uint256 i=0;i<funders.length;i++){
  address funder=funders[i];
  addressToAmountFunded[funder]=0;
}

//Here we clear out the list of funders
funders=new address[](0);

//Now we send the Eth to the owner of the contract
 (bool callSuccess,)=payable (msg.sender).call{value: address(this).balance}("");
 if(!callSuccess){
    revert("Failed to withdraw money");
 }
}

//Now we need a logic for low level interactions for smartcontracts

fallback() external payable {//In case someone sends also the data with txn.
    fund();
}

receive() external payable { //In cases of no Data with txn.
    fund();
}

}//End of contract.