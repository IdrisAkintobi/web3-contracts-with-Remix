// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SaveEther {
    address owner;

    mapping(address => uint256) balances;

    constructor() {
        owner = msg.sender;
    }

    event DepositSuccessful(address indexed _user, uint256 indexed _amount);
    event WithdrawalSuccessful(address indexed _user, uint256 indexed _amount);
    event TransferSuccessful(
        address indexed _user,
        address indexed _to,
        uint256 indexed _amount
    );

    function deposit() external payable {
        require(msg.sender != address(0), "zero address detected");
        require(msg.value > 0, "you cannot deposit zero");

        balances[msg.sender] += msg.value;
        emit DepositSuccessful(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender != address(0), "zero address detected");
        require(_amount > 0, "zero amount not withdrawable!");
        require(balances[msg.sender] >= _amount, "insufficient balance");

        balances[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "failed withdrawal!");
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function myBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function transfer(uint256 _amount, address _to) external payable {
        require(msg.sender != address(0), "zero address detected");
        require(_to != address(0), "zero address detected");
        require(_amount > 0, "zero amount not withdrawable!");

        require(balances[msg.sender] >= _amount, "insufficient funds");
        balances[msg.sender] -= _amount;

        payable(_to).transfer(_amount);
    }
}
