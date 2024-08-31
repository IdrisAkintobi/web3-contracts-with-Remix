// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Web3CXI is ERC20("iDris Token", "DRZ") {
    address public owner;

    constructor() {
        owner = msg.sender;
        _mint(msg.sender, 100e18);
    }

    function mint(uint256 _amount) external {
        require(msg.sender == owner, "ONLY THE OWNER CAN MINT");
        _mint(msg.sender, _amount * 1e18);
    }
}
