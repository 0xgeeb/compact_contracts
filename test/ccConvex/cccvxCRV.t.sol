// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccConvex/cccvxCRV.sol";

contract cccvxCRVTest is Test {

  cccvxCRV cccvxcrv;
  address jeff = 0xFB38050d2dEF04c1bb5Ff21096d50cD992418be3;

  function setUp() public {
    cccvxcrv = new cccvxCRV();
  }

  function testOnlyOperator() public {
    vm.expectRevert(bytes("u ser are not the operator"));
    vm.prank(jeff);
    cccvxcrv.mint(msg.sender, 10);
  }

  function testMint() public {
    cccvxcrv.mint(msg.sender, 10);
    assertEq(cccvxcrv.balanceOf(msg.sender), 10);
  }

  function testBurn() public {
    deal(address(cccvxcrv), msg.sender, 10);
    cccvxcrv.burn(msg.sender, 10);
    assertEq(cccvxcrv.balanceOf(msg.sender), 0);
  }

}