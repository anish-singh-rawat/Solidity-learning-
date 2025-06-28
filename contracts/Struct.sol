// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

// contract StructDemo {
//     struct student {
//         string name;
//         uint age;
//         uint class;
//         bool pass;
//     }
    
//     // using storage 
//     student public  s1;

//     function createStudent(string memory _name, uint  _age, uint _class, bool _pass) public {
//         s1.name  = _name;  
//         s1.age = _age;
//         s1.class = _class;
//         s1.pass = _pass;
//     }
// }


contract ArrayOfStruct {
    struct student {
        string name;
        uint age;
        uint class;
        bool pass;
    }
    
    student[] public  s1;

    function createStudents(uint index, string memory _name, uint  _age, uint _class, bool _pass) public {
        s1[index].name  = _name;  
        s1[index].age = _age;
        s1[index].class = _class;
        s1[index].pass = _pass;
    }

    function createStudentsdata(string memory _name, uint  _age, uint _class, bool _pass) public {
        s1.push(student(_name,_age,_class,_pass));
    }

}