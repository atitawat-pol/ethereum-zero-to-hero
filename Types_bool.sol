pragma solidity ^0.5.0;

contract Type {
	bool public a = true;
	bool public b = false;
	bool public c; // default: false

	function setA(bool newA) public {
		a = !newA;
	}

	function isAEqualToB() public view returns (bool) {
		return a == b;
	}
}