// SPDX-License-Identifier: MIT
//First is always the licensing part

pragma solidity ^0.8.18; //Here we always specify the version of solidity.

//Like class in Java.
contract SimpleStorage{
  
  uint256 favouriteNumber; //default value 0.
  Person[] public persons;//default value empty or say null in terms of Java.
  mapping(string=>uint256) public nameToFavouriteNumber;//So a way to find the person favnumber by their name in the persons array.

  //Like methods in Java.
  function store(uint256 _favouriteNumber) public virtual {
    favouriteNumber = _favouriteNumber;
  }

  //Because favouriteNumber is internal makes sense to have a retrieve function.
  function retrievefavouriteNumber() public view returns (uint256) {
      return favouriteNumber;
  }

  //Now we want to have persons with their FavNumbers and their names.
  //This demands us to create another Datatype in solidity.
  struct Person {
    uint256 favNumber;
    string name;
  }

  //Now we need a function to add the person in the array of persons.
  function addPerson(string memory _name,uint256 _favNum) public {
   persons.push(Person(_favNum,_name));
   nameToFavouriteNumber[_name]=_favNum;
  }
  //End of contract.
}