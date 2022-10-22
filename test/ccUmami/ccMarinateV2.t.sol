// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUmami/ccMarinateV2.sol";

contract ccMarinateV2Test is Test {

  ccMarinateV2 ccmarinatev2;

  function setUp() public {
    ccmarinatev2 = new ccMarinateV2();
  }

}