// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUniswap/ccUniswapV2Pair.sol";

contract ccUniswapV2PairTest is Test {

  ccUniswapV2Pair ccuniswapv2pair;

  address tokenA = 0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0;
  address tokenB = 0xBCe0Cf87F513102F22232436CCa2ca49e815C3aC;

  function setUp() public {
    ccuniswapv2pair = new ccUniswapV2Pair();
  }

  function testGetReserves() public {
    (uint256 _reserve0, uint256 _reserve1) = ccuniswapv2pair.getReserves();
    assertEq(_reserve0, ccuniswapv2pair.reserve0());
    assertEq(_reserve1, ccuniswapv2pair.reserve1());
  }

  function testInitialize() public {
    ccuniswapv2pair.initialize(tokenA, tokenB);
    assertEq(ccuniswapv2pair.token0(), tokenA);
    assertEq(ccuniswapv2pair.token1(), tokenB);
  }

  function testMint() public {
    ccuniswapv2pair.initialize(tokenA, tokenB);
    deal(address(tokenA), address(ccuniswapv2pair), 100e18, true);
    deal(address(tokenB), address(ccuniswapv2pair), 100e18, true);
    uint256 _liquidity = ccuniswapv2pair.mint(msg.sender);
    console.log(_liquidity);
  }

  function testBurn() public {

  }

  function testSwap() public {

  }

  function min(uint x, uint y) internal pure returns (uint z) {
    z = x < y ? x : y;
  }

  // babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
  function sqrt(uint y) internal pure returns (uint z) {
    if (y > 3) {
      z = y;
      uint x = y / 2 + 1;
      while (x < z) {
        z = x;
        x = (y / x + x) / 2;
      }
    } else if (y != 0) {
      z = 1;
    }
  }

  function testTestBalance() public {
    
  }

}