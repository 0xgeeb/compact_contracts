// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Test.sol";
import "../../src/ccUniswap/ccUniswapV2ERC20.sol";
import "../../src/ccUniswap/ccUniswapV2Pair.sol";

contract ccUniswapV2ERC20Test is Test {

  ccUniswapV2ERC20 ccuniswapv2erc20;
  ccUniswapV2Pair ccuniswapv2pair;

  function setUp() public {
    ccuniswapv2pair = new ccUniswapV2Pair();
    ccuniswapv2erc20 = new ccUniswapV2ERC20(address(ccuniswapv2pair));
  }

  function testOnlyPair() public {
    vm.expectRevert(bytes("not the pair"));
    ccuniswapv2erc20.mint(msg.sender, 10);
  }

  function testMint() public {
    vm.prank(address(ccuniswapv2pair));
    ccuniswapv2erc20.mint(msg.sender, 10);
    assertEq(ccuniswapv2erc20.balanceOf(msg.sender), 10);
  }

  function testBurn() public {
    vm.prank(address(ccuniswapv2pair));
    ccuniswapv2erc20.mint(msg.sender, 10);
    vm.prank(address(ccuniswapv2pair));
    ccuniswapv2erc20.burn(msg.sender, 10);
    assertEq(ccuniswapv2erc20.balanceOf(msg.sender), 0);
  }

}