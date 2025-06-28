// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract SendEther {
    function sendEtherToContract () public  payable {

    }  

    function getEthBalance () public  view returns (uint){
        return address(this).balance;
    } 

    // This function is used to send ether to a specific address
    // It requires the sender to send at least 1 ether
    
    function sendEtherToAddress (address payable _to) public  payable {
        require(msg.value > 0, "You must send at  1 ether");
        _to.transfer(msg.value);
    }

    // The function is payable, meaning it can receive ether
    // The address to which the ether is sent must be marked as payable

     function sendEtherToUserAddress (address payable user_address) public  payable {
        require(msg.value > 0, "You must send at least 1 ether");
        user_address.transfer(msg.value);
    }
}