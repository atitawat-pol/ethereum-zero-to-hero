// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';

contract CoreBank is Ownable {
	using SafeMath for uint256;

	// dictionary that map addresses to balances
	mapping(address => uint256) public balances;

	// Users to system
	address[] accounts;

	// interest rate
	uint256 rate = 3;

	// Events - User
	event DepositMade(address indexed accountAddress, uint256 amount);
	event WithdrawMade(address indexed accountAddress, uint256 amount);

	// Events - system
	event SystemDepositMade(address indexed admin, uint256 amount);
	event SystemWithdrawMade(address indexed admin, uint256 amount);
	event PayDividendMade(address indexed admin, uint256 totalInterest);

	// caller address for ^0.8.0
	address caller;

	// this function is read because "payable"
	// don't need any arguments
	function deposit() public payable returns (uint256) {
		// if new user
		if (0 == balances[msg.sender]) {
			accounts.push(msg.sender);
		}

		balances[msg.sender] = balances[msg.sender].add(msg.value);

		// broadcast deposit event
		emit DepositMade(msg.sender, msg.value);

		return balances[msg.sender];
	}

	function withdraw(uint256 withdrawAmount) public returns (uint256 remainingBalance) {
		require(balances[msg.sender] >= withdrawAmount, "amount to withdraw is not enough!"); // only owner can withdraw
		balances[msg.sender] = balances[msg.sender].sub(withdrawAmount);

		// Transfer Ether back to user, will revert on failed
		payable(caller).transfer(withdrawAmount);

		// return balances[msg.sender];
		remainingBalance = balances[msg.sender]; // don't need "return"

		// Broardcast WithdrawMade event
		emit WithdrawMade(msg.sender, withdrawAmount);
	}

	// Check balance of the smart contract
	function systemBalance() public view returns (uint256) {
		// address(this) refers to the address of the instance of the contract where the call is being
		return address(this).balance;
	}

	function systemWithdraw(uint256 withdrawAmount) public onlyOwner returns (uint256) {
		require(withdrawAmount <= systemBalance(), "amount to withdraw is not enough");

		payable(caller).transfer(withdrawAmount);

		// Broardcast event
		emit SystemWithdrawMade(msg.sender, withdrawAmount);

		return systemBalance();
	}

	// payable = can deposit ETH
	function systemDeposit() public onlyOwner payable returns (uint256) {
		// Broardcast event
		emit SystemDepositMade(msg.sender, msg.value);

		return systemBalance();
	}

	// interest per year
	function calculateInterest(address user, uint256 _rate) private view returns (uint256) {
		uint256 interest = balances[user].mul(_rate).div(100);
		return interest;
	}

	// interest per year for External User
	function totalInterestPerYear() external view returns(uint256) {
		uint256 totalInterest = 0;
		for (uint256 i = 0; i < accounts.length; i++) {
			address account = accounts[i];
			uint256 interest = calculateInterest(account, rate);
			totalInterest = totalInterest.add(interest);
		}
		return totalInterest;
	}

	// Calculate 
	function payDividendPerYear() public onlyOwner payable {
		uint256 totalInterest = 0;

		// #! High Gas O(n)
		for (uint256 i = 0; i < accounts.length; i++) {
			address account = accounts[i];
			uint256 interest = calculateInterest(account, rate);
			balances[account] = balances[account].add(interest);
			totalInterest = totalInterest.add(interest);
		}
		require(msg.value == totalInterest, "Not enough interest to pay");

		// Broardcast event
		emit PayDividendMade(msg.sender, totalInterest);
	}
}