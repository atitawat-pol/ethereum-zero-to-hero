pragma solidity ^0.5.0;

contract AccessModifier {
	uint256 public a = 4; // can be read from outside
	uint256 internal b = 5; // Can be inherited to another contract
	// ! don't left is blank
	uint256 c = 6; // Default access is internal
	uint256 private myPrivate = 7; // Accessible only from this contract

	// external can be used at functin layer
	// change external to public
	function getA() public view returns(uint256) {
		return a;
	}

	// function view can call function view
	// function write can call function view
	// reduce gas from memory to callData
	function getAinA() external view returns(uint256) {
		// function getA() can not be seen bc. it is external function
		return getA();
	}
}

contract AccessModifier2 is AccessModifier {
	function readA() public view returns (uint256) {
		return a;
	}

	function readB() public view returns (uint256) {
		return b;
	}

	function readC() public view returns (uint256) {
		return c;
	}
}