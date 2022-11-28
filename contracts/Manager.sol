// SPDX-License-Identifier: MIT
pragma solidity >0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Ticket.sol";

contract Manager is Ownable {
    
    Ticket[] public ticketList;
    address managerAddress;

    receive() external payable {}

    fallback() external payable {}

    function createTicket(
        bytes32 _id,
        string memory _eventName,
        uint256 _eventDate,
        string memory _eventDescription,
        uint256 _price,
        address _ownerAddress,
       EventType _eventType,
       TransferStatus _transferStatus,
        TicketStatus _status

    ) public {
        Ticket ticket = new Ticket(
            _id,
            _eventName,
            _eventDate,
            _eventDescription,
            _price,
            _ownerAddress,
            _eventType,
            _transferStatus,
            _status
        );
        ticketList.push(ticket);
    }

    function showAllTickets(uint256 _totalTicket)
        public
        view
        returns (
            bytes32 newId,
            string memory newEventName,
            uint256 newEventDate,
            string memory newEventDescription,
            uint256 newPrice,
            address newOwner,
            EventType eventType,
            TicketStatus status
        )
    {
        return Ticket(ticketList[_totalTicket].showInformation());
    }

    function showTicketsbyAddress(address _ticketByAdrress)
        public
        view
        returns (
            bytes32 newId,
            string memory newEventName,
            uint256 newEventDate,
            string memory newEventDescription,
            uint256 newPrice,
            address newOwner,
            EventType eventType,
            TicketStatus status
        )
    {
        return Ticket(ticketList[_ticketByAdrress].showInformation());
    }

    function transferTickets(address _newOwner) public Ownable {
        owner = _newOwner;
        require(_newOwner != address(0));
    }

    function changeTicketPrice(uint256 _price, address receiver, uint amount) public payable Ownable {  
        uint256 comision = _price * 0.5;    //  cobrar comision
        uint256 PrecioFnal = _price + comision;
        managerAddress[ receiver] +=  comision[amount];
        
        PrecioFnal;
    }

    function showStatistics(uint256 _totalTicket, uint256 _totalMoney, uint _totalComision  ) public view returns (uint256) {
        uint256 _totalTicket = showAllTickets().length;
        uint256 _totalMoney = Ticket[price] * Ticket;
        uint256 _totalComision =  (_totalMoney * 0.5) * _totalTicket;


    }
}