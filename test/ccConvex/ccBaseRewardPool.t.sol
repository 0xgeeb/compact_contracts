// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccConvex/ccBaseRewardPool.sol";
import "../../src/ccConvex/ccCVX.sol";
import "../../src/ccConvex/cccvxCRV.sol";

contract ccBaseRewardPoolTest is Test {

  ccBaseRewardPool ccbaserewardpool;
  ccCVX cccvx;
  cccvxCRV cccvxcrv;

  function setUp() public {
    cccvx = new ccCVX();
    cccvxcrv = new cccvxCRV();
    ccbaserewardpool = new ccBaseRewardPool(address(cccvxcrv), address(cccvx), msg.sender);
  }

}