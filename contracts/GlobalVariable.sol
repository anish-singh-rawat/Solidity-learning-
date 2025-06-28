// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract GlobalVariable {
    function getCallAddress() public  view returns(address){
        return msg.sender;
    }

     function getTimeStamp() public  view returns(uint){
        return block.timestamp;
    }

     function getBlockNumber() public  view returns(uint){
        return block.number;
    }

     function getGasLeft() public  view returns(uint){
        return gasleft();
    }

     function getChainId() public  view returns(uint){
        return block.chainid;
    }
    
     function getCurrentBlockHash() public  view returns(bytes32){
        return blockhash(block.number - 1);
    }

     function getTxOrigin() public  view returns(address){
        return tx.origin;
    }
}