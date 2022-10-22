// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUmami/ccMarinateReceiver.sol";

contract ccMarinateReciever is Test {

  ccMarinateReceiver ccmarinatereceiver;

  function setUp() public {
    ccmarinatereceiver = new ccMarinateReceiver();
  }

}