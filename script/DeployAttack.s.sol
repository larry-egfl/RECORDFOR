// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/TelephoneAttack.sol";

contract DeployAttack is Script {
    function run() external {
        address instance = 0xB629B6Dac10D45D049C78116a7003189784fb6bd; // ← Ethernaut 给你的题目实例地址
        vm.startBroadcast();
        new TelephoneAttack(instance);
        vm.stopBroadcast();
    }
}
