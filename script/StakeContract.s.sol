// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {StakeContract} from "../src/StakeContract.sol";

contract StakeContractDeploy is Script {
    function run() external returns (StakeContract) {
        vm.startBroadcast();
        StakeContract stakeContract = new StakeContract();
        vm.stopBroadcast();
        return stakeContract;
    }
}
