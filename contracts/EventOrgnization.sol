// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

contract EventOrgnization {
    struct Event {
        address orgnizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemaning;
    }

    mapping(uint => Event) public  events;
    mapping (address => mapping(uint=> uint) ) public tickets;
    uint public  nextId;
    
    function createEvent(string calldata _name, uint _date,uint _price, uint _ticketCount ) public {
         require(block.timestamp < _date, "Oop! you can't create event for past date.");
         require(_ticketCount >0,"ticket count much be grater than 0 ");
         events[nextId] = Event(msg.sender,_name, _date, _price,_ticketCount,_ticketCount);
         nextId++;

    }

    function buyTickets(uint id, uint quantity) public payable {
          require(events[id].date != 0, "Event doesn't exist!");
          require(events[id].date != block.timestamp, "Event has been expired!");
          Event storage _event = events[id];
          require(msg.value == (_event.price*quantity), "Ether is not enough");
          require(_event.ticketRemaning >= quantity, "Tickets are sold out.");
          _event.ticketRemaning -= quantity;
          tickets[msg.sender][id] += quantity;
    }

    function transferTickets(uint id, uint quantity, address to) public {
         require(events[id].date != 0, "Event doesn't exist!");
          require(events[id].date != block.timestamp, "Event has been expired!");
          require( tickets[msg.sender][id] >= quantity, "Opps your are not owner of this ticket.");
           tickets[msg.sender][id] -= quantity; 
           tickets[to][id] += quantity;
    }
}



