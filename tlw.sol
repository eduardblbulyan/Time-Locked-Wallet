//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
contract TimeLockedWallet{
    address public owner;
    uint256 public unlockTime;
    uint256 balance;

    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed beneficiary, uint256 amount);

    modifier onlyOwner(){
        require(msg.sender == owner,"You're not the owner");
        _;
    }
    modifier onlyAfter(){
        require(block.timestamp >= unlockTime,"Not yet");
        _;
    }
    
}