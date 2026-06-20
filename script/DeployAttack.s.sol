// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/TokenAttack.sol";

contract DeployAttack is Script {
    function run() external {
        address instance = 0x08687D811BB8389D7893dC4977D0bB4d397Bd2ad; // ← Ethernaut 给你的题目实例地址
        vm.startBroadcast();
        new TokenAttack(instance);
        vm.stopBroadcast();
    }
}
