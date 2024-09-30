// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Voting Contract
contract Voting {
    // Proposal Structure
    struct Proposal {
        string name;      // Name of the proposal
        uint256 voteCount; // Number of votes received
    }

    // State Variables
    mapping(address => bool) public voters; // Track if an address has voted
    Proposal[] public proposals; // Array of proposals

    // Function to create a new proposal
    function createProposal(string memory _name) public {
        proposals.push(Proposal(_name, 0));
    }

    // Function to cast a vote for a specific proposal
    function vote(uint256 _proposalIndex) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_proposalIndex < proposals.length, "Proposal does not exist.");

        voters[msg.sender] = true;
        proposals[_proposalIndex].voteCount++;
    }

    // Function to retrieve proposal details
    function getProposal(uint256 _proposalIndex) public view returns (string memory, uint256) {
        require(_proposalIndex < proposals.length, "Proposal does not exist.");
        return (proposals[_proposalIndex].name, proposals[_proposalIndex].voteCount);
    }
}
