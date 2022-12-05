// SPDX-License-Identifier: MIT
pragma solidity >0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Ticket.sol";

contract Manager is Ownable {
    Ticket[] public ticketList;
    address managerAddress;

    mapping(address => Ticket[]) listTicket;

    event TicketCreated(
        string eventName,
        uint256 eventDate,
        string eventDescription,
        uint256 price
    );

    receive() external payable {}

    fallback() external payable {}

    function createTicket(
        string memory _eventName,
        uint256 _eventDate,
        string memory _eventDescription,
        uint256 _price
    ) public onlyOwner {
        Ticket ticket = new Ticket(
            _eventName,
            _eventDate,
            _eventDescription,
            _price,
            msg.sender
        );

        emit TicketCreated(_eventName, _eventDate, _eventDescription, _price);

        ticketList.push(ticket);
    }

    function showAllTickets() public view {
        uint256 totalTickets = 0;
        for (uint256 i; i < ticketList.length; i++) {
            totalTickets = totalTickets + 1;
        }
        totalTickets;
    }

    function showTicketsbyAddress(address ownerAdd) public view {
        for (uint256 i; i < ticketList.length; i++) {
            ownerAdd;
        }
    }

    function transferTickets(address _newOwner) public view onlyOwner {
        _newOwner;
        require(_newOwner != address(0));
    }

    function changeTicketPrice(
        uint256 _price,
        uint256 comision,
        uint256 amount,
        uint256 porcentajeComision
    ) public payable onlyOwner {
        _price;
        porcentajeComision = 5; //porcentaje de comision
        comision = (_price + porcentajeComision) / 100; // comision por titcket

        // envio comision al manager
        (bool sent, ) = managerAddress.call{value: amount}("");

        require(sent == true, "Transaction cannot be sent");
    }

    

    function showStatistics() public view {
        showAllTickets();
  
    }
}
