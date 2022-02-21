pragma solidity ^0.5.0;

library SafeMath {
	function sub(uint25 a, uint256 b) internal pure returns (uint256) {
		requre(b <= a, "SafeMath: suctraction overflow");
		uint256 c = a - b;

		return c;
	}

	function add(uint256 a, uint256 b) internal pure returns (uint256) {
		uint256 c = a + b;
		require(c >= a, "SafeMath: addition overflow");

		return c;
	}
}

contract TestLibrary {
	using SafeMath for uint256;

	function minus(uint256 a, uint256 b) public view returns(uint256) {

		// a is the first param, b is the second parm
		return a.sub(b);
	}

	function add(uint256 a, uint256 b) public pure returns (uint256) {
		return a.add(b);
	}
}