// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StakeContract.sol";
import "./mockERC20/MockERC20.sol";

contract StakeContractTest is Test {
    StakeContract public stakeContract;
    MockERC20 public mockERC20;

    function setUp() public {
        stakeContract = new StakeContract();
        mockERC20 = new MockERC20();
    }

    function testExample(uint8 amount) public {
        mockERC20.approve(address(stakeContract), amount);
        bool stakePassed = stakeContract.stake(amount, address(mockERC20));
        assertTrue(stakePassed);
    }
}
