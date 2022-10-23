// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUmami/ccMarinateReceiver.sol";
import "../../src/ccUmami/ccMarinateV2.sol";

contract ccMarinateReciever is Test {

  ccMarinateReceiver ccmarinatereceiver;
  ccMarinateV2 ccmarinatev2;

  function setUp() public {
    ccmarinatev2 = new ccMarinateV2();
    ccmarinatereceiver = new ccMarinateReceiver(address(ccmarinatev2));
  }

}