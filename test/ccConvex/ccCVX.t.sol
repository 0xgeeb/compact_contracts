// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccConvex/ccCVX.sol";

contract ccCVXTest is Test {

  ccCVX cccvx;
  address jeff = 0xFB38050d2dEF04c1bb5Ff21096d50cD992418be3;

  function setUp() public {
    cccvx = new ccCVX();
  }

  function testOnlyOperator() public {
    vm.expectRevert(bytes("u ser are not the operator"));
    vm.prank(jeff);
    cccvx.mint(msg.sender, 10);
  }

  function testMint() public {
    cccvx.mint(msg.sender, 10);
    assertEq(cccvx.balanceOf(msg.sender), 10);
  }

}