// SPDX-License-Identifier: MIT
pragma solidity >0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Ticket.sol";

contract Manager is Ownable {
    Ticket[] public ticketList;
    address managerAddress;

   mapping(address => Ticket[]) listTicket;

    receive() external payable {}

    fallback() external payable {}

    function createTicket(
        string memory _eventName,
        uint256 _eventDate,
        string memory _eventDescription,
        uint256 _price
       
    ) public payable Ownable{
        
        address  owner = msg.sender;
        bytes32 id = generateId();
        EventType _eventType = EventType.SPORT;
        TicketStatus _status = TicketStatus.VALID;
        TransferStatus _transferStatus = TransferStatus.TRANSFERIBLE;

        Ticket ticket = new Ticket(
             id,
            _eventName,
            _eventDate,
            _eventDescription,
            _price,
            owner,
            _price,
            _status,
            _transferStatus,
            _eventType
        );
        return ticketList.push(ticket);
    }

    function showAllTickets() public view returns (uint256)  {
        
        uint256 totalTickets = 0;
        for(uint256 i; i < ticketList.length; i++) {
            totalTickets += ticketList[i].id;
        }
        return totalTickets;
        
        
    }

    function showTicketsbyAddress() public view returns (uint256) {
         
        uint256 totalTicketsbyAddress = 0;
        for(uint256 i; i < ticketList.length; i++) {
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
    ) public payable Ownable  {
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


