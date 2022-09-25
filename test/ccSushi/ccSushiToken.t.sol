// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccSushi/ccSushiToken.sol";
import "../../src/ccSushi/ccSushiMaker.sol";

contract ccSushiTokenTest is Test {

  ccSushiToken ccsushitoken;
  ccSushiMaker ccsushimaker;

  function setUp() public {
    ccsushimaker = new ccSushiMaker();
    ccsushitoken = new ccSushiToken(address(ccsushimaker));
  }

  function testMaker() public {
    vm.prank(address(ccsushimaker));
    ccsushitoken.mint(address(this), 100);
    assertEq(ccsushitoken.balanceOf(address(this)), 100);
  }

  function testNotMaker() public {
    vm.expectRevert(bytes("only ccSushiMaker can mint ccSUSHI tokens"));
    ccsushitoken.mint(address(this), 100);
  }

  function testLimit() public {
    vm.expectRevert(bytes("will exceed the mint limit"));
    vm.prank(address(ccsushimaker));
    ccsushitoken.mint(address(this), 999361);
  }
}