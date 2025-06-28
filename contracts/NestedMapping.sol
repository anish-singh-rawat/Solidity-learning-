// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract NestedMapping {
    mapping (uint => mapping (uint => bool)) public  data;

    function insertNestedData(uint row, uint colum, bool isCompleted ) public {
        data[row][colum] = isCompleted;
    }

     function getNestedData(uint row, uint colum) public view returns(bool){
       return  data[row][colum];
    }
}