// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccSushi/ccSushiBar.sol";

contract ccSushiBarScript is Script {

  function run() public {
    vm.startBroadcast();
    ccSushiBar ccsushibar = new ccSushiBar();
    vm.stopBroadcast();
  }
}