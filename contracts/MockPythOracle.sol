// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockPythOracle {
    int256 public price;
    uint256 public lastUpdated;

    function updatePrice(int256 _price) external {
        price = _price;
        lastUpdated = block.timestamp;
    }
}
