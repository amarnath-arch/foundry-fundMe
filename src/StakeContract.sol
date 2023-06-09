// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "openzeppelin/token/ERC20/ERC20.sol";

error TransferFailed();

contract StakeContract {
    mapping(address => mapping(address => uint256)) public s_balances;

    function stake(uint256 amount, address _token) external returns (bool) {
        s_balances[msg.sender][_token] += amount;
        bool success = IERC20(_token).transferFrom(
            msg.sender,
            address(this),
            amount
        );
        if (!success) revert TransferFailed();
        return success;
    }
}
