//SPDX-License-Identifier:Unlicensed
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeContractDeploy is Script {
    function run() external returns (FundMe) {
        vm.startBroadcast();
        FundMe fundMe = new FundMe(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        vm.stopBroadcast();
        return fundMe;
    }
}
