// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//So the purpose of this contract is to add the value to Favourite number.
import{SimpleStorage} from "./SimpleStorage.sol";

// "is" is like extends in Java. 
contract AddingValue is SimpleStorage{
 
 uint256 public constant valueAdded = 5; //So constant is here like final in java.
 
 //So remeber to write the virtual in the parent class for the function to be overridden in the future and
 //override in the method(function) which overrides the parent class method(function).
 function store(uint256 _favouriteNumber)public override {
 favouriteNumber=_favouriteNumber+valueAdded;
 }
}
//End of contract.