// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../lib/forge-std/src/Script.sol";
import "../src/ccSushi/ccSushiMaker.sol";

contract ccSushiMakerScript is Script {

  function run() public {
    vm.startBroadcast();
    ccSushiMaker ccsushimaker = new ccSushiMaker();
    vm.stopBroadcast();
  }
}