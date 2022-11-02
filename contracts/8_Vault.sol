// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/*
  storage slot
  step: call web3.eth.getStorageAt("contract address", 1, console.log)
*/

// source code
contract Vault {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) public {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}