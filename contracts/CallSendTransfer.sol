// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import "hardhat/console.sol";

/*
 * Summary:
 * This Solidity code demonstrates three methods—`transfer`, `send`, and `call`—for transferring Ether between contracts.
 * - `Transfer` uses `transfer`, which forwards a fixed gas amount of 2300 units and reverts if the receiving contract consumes more gas.
 * - `Send` uses `send`, which also forwards 2300 gas units but returns a boolean indicating success or failure without reverting.
 * - `Call` uses `call`, allowing the sender to specify a custom gas amount, making it suitable for contracts that require more gas to execute.
 * 
 * All methods can successfully transfer Ether to the `Receiver` contract. However, only the `Call` method can transfer to the `ReceiverWithExtraWork` contract, which requires more than 2300 gas units due to its additional operations.
 */


// The Receiver contract has a basic receive function to accept Ether.
contract Receiver {
    receive() external payable {}
}

// The ReceiverWithExtraWork contract also accepts Ether, but it does some additional work by incrementing a counter 1000 times.
contract ReceiverWithExtraWork {
    uint32 public count;

    receive() external payable {
        // This consumes additional gas.
        for (uint256 i = 0; i < 1e3; i++) {
            count++;
        }
    }
}

// The Transfer contract demonstrates the use of transfer(), which reverts on failure and forwards a fixed gas amount of 2300 units.
contract Transfer {
    uint32 constant _value = 100000;

    function transfer(address payable _to) external {
        console.log("Gas left before transaction", gasleft());
        _to.transfer(_value);
        console.log("Gas left after transaction", gasleft());
    }

    receive() external payable {}
}

// The Send contract demonstrates the use of send(), which returns a boolean indicating success but does not revert on failure.
contract Send {
    uint32 constant _value = 100000;

    function transfer(address payable _to) external {
        console.log("Gas left before transaction", gasleft());
        bool sent = _to.send(_value);
        console.log("Gas left after transaction", gasleft());
        console.log("Sent status:", sent);
    }

    receive() external payable {}
}

// The Call contract demonstrates the use of call(), which allows customizing the gas limit and returns a boolean for success.
contract Call {
    uint32 constant _value = 100000;

    function transfer(address _to, uint256 _gasOffer) external {
        console.log("Gas left before transaction", gasleft());
        (bool sent, ) = _to.call{value: _value, gas: _gasOffer}("");
        console.log("Gas left after transaction", gasleft());
        console.log("Sent status:", sent);
    }

    receive() external payable {}
}
