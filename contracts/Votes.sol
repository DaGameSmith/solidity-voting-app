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
    mapping(string => bool) public isvotee;
    string[] public voteelist = ["mac", "windows", "linux"];

    function registerVoter() external{
        require(owner != msg.sender, "owner of this contract can not call this function");
        voters[msg.sender] = true;
        voted[msg.sender] = false;
    }

    function initVotees() external{
        require(owner == msg.sender, "only the owner of this contract can call this function");
        // votees["mac"] = 0;
        // votees["windows"] = 0;
        // votees["linux"] = 0;
        for(uint i=0; i<voteelist.length; i++){
            votees[voteelist[i]] = 0;
            isvotee[voteelist[i]] = true;
        }
    }

    function vote(string calldata ostype) external{
        require(voters[msg.sender] == true, "you are not registered");
        require(voted[msg.sender] != true, "you already voted");
        require(isvotee[ostype] == true, "invalid voting option, check the public list voteelist to see valid voting options");
        votees[ostype] += 1;
        voted[msg.sender] = true; 
    }

    function voteresult() public view returns(string[] memory, uint[] memory) {
        string[] memory mvotees = new string[](voteelist.length);
        uint[] memory mvotes = new uint[](voteelist.length);

        for(uint i=0; i<voteelist.length; i++){
            mvotees[i] = voteelist[i];
            mvotes[i] = votees[voteelist[i]]; 
        }       

        return (mvotees, mvotes);
    }
}