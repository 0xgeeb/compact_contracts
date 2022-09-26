// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccConvex/ccCVX.sol";

contract ccCVXScript is Script {

  ccCVX cccvx;

  function run() public {
    vm.startBroadcast();
    cccvx = new ccCVX();
    vm.stopBroadcast();
  }

}