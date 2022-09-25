// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccSushi/ccSushiBar.sol";
import "../../src/ccSushi/ccSushiMaker.sol";
import "../../src/ccSushi/ccSushiToken.sol";

contract ccSushiMakerTest is Test {

  ccSushiBar ccsushibar;
  ccSushiMaker ccsushimaker;
  ccSushiToken ccsushitoken;

  function setUp() public {
    ccsushibar = new ccSushiBar();
    ccsushimaker = new ccSushiMaker();
    ccsushitoken = new ccSushiToken(address(ccsushimaker));
    ccsushimaker.updateTokenAddy(address(ccsushitoken));
    ccsushimaker.updateBarAddy(address(ccsushibar));
  }

  function testTimeLock() public {
    vm.expectRevert(bytes("time is locked ser"));
    vm.warp(block.timestamp + 100);
    ccsushimaker.updateEmissions();
  }

  function testEmissionsAmount() public {
    vm.warp(block.timestamp + 92625);
    uint256 _emissions = ccsushimaker.getEmissions();
    ccsushimaker.updateEmissions();
    assertEq(_emissions, ccsushitoken.balanceOf(address(ccsushibar)));
  }
}