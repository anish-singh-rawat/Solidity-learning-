// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

contract PythPriceConsumer {
    IPyth public pyth;
    bytes32 public priceId;

    constructor(address _pyth, bytes32 _priceId) {
        pyth = IPyth(_pyth);
        priceId = _priceId;
    }

    function getPrice() external view returns (int64) {
        PythStructs.Price memory price = pyth.getPriceNoOlderThan(
            priceId,
            60
        );

        require(price.price > 0, "Invalid price");
        return price.price;
    }
}
