// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccUmami/ccMarinateReceiver.sol";

contract ccMarinateReceiverScript is Script {

  ccMarinateReceiver ccmarinatereceiver;

  function run() public {
    vm.startBroadcast();
    ccmarinatereceiver = new ccMarinateReceiver();
    vm.stopBroadcast();
  }
}