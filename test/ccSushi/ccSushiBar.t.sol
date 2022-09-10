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

    function setUp() public {
      ccsushimaker = new ccSushiMaker();
      ccsushitoken = new ccSushiToken(address(ccsushimaker));
      ccsushibar = new ccSushiBar();
    }

    function testUpdateToken() public {
      
    }



}