// SPDX-License-Identifier: MIT
pragma solidity >0.8.7;

contract Ticket {
    bytes32 private id;
    string public eventName;
    uint256 public eventDate;
    string public eventDescription;
    uint256 public price;
    address public owner;

    enum TicketStatus {
        valid,
        used,
        expired
    }

    enum TransferStatus {
        transferible,
        no_transferible
    }

    enum EventType {
        sport,
        music,
        cinema
    }


  EventType public eventType;
    TransferStatus public transferStatus;
    TicketStatus public status;

    constructor(
        bytes32 newId,
        string memory newEventName,
        uint256 newEventDate,
        string memory newEventDescription,
        uint256 newPrice,
        address newOwner
     
    ) {
        id = newId;
        eventName = newEventName;
        eventDate = newEventDate;
        eventDescription = newEventDescription;
        price = newPrice;
        owner = newOwner;
       
    }

    function changePrice(uint256 _newPrice) public {
        price = _newPrice;
    }

    function changeTransferStatus(uint256 _newTransferStatus) public {
        transferStatus = TransferStatus(_newTransferStatus);
    }

    function changeStatus(uint256 _newTicketStatus) public {
        status = TicketStatus(_newTicketStatus);
    }

    function changeOwner(address _newOwner) public {
        owner = _newOwner;
         require(_newOwner != address(0));
    }

    function generateId(
        string memory _text,
        uint256 _num,
        address _addr
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }

    function showInformation()
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
            TransferStatus transferStatus,
            TicketStatus status
        )
    {
        id;
        eventName;
        eventDate;
        eventDescription;
        price;
        owner;
        eventType;
        transferStatus;
        status;
    }
}
