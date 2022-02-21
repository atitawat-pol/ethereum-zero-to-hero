pragma solidity ^0.5.0;

contract GlobalVariable {
	uint256 public latestActionBlockNumber;

	function saveBlockNumber() public {
		// get block number in code 
		latestActionBlockNumber = block.number;
	}
}