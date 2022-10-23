// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccUmami/ccMarinateReceiver.sol";
import "../../src/ccUmami/ccMarinateV2.sol";

contract ccMarinateReceiverScript is Script {

  ccMarinateReceiver ccmarinatereceiver;
  ccMarinateV2 ccmarinatev2;

  function run() public {
    vm.startBroadcast();
    ccmarinatev2 = new ccMarinateV2();
    ccmarinatereceiver = new ccMarinateReceiver(address(ccmarinatev2));
    vm.stopBroadcast();
  }
}