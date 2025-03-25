// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//This line imports the AggregatorV3Interface directly from NPM which imports it from Github.
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//To answer to question in Patrick collins code, I would say the functions we write here are fully internal and does not modify the state of the 
//of the blockchain plus we can provide implementation here and keeping code in our other contracts simple and readable.

library PriceConverter{

 //Now our purpose here is to make a function which allows us to read the ETH/USD price using chainlink Data feed.
 function getPrice() internal view returns (uint256) {
    
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);//Type casting this address to this interface as this address implents it functions to give as ETH/USD price on Sepolia Testnet.
    (,int256 answer,,,)=priceFeed.latestRoundData();//This saves everything from 0x694AA1769357215DE4FAC081bf1f309aDC325306 which this address defines in this function.
    //We are only interested in the answer so we save only answer.
    return uint256(answer*1e10);//This give out the price of Ether/USD in 18 decimal places.

 }

 //Now we need a function which which gives us the price of specific amount of ETH.
 function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
    
    uint256 ethPrice=getPrice(); //This gives us the price of Eth/USD on Sepolia Testnet. We are using this as our base price to be able to convert other currencies.
    uint256 ethAmountInUsd=(ethAmount*ethPrice)/1e18;//eth amount is in 18 decimal places and also ethPrice we divide it by 1e18 to bring it to 18 decimal places.
    return ethAmountInUsd;

   }
}//End of Library.




//Important things to know:
/*
1 Ether =1e18 WEI.
Chainlink Oracles return the prices only upto 8 decimal places.
*/