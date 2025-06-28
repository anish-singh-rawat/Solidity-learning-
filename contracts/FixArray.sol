// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract Array {
    uint256 [4] public myArray = [10,20,30,40];

    function insert(uint item, uint index) public  {
        myArray[index] = item;
    }

    function getArray() public view returns (uint[4] memory) {
        return myArray;
    }

    function setArray(  uint256[4] memory _arr) public {
        myArray = _arr;
    }

    function fmemory () public  view {
        uint256[4] memory array2 = myArray;
        array2[1] = 3000;
    }

    function fstorage () public  {
         uint256[4] storage array2 = myArray;
        array2[1] = 2000;
    }
}