// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccSushi/ccSushiToken.sol";
import "../../src/ccSushi/ccSushiMaker.sol";
import "../../src/ccSushi/ccSushiBar.sol";

contract ccSushiBarTest is Test {

  ccSushiToken ccsushitoken;
  ccSushiMaker ccsushimaker;
  ccSushiBar ccsushibar;
  address jeff = 0xFB38050d2dEF04c1bb5Ff21096d50cD992418be3;

  function setUp() public {
    ccsushimaker = new ccSushiMaker();
    ccsushitoken = new ccSushiToken(address(ccsushimaker));
    ccsushibar = new ccSushiBar();
    ccsushibar.updateTokenAddy(address(ccsushitoken));
    deal(address(ccsushitoken), jeff, 10);
  }

  function testEnter() public {
    vm.prank(jeff);
    ccsushitoken.approve(address(ccsushibar), 10e18);
    vm.prank(jeff);
    ccsushibar.enter(10);
    assertEq(ccsushitoken.balanceOf(address(jeff)), 0);
    assertEq(ccsushitoken.balanceOf(address(ccsushibar)), 10);
    assertEq(ccsushibar.balanceOf(address(jeff)), 10);
  }

  function testLeave() public {
    vm.prank(jeff);
    ccsushitoken.approve(address(ccsushibar), 10e18);
    vm.prank(jeff);
    ccsushibar.enter(10);
    deal(address(ccsushitoken), address(ccsushibar), 20);
    console.log(ccsushitoken.balanceOf(address(ccsushibar)));
    vm.prank(jeff);
    ccsushibar.leave(10);
    assertEq(ccsushitoken.balanceOf(address(ccsushibar)), 0);
    assertEq(ccsushitoken.balanceOf(jeff), 20);
    assertEq(ccsushibar.totalSupply(), 0);
  }
}