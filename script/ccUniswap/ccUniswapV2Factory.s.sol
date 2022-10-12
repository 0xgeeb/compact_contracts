// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import "../../src/ccUniswap/ccUniswapV2Factory.sol";

contract ccUniswapV2FactoryScript is Script {

  ccUniswapV2Factory ccuniswapv2factory;

  function run() public {
    vm.startBroadcast();
    ccuniswapv2factory = new ccUniswapV2Factory();
    vm.stopBroadcast();
  }
}