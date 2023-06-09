// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "openzeppelin/token/ERC20/ERC20.sol";



contract MockERC20 is ERC20{

    constructor() ERC20("MockERC20","MERC20"){
        _mint(msg.sender,1000000 * 10 ** 18);
    }
}
