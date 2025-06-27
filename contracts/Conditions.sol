// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract Conditions {
    function checkCondition(uint a, uint b) public pure returns (bool) {
        if (a < b) {
            console.log("a is less than b");
            return true;
        } else if (a == b) {
            console.log("a is equal to b");
            return true;
        } else {
            console.log("b is less than a");
            return false;
        }
    }


    function checkEventNum (uint num) public pure returns (bool) {
        if (num % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }

    function  checkNumIsZero(uint num) public pure returns (bool) {
       require(num == 0, "Number is not zero");
        return true;
    }

    function  ifIsZero(uint num) public pure returns (bool) {
        if (num == 0) return true;
        revert("Number is not zero");
    }

}
