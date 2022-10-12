// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUniswap/ccUniswapV2Factory.sol";

contract ccUniswapV2FactoryTest is Test {

  ccUniswapV2Factory ccuniswapv2factory;

  address tokenA = 0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0;
  address tokenB = 0xBCe0Cf87F513102F22232436CCa2ca49e815C3aC;

  function setUp() public {
    ccuniswapv2factory = new ccUniswapV2Factory();
  }

  function testCreatePair() public {
    address pair = ccuniswapv2factory.createPair(tokenA, tokenB);
    console.log(pair);
    assertEq(ccuniswapv2factory.getPair(tokenA, tokenB), pair);
  }

}