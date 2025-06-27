// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract AddressDataType {
    address public owner;
    address public contractAddress;

    constructor() {
        owner = msg.sender; 
        contractAddress = address(this); 
    }

    function getOwner() external view returns (address) {
        return owner;
    }

    function getContractAddress() external view returns (address) {
        return contractAddress;
    }
}