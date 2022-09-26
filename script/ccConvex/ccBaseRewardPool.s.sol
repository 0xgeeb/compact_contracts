// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccConvex/ccBaseRewardPool.sol";
import "../../src/ccConvex/ccCVX.sol";
import "../../src/ccConvex/cccvxCRV.sol";

contract ccBaseRewardPoolScript is Script {

  ccBaseRewardPool ccbaserewardpool;
  ccCVX cccvx;
  cccvxCRV cccvxcrv;

  function run() public {
    vm.startBroadcast();
    cccvx = new ccCVX();
    cccvxcrv = new cccvxCRV();
    ccbaserewardpool = new ccBaseRewardPool(address(cccvxcrv), address(cccvx), msg.sender);
  }

}