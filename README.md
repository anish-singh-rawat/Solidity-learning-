# Solidity Learning Journey 🚀

## 📅 Duration
**Start Date:** 15th June  
**End Date:** 30th July  
**Total:** 45 Days  

## 🎯 Objective
This repository is dedicated to **Solidity learning** over a focused 45-day period.  
The goal is to build a strong foundation in Solidity smart contract development through consistent daily learning and hands-on coding.

## 📚 Topics to Cover
- Basics of Solidity
- Smart Contract Syntax
- Data Types and Functions
- Inheritance and Modifiers
- Events and Error Handling
- ERC-20 and ERC-721 Standards
- Security Best Practices
- Gas Optimization
- Testing and Deployment
- Integration with Frontend

## 📝 Progress Tracking
Daily learning, code snippets, project files, and notes will be added to this repository.

## ✅ Milestones
- [ ] Week 1: Solidity Basics & Smart Contract Structure
- [ ] Week 2: Data Types, Functions & Conditionals
- [ ] Week 3: Intermediate Concepts & Projects
- [ ] Week 4: ERC Standards, Security & Gas Optimization
- [ ] Week 5: Testing, Deployment & Integration

---

**Let's stay consistent and hit the target! 💪**

# 1st week reading...


**Basic Data types**


## Integer data type 
- use uint and int data type in our project.

## Bool data type 
- use Bool data type

## Address data type 
- use to save or store the contract or wallet address




## Reference data types

**Strings**

**Arrays**

**Mapping**

**Struct**



## Data Location

**Memory**
- lifetime is limited to an external function call. (majorly we use it when we use refrence data type in funcitons argument)
- we can modify the value of function arguments variable while using refrence data types.
- memmory keyword also can be used inside a function but it can't change the value of state variable.

**Storage**
- the location where the state variables are stored, where the lifetime is limited to the lifetime of a contract.
- when we declare state variable they store inside the storage as a permanentn formate.
- storate keyword help us to access the state variable inside the function to modify state varibale 

**Call data**
- special data location that contains the function arguments.
- if we use call data with function argument in refrence data type than we can't change the any value of function arguments variable 
- calll data can only be used with function arguments.



**Struct data type**
-   struct data type is usually a composite of other existing data type. it can hold mutiple data types like (String , number , array other...)
- usually it is use to store the value for details where string, number and array are needed.

struct Studnet {
    string name;
    uint roll;
    boll pass; 
    string[] subjects; 
}

Student public s;


**Array of struct**
-  struct Studnet {
    string name;
    uint roll;
    boll pass; 
    string[] subjects; 
}

Student[4] public s;

let's assumet we want to store 4 studnet data.


**Mapping**
- Concepy of key and value.
- mapping(key => value).
- mapping(uint => string) public data.
- using the map it don't create empty slots if the data does't present
-like : if data is in 1,4,6 index then there will be no empty index : 0,2,3,5 but in the case of array it create empty slots if data doesn't present.
- maping are much faster than array.
- mapping store data in non - contiguous fashion while array store data in a contuguous fashion.
- mapping are not-ierable while array are iterable  


**Nested Mapping**
- mapping(address => mapping(uint => bool/ data)) private check;
- Nested maaping are just like a 2D array where we store data in table (row and coloum formate)



## Globle variable of solidity 


**Special Variables and Functions**
- There are special variables and functions which always exist in the global namespace and are mainly used to provide information about the blockchain or are general-use utility functions.


**blockhash(uint blockNumber)** 
- returns (bytes32): hash of the given block when blocknumber is one of the 256 most recent blocks; otherwise returns zero

**blobhash(uint index)** 
- returns (bytes32): versioned hash of the index-th blob associated with the current transaction. A versioned hash consists of a single byte representing the version (currently 0x01), followed by the last 31 bytes of the SHA256 hash of the KZG commitment (EIP-4844). Returns zero if no blob with the given index exists.

**block.basefee (uint):** 
- current block’s base fee (EIP-3198 and EIP-1559)

**block.blobbasefee (uint):** 
- current block’s blob base fee (EIP-7516 and EIP-4844)

**block.chainid (uint):**
- current chain id

**block.coinbase (address payable):**
- current block miner’s address

**block.difficulty (uint):**
- current block difficulty (EVM < Paris). For other EVM versions it behaves as a deprecated alias for block prevrandao (EIP-4399 )


**block.gaslimit (uint):** 
- current block gaslimit

**block.number (uint):**
- current block number

**block.prevrandao (uint):** random number provided by the beacon chain (EVM >= Paris)

**block.timestamp (uint):** 
- current block timestamp as seconds since unix epoch

**gasleft() returns (uint256):** 
- remaining gas

**msg.data (bytes calldata):** 
- complete calldata

**msg.sender (address):** 
- sender of the message (current call)

**msg.sig(bytes4):** 
- first four bytes of the calldata (i.e. function identifier)

**msg.value (uint):** 
- number of wei sent with the message

**tx.gasprice (uint):** 
- gas price of the transaction

**tx.origin (address):** 
-sender of the transaction (full call chain)



## Daily usefull keywords

**View**
- whenever we are reading the state variable we write this view keyword.


**Pure**
- whenever reading or writing in local variable on that time we use it.

**Memory Keyword**
- whenevery we use any refrence data type in our function at that time we use memory keyword

**No Keyword**
- whenever we change the state of globle variable on that time we don't need to use any keyword.

**Conditions**
- use if, else, revert, modifier and require statement conditions for testing, also use bool data type for returning boolean data type.

**Payable**
- this keyword is use to send the token transaction in ethereun 

## Loops

**While lopp**
- learn syntex of while loop.


**do while lopp**
- learn syntex of do while loop.


**For loop**
- learn syntex of for loop.



## Hardhad Testing

**Writing code**
- learn about how to write test code using ether.js library usign hardhad for our solidity smart contract.

**Testing code**
- test the whole backend solidity project for test there backend api using hardhad and ether.js library.

**Deploying code**
- deploy our contract on testnet using hardhat and alkaimy for testing it in test network.



# Solidity Projects :


## Lotterly winner
- create a samrt contract for lottery winner where the user need to pay at least 1 Ether to enter in the game and only owner of the contract can pick the winner based on random function not from owner end and after getting the winner all the ethereum will be transfer in there account.


## Crowdfunding
- Crowdfunding is the practice of funding a project or venture by raising money from a large number of people.
- we are create a smart contract on ethereum so contributer will fund ether to our smart contract and this smart contract will fund ether to good  cause or whatever cuase that has been submited. 
- though this we are totally replacing centeral autority from this smart contract where we are going to mention each and every roles and smart contract will be publically  


## EventOrgnization
- 