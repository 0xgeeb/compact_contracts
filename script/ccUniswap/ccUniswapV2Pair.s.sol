// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccUniswap/ccUniswapV2Pair.sol";

contract ccUniswapV2PairScript is Script {

  ccUniswapV2Pair ccuniswapv2pair;

  function run() public {
    vm.startBroadcast();
    ccuniswapv2pair = new ccUniswapV2Pair();
    vm.stopBroadcast();
  }
}