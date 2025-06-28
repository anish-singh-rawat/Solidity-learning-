// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract ArrayMapping {
    mapping (uint => uint[]) public ArrMapData;

    function insertArrMap(uint index, uint[] memory numbers) public {
        ArrMapData[index] = numbers;
    }


    function GetArrMap(uint index) public  view returns(uint[] memory){
        return ArrMapData[index];
    }
}