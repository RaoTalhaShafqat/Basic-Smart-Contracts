// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//Deploying the SimpleStorage contract from this contract and storing it in the list of say list name is StorageFactory.
//So this class(in java) or contract is like a manager for all the SimpleStorage contracts.

import {SimpleStorage} from "./SimpleStorage.sol";//in brackets specify which contract you want to import.
                            //Here specify the path of file where you want to import the contract from.

contract StorageFactory{
    
    SimpleStorage[] public storageFactory; // A list to store SimpleStorage contracts created.
    
    function createSimpleStorageContract() public{
    SimpleStorage newContract = new SimpleStorage(); //new keyword suggest a new object from the given contract.
    storageFactory.push(newContract); //Push the contract to the StorageFactory.
    }
    
    //Here we can change the favourite number stored in specific contract in the storageFactory.
    function storeFavouriteNumber(uint256 _simpleStorageIndex, uint256 _simpleStorageFavouriteNumber) public{
        storageFactory[_simpleStorageIndex].store(_simpleStorageFavouriteNumber);
    }

    //A simple view function to check which contract hold which Fav Number. 
    function getFavouriteNumber(uint256 _simpleStorageIndex) public view returns (uint256){
    return storageFactory[_simpleStorageIndex].retrievefavouriteNumber();
    }
}

//End of Contract.
