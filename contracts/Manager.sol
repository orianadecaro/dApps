// SPDX-License-Identifier: MIT
pragma solidity >0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Ticket.sol";

contract Manager is Ownable {
    Ticket[] public ticketList;
    address managerAddress;

    mapping(address => Ticket[]) listTicket;

    event TicketCreated(
        bytes32 id,
        string eventName,
        uint256 eventDate,
        string eventDescription,
        uint256 pricea,
        address newOwner
    );

    receive() external payable {}

    fallback() external payable {}

    function createTicket(
        string memory _eventName,
        uint256 memory _eventDate,
        string memory _eventDescription,
        uint256 _price
    ) public payable {
        emit TicketCreated(
            _eventName,
            _eventDate,
            _eventDescription,
            _price,
            block.timestamp
        );

        return ticketList.push(Ticket);
    }

    function showAllTickets() public view returns (uint256) {
        uint256 totalTickets = 0;
        for (uint256 i; i < ticketList.length; i++) {
            totalTickets += ticketList[i].id;
        }
        return totalTickets;
    }

    function showTicketsbyAddress() public view returns (uint256) {
        uint256 totalTicketsbyAddress = 0;
        for (uint256 i; i < ticketList.length; i++) {
            totalTicketsbyAddress += ticketList[i].owner;
        }
        return totalTicketsbyAddress;
    }

    function transferTickets(address _newOwner) public Ownable {
        owner = _newOwner;
        require(_newOwner != address(0));
    }

    function changeTicketPrice(
        uint256 _price,
        address receiver,
        uint256 amount
    ) public payable Ownable {
        _price = _price;
        uint256 comision = _price * 0.5; //  cobrar comision
        uint256 PrecioFnal = _price + comision;
        managerAddress[receiver] += comision[amount];
    }

    function showStatistics(
        uint256 _totalTickets,
        uint256 _totalMoney,
        uint256 _totalComision,
        uint256 _price
    ) public view returns (uint256) {
        _totalTickets = showAllTickets().length;
        _totalMoney = Ticket(_price) * _totalTickets;
        _totalComision = (_totalMoney * 0.5) * _totalTickets;
    }
}