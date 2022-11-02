// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/*
  storage slot
  web3.eth.getStorageAt()
*/

contract Attack {
  bytes32[3] private data;

  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  
  function get() public view returns (bytes16) {
      return bytes16(data[2]);
  }
}

// source code
contract Privacy {

  bool public locked = true;                  // slot0
  uint256 public ID = block.timestamp;        // slot1
  uint8 private flattening = 10;              // slot2
  uint8 private denomination = 255;           // slot2
  uint16 private awkwardness = uint16(now);   // slot2
  bytes32[3] private data;                    // slot3,4,5

  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }
}