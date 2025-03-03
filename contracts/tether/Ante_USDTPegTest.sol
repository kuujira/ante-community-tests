// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../interfaces/IERC20.sol";
import "../AnteTest.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Ante Test to check USDT remains > 0.90
contract AnteUSDTPegTest is AnteTest("USDT is above 90 cents on the dollar") {
    // https://etherscan.io/token/0xdAC17F958D2ee523a2206206994597C13D831ec7
    address public constant TetherAddr = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Mainnet
     * Aggregator: USDT/USD
     * Address: 0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46
     */
    constructor() {
        protocolName = "USDT";
        testedContracts = [TetherAddr];
        priceFeed = AggregatorV3Interface(0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46);
    }

    function checkTestPasses() public view override returns (bool) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return (90000000 < price);
    }
}
