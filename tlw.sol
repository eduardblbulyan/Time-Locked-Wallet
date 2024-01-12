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
    constructor(address _owner, uint256 _unlockTime){
        owner = _owner;
        unlockTime = _unlockTime;
    }
    function deposit() external payable onlyOwner{
        require(msg.value>0,"Value must be greater than 0");
        balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw() external onlyAfter onlyOwner{
        require(balance>0,"No funds available");
        payable(owner).transfer(balance);
        emit Withdrawal(owner, balance);
        balance = 0;
    }
}