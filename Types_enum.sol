pragma solidity ^0.5.0;

contract Type {
	// enum is like integer but kept actions
	enum Action {
		Left,
		Right,
		Top,
		Bottom
	}

	Action public action;

	function a() public {
		// .....
		action = Action.Left;
		//action = Action.Bottom;
		// .....
	}
}