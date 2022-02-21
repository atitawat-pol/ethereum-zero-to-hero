pragma solidity ^0.5.0;

contract Type {
	uint256[4] public a = [1,2,3,4]; // fix length array

	function setArrayValue(uint256 index, uint256 value) public {
		a[index] = value;
	}
}