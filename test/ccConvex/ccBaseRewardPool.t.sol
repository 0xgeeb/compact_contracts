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
  address jeff = 0xFB38050d2dEF04c1bb5Ff21096d50cD992418be3;

  function setUp() public {
    cccvx = new ccCVX();
    cccvxcrv = new cccvxCRV();
    ccbaserewardpool = new ccBaseRewardPool(address(cccvxcrv), address(cccvx), msg.sender);
  }

  function testTotalSupply() public {
    deal(address(cccvxcrv), jeff, 10);
    vm.prank(jeff);
    cccvxcrv.approve(address(ccbaserewardpool), 10);
    vm.prank(jeff);
    ccbaserewardpool.stake(10);
    assertEq(ccbaserewardpool.totalSupply(), 10);
  }

  function testBalances() public {
    deal(address(cccvxcrv), jeff, 10);
    vm.prank(jeff);
    cccvxcrv.approve(address(ccbaserewardpool), 10);
    vm.prank(jeff);
    ccbaserewardpool.stake(10);
    assertEq(ccbaserewardpool.balanceOf(jeff), 10);
  }

  function testStake() public {
    deal(address(cccvxcrv), jeff, 10);
    vm.prank(jeff);
    cccvxcrv.approve(address(ccbaserewardpool), 10);
    vm.prank(jeff);
    ccbaserewardpool.stake(10);
    assertEq(cccvxcrv.balanceOf(address(ccbaserewardpool)), 10);
    assertEq(cccvxcrv.balanceOf(address(jeff)), 0);
  }

  function testWithdraw() public {
    deal(address(cccvxcrv), jeff, 10);
    vm.prank(jeff);
    cccvxcrv.approve(address(ccbaserewardpool), 10);
    vm.prank(jeff);
    ccbaserewardpool.stake(10);
    vm.prank(jeff);
    ccbaserewardpool.withdraw(10, false);
    assertEq(cccvxcrv.balanceOf(address(ccbaserewardpool)), 0);
    assertEq(cccvxcrv.balanceOf(address(jeff)), 10);
  }

}