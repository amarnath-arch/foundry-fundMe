// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

error NotEnoughAmount();

contract FundMe {
    uint256 public constant minimumUsd = 5e18;
    AggregatorV3Interface s_priceFeed;

    // mappings
    mapping(address user => uint256 amount) private fundedAmount;

    constructor(address _priceFeed) {
        s_priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function fund() public payable {
        uint256 conversionRate = getConversionRate(msg.value);

        if (conversionRate < minimumUsd) {
            revert NotEnoughAmount();
        }
        // require(
        //     getConversionRate(msg.value) >= minimumUsd,
        //     "didn't provide enough money to begin with"
        // );
        fundedAmount[msg.sender] += msg.value;
    }

    //0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

    function getPrice() public view returns (uint256) {
        (
            ,
            /* uint80 roundID */ int answer /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/,
            ,
            ,

        ) = s_priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(
        uint256 _ethAmount
    ) public view returns (uint256) {
        return (getPrice() * _ethAmount) / 1e18;
    }

    function getFundedAmount(address _user) external view returns (uint256) {
        return fundedAmount[_user];
    }
}
