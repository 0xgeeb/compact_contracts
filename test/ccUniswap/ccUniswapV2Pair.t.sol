// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUniswap/ccUniswapV2Pair.sol";
import "../../src/ccUniswap/ccUniswapV2ERC20.sol";

contract ccUniswapV2PairTest is Test {

  ccUniswapV2Pair ccuniswapv2pair;
  ccUniswapV2ERC20 ccuniswapv2erc201;
  ccUniswapV2ERC20 ccuniswapv2erc202;

  address tokenA;
  address tokenB;

  function setUp() public {
    ccuniswapv2pair = new ccUniswapV2Pair();
    ccuniswapv2erc201 = new ccUniswapV2ERC20(address(ccuniswapv2pair));
    ccuniswapv2erc202 = new ccUniswapV2ERC20(address(ccuniswapv2pair));
    tokenA = address(ccuniswapv2erc201);
    tokenB = address(ccuniswapv2erc202);
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
    uint256 _liquidity = ccuniswapv2pair.mint(address(this));
    assertEq(_liquidity, 3162277660168379331);
    assertEq(ccuniswapv2pair.balanceOf(address(this)), 3162277660168379331);
  }

  function testBurn() public {
   ccuniswapv2pair.initialize(tokenA, tokenB);
    deal(address(tokenA), address(ccuniswapv2pair), 100e18, true);
    deal(address(tokenB), address(ccuniswapv2pair), 100e18, true);
    ccuniswapv2pair.mint(address(this));
    ccuniswapv2pair.burn(address(this));
    assertEq(ccuniswapv2pair.balanceOf(address(this)), 3162277660168379331);
  }

}