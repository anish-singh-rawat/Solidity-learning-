// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract ChainlinkPriceConsumer {
    AggregatorV3Interface public immutable priceFeed;

    constructor(address _priceFeed) {
        require(_priceFeed != address(0), "Invalid feed address");
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function getLatestPrice() external view returns (int256) {
        (
            uint80 roundId,
            int256 price,
            ,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        require(price > 0, "Invalid price");
        require(updatedAt > 0, "No timestamp");
        require(answeredInRound >= roundId, "Stale round");
        require(block.timestamp - updatedAt < 1 hours, "Stale price");

        return price;
    }

    // Optional helper (useful in real apps)
    function getDecimals() external view returns (uint8) {
        return priceFeed.decimals();
    }
}
