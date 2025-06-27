// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract Loops {
    function whileLoop() public pure returns (uint) {
        uint i = 0;
        uint sum = 0;
        while (i < 10) {
            sum += i;
            i++;
        }
        console.log("Sum in while loop:", sum);
        return sum;
    }

    function doWhileLoop() public pure returns (uint) {
        uint i = 0;
        uint sum = 0;
        do {
            sum += i;
            i++;
        } while (i < 10);
        console.log("Sum in do while loop:", sum);
        return sum;
    }

    function ForLoop() public pure returns (uint) {
        uint i = 0;
        uint sum = 0;
        for (i = 0; i <= 10; i++) {
            sum += i;
        }
        console.log("Sum in for loop:", sum);
        return sum;
    }
}