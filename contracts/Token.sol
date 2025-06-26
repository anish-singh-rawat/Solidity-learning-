// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract Token {
        string public name = "Hardhad token";
        string public symbol = "HDT";
        uint public totalSupply = 10000;

        address public owner;

        mapping(address => uint) balances;

        constructor(){
            balances[msg.sender] = totalSupply;
            owner = msg.sender;
        }


        function Transfer(address to , uint amount) external {
            console.log("balances[msg.sender] called", balances[msg.sender]);
            require(balances[msg.sender] >=  amount, "Not ebough tokens");
            balances[msg.sender] -= amount;
            balances[to] += amount; 
        }

        function balanceOf(address account) external view returns(uint) {
            return balances[account];
        }
}