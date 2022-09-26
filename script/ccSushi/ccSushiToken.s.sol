// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccSushi/ccSushiToken.sol";

contract ccSushiTokenScript is Script {

  ccSushiToken ccsushitoken;

  function run() public {
    vm.startBroadcast();
    ccsushitoken = new ccSushiToken(0x5FbDB2315678afecb367f032d93F642f64180aa3);
    vm.stopBroadcast();
  }
}