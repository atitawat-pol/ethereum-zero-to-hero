pragma solidity ^0.5.0;

contract Type {
	address public user;

	constructor() public {
		user = msg.sender;
	}
}