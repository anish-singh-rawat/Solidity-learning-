// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract Mappings {
    struct myDetails {
        string name;
        string role;
        uint cgp;
        string comapny;
        bool fresher; 
    }
    mapping (uint => myDetails) public  mydata;

    mapping(uint => string) public  data;
    
    function insertMydata(uint index, string memory _name , string memory _role, uint _cgp, string memory _comapny, bool  _fresher) public {
        mydata[index] = myDetails(_name , _role,  _cgp,   _comapny, _fresher);
    }


    function getMyData(uint index)public view returns(myDetails memory) {
      return  mydata[index];
    }

    function insertValue(uint _roll, string memory _name) public {
        data[_roll] = _name;
    }

    function getter(uint _roll) public view returns(string memory){
        return data[_roll];
    }
}
