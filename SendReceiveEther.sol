pragma solidity ^0.5.0;

contract SendReceiveEther {

	// SmartContract can receive token with this function
	function sendEther() public payable {
		// fail when missing "payable"
	}

	function getContractBalance() public view returns(uint256) {
		// this = this contract
		// convert this to address
		return address(this).balance;
	}

	// can withdraw token from this smartContract
	function withdraw(uint256 amount) public {
		// transfer this amount to msg.sender(caller)
		msg.sender.transfer(amount);
	}
}