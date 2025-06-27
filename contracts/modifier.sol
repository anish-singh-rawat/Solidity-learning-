// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract Modifier {
    modifier IsTrue(uint a) {
        require(0<a, "a is not grater than 0");
        _;
    }

    function checkModifier1(uint data) public pure IsTrue(data) returns(bool){
        return true;
    }

    function checkModifier2(uint data) public pure IsTrue(data) returns(bool){
        return true;
    }
}