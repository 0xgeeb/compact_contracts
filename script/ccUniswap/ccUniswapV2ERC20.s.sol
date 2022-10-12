// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccUniswap/ccUniswapV2ERC20.sol";
import "../../src/ccUniswap/ccUniswapV2Pair.sol";

contract ccUniswapV2ERC20Script is Script {

  ccUniswapV2ERC20 ccuniswapv2erc20;
  ccUniswapV2Pair ccuniswapv2pair;

  function run() public {
    vm.startBroadcast();
    ccuniswapv2pair = new ccUniswapV2Pair();
    ccuniswapv2erc20 = new ccUniswapV2ERC20(address(ccuniswapv2pair));
    vm.stopBroadcast();
  }

}