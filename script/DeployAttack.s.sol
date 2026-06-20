// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/CoinFlipAttack.sol";

contract DeployAttack is Script {
    function run() external {
        address instance = 0x010AF27c00D40e6e513d83e40FFaCc699eDA08Bc; // ← Ethernaut 给你的题目实例地址
        vm.startBroadcast();
        new CoinFlipAttack(instance);
        vm.stopBroadcast();
    }
}
