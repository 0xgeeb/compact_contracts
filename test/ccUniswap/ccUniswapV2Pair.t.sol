// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUniswap/ccUniswapV2Pair.sol";

contract ccUniswapV2PairTest is Test {

  ccUniswapV2Pair ccuniswapv2pair;

  function setUp() public {
    ccuniswapv2pair = new ccUniswapV2Pair();
  }



}