// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Attack {
    function attack(address target) external returns(address solver) {
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, shl(0x68, 0x69602a60005260206000f3600052600a6016f3))
            solver := create(0, ptr, 0x13)
        }
        MagicNum(target).setSolver(solver);
    }
}

// source code
contract MagicNum {

  address public solver;

  constructor() public {}

  function setSolver(address _solver) public {
    solver = _solver;
  }

  /*
    ____________/\\\_______/\\\\\\\\\_____        
     __________/\\\\\_____/\\\///////\\\___       
      ________/\\\/\\\____\///______\//\\\__      
       ______/\\\/\/\\\______________/\\\/___     
        ____/\\\/__\/\\\___________/\\\//_____    
         __/\\\\\\\\\\\\\\\\_____/\\\//________   
          _\///////////\\\//____/\\\/___________  
           ___________\/\\\_____/\\\\\\\\\\\\\\\_ 
            ___________\///_____\///////////////__
  */
}
