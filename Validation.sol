pragma solidity ^0.5.0;

contract Validation {
	bool public pause;

	address public owner;

	constructor() public {
		owner = msg.sender;
	}

	modifier onlyOwner() {
		require(msg.sender == owner);
		_; // then call the rest in caller
	}

	// preventing double pause
	modifier onlyNotPause() {
		require(pause == false);
		_;
	}

	function pauseSmartContract() public onlyOwner onlyNotPause {

		// owner can pause
		pause = true;
	}
}