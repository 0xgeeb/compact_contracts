// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccConvex/cccvxCRV.sol";

contract cccvxCRVScript is Script {

  cccvxCRV cccvxcrv;

  function run() public {
    vm.startBroadcast();
    cccvxcrv = new cccvxCRV();
    vm.stopBroadcast();
  }

}