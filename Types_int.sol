pragma solidity ^0.5.0;

contract Type {
	int public a = 8;
	uint8 public b = 255; // max 2**8 = 0-255
	
	int c; // int256
	uint d; //uint256

	function compute() public view returns (uint256) {
		uint256 result = uint256(a) + uint256(b); // a, b is are different types
		if (result > 200) {
			// do something
		}
		return result;
	}
}