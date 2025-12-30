// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract BuyCoffee {
   address public owner;
   uint256 public coffeePrice = 0.001 ether;
   mapping(address => uint256) public coffeesBought;


   event CoffeePurchased(address indexed buyer, uint256 quantity, uint256 amount);
   event FundsWithdrawn(address indexed owner, uint256 amount);


   constructor() {
       owner = msg.sender;
   }


   modifier onlyOwner() {
       require(msg.sender == owner, "Only owner allowed");
       _;
   }


   function buyCoffee(uint256 quantity) external payable {
       require(quantity > 0, "Quantity must be greater than 0");
       uint256 totalCost = coffeePrice * quantity;
       require(msg.value == totalCost, "Incorrect ETH sent");
       coffeesBought[msg.sender] += quantity;
       emit CoffeePurchased(msg.sender, quantity, msg.value);
   }


   function withdraw() external onlyOwner {
       uint256 balance = address(this).balance;
       require(balance > 0, "No funds available");
       (bool success, ) = owner.call{value: balance}("");
       require(success, "ETH transfer failed");
       emit FundsWithdrawn(owner, balance);
   }


   function getContractBalance() external view returns (uint256) {
       return address(this).balance;
   }
}
