// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract lotteryContract {
    // This is a simple lottery contract that allows users to enter the lottery by sending ether
    // The contract keeps track of the players and the total amount of ether in the contract
    // The owner can pick a winner and transfer the total amount of ether to the winner

    address public owner;
    address[] public players;
    uint public totalAmount;

    constructor() {
        owner = msg.sender;
    }

    function enter() public payable {
        require(msg.value > 0, "You must send at least 1 ether");
        players.push(msg.sender);
        totalAmount += msg.value;
    }

    function pickWinner() public {
        require(msg.sender == owner, "Only the owner can pick a winner");
        require(players.length > 0, "No players in the lottery");

        uint winnerIndex = random() % players.length;
        address winner = players[winnerIndex];
        payable(winner).transfer(totalAmount);

        // Reset the lottery
        players = new address[](0);
        totalAmount = 0;
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length)));
    }

}