// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract DynamicArray {
    uint [] public  arr;
    
    function setValueInArray(uint _val) public  returns (bool){
        arr.push(_val);
        return true;
    }

    function removeLastElement() public returns (bool ){
        arr.pop();
        return true ;
    }

    function length() public view returns(uint) {
        return arr.length;
    }
}