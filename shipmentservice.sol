// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShipmentService {
    address owner;

    bool[] delieverd;
    struct Order{
        bool delivered;
        address custaddress;
        uint otp;
    }
    Order public order;
    Order[] orders;

    constructor(){
        owner = msg.sender;
    }
    modifier isowner {
        msg.sender == owner;
        _;
    }
    modifier iscustomer {
        msg.sender != owner;
        _;
    }
    //This function inititates the shipment
    function shipWithPin(address customerAddress, uint pin) public isowner{
        order.otp = pin;
        order.delivered = false;
        order.custaddress = customerAddress;
        orders.push(order);
    }

    //This function acknowlegdes the acceptance of the delivery
    function acceptOrder(uint pin) public iscustomer{
        require(pin == order.otp);
        order.delivered = true;
    }

    //This function outputs the status of the delivery
    function checkStatus(address customerAddress) public iscustomer returns (uint){
    }

    //This function outputs the total number of successful deliveries
    function totalCompletedDeliveries(address customerAddress) public returns (uint) {
        return orders.length;
    }
}