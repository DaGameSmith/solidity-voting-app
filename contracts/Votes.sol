// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Votes {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => bool) public voters;
    mapping(address => bool) public voted;
    mapping(string => uint) public votees;

    function registerVoter() external{
        require(owner != msg.sender, "owner of this contract can not call this function");
        voters[msg.sender] = true;
        voted[msg.sender] = false;
    }

    function initVotees() external{
        require(owner == msg.sender, "only the owner of this contract can call this function");
        votees["mac"] = 0;
        votees["windows"] = 0;
        votees["linux"] = 0;
    }

    function vote(string calldata ostype) external{
        require(voters[msg.sender] == true, "you are not registered");
        require(voted[msg.sender] != true, "you already voted");
        votees[ostype] += 1;
        voted[msg.sender] = true; 
    }

    // function max(uint a, uint b) private pure returns (uint) {
    //     return a >= b ? a : b;
    // }

    // function voteresult() public view returns(string memory) {
    
    // }
}