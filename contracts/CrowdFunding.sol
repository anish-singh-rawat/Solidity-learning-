// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract CrowdFunding {
   
    struct CrowdRequest {
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVotters;
        mapping (address => bool) voters;
    }

    mapping(address => uint) public  Contributers;
    mapping(uint =>  CrowdRequest) public  request;
    uint public  numOfrequest;
    address public  manager;
    uint public  minimContribution;
    uint public  deadline;
    uint public target;
    uint public raisedAmount;
    uint public  numberofContribution;

    constructor(uint _target,uint _deadline) {
        manager = msg.sender;
        target = _target;
        deadline = block.timestamp +  _deadline; 
        minimContribution = 100 wei;
    }

    modifier AdminAccess(){
        require(msg.sender == manager,"Sorry! access denied.");
        _;
    }

    function createRequest(string calldata _description, address payable  _recipient, uint _value) public AdminAccess {
        CrowdRequest storage newRequest = request[numOfrequest];
        numOfrequest++;
        newRequest.description = _description;
        newRequest.completed = false;
        newRequest.value = _value;
        newRequest.noOfVotters = 0;
        newRequest.recipient = _recipient;
    }

    function contribution() public payable  {
        require(block.timestamp < deadline, "Oop! contricution deadline has been passed.");
        require(msg.value >= minimContribution, "Please enter at least 100 wei");

        if(Contributers[msg.sender] == 0){
            numberofContribution++;
        }

        Contributers[msg.sender] += msg.value; 
        raisedAmount+=msg.value;           

    }


    function getContractBalance() public  view returns(uint){
        return address(this).balance;
    }


    function refund() public  {
        require(block.timestamp>deadline && raisedAmount<target, "Oop. You can't refund right now.");
        require(Contributers[msg.sender] >0,"Oops! you haven't contribute.");
        payable(msg.sender).transfer(Contributers[msg.sender]);
        Contributers[msg.sender] = 0;
    }

    function voteReuest(uint requestNum) public  {
       require(Contributers[msg.sender] >0,"Oops! you haven't contribute.");
       CrowdRequest storage thisRequest = request[requestNum];
       require(thisRequest.voters[msg.sender] == false,"Oops! you have already voted.");
       thisRequest.voters[msg.sender] = true;
       thisRequest.noOfVotters++;
    }

    function makePayment(uint _requestno) public AdminAccess {
        require(raisedAmount>= target,"Oop!!  target not reached.");
        CrowdRequest storage thisRequest = request[_requestno];
        require(thisRequest.completed == false, "Oops you have already made payment on the request");
        require(thisRequest.noOfVotters > numberofContribution/2, "Majority doesn't support right now.");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;

    }


}