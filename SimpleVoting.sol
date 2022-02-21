pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2; //standard

contract Voting {
    string[] public candidateList;
    
    // Store vote value of each candidate
    mapping (string => uint256) private votesReceived;
    
    constructor(string[] memory candidateNames) public {
        candidateList = candidateNames;
    }
    
    function voteForCandidate(string memory candidate) public {
        votesReceived[candidate] += 1;
    }
    
    // view function for private variable
    function totalVotesFor(string memory candidate)
        public view returns (uint256) {
            return votesReceived[candidate];
        }
        
    // length
    function candidateCount() public view returns (uint256) {
        return candidateList.length;
    }
}