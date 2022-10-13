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
    // vm.prank(ccuniswapv2pair.factory.address);
    ccuniswapv2pair.initialize(tokenA, tokenB);
    assertEq(ccuniswapv2pair.token0.address, tokenA);
    assertEq(ccuniswapv2pair.token1.address, tokenB);
  }

}