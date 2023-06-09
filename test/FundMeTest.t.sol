// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundMeContractDeploy} from "../script/FundMeContractDeploy.s.sol";

contract FundMeTest is Test {
    FundMe public fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant startingBalance = 10 ether;

    function setUp() public {
        FundMeContractDeploy fundMeContractDeploy = new FundMeContractDeploy();
        fundMe = fundMeContractDeploy.run();
        vm.deal(USER, startingBalance);
    }

    function testvalueis1dollar() public {
        console.log(fundMe.minimumUsd());
        console.log(address(fundMe));
        assertEq(fundMe.minimumUsd(), 5e18);
    }

    function testgetPriceFeed() external {
        uint256 conversionRate = fundMe.getConversionRate(10000000000000000);
        console.log(conversionRate);
        fundMe.fund{value: 10000000000000000}();
        console.log(address(fundMe).balance);
        assertEq(address(fundMe).balance, 10000000000000000);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() external {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        uint256 fundedAmount = fundMe.getFundedAmount(USER);
        console.log(fundedAmount);
        assertEq(fundedAmount, SEND_VALUE);
    }
}
