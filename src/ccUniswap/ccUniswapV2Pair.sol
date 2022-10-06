// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract ccUniswapV2Pair {

  address public factory;
  address public token0;
  address public token1;

  constructor() {
    factory = msg.sender;
  }

  function initialize(address _token0, address _token1) public {
    require(msg.sender == factory, "forbidden");
    token0 = _token0;
    token1 = _token1;
  }
  
}