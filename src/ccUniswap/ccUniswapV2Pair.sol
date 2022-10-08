// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./ccUniswapV2ERC20.sol";

contract ccUniswapV2Pair {

  address public factory;
  address public token0;
  address public token1;

  uint256 private reserve0;
  uint256 private reserve1;
  uint32 private blockTimestampLast;
  
  uint256 public testTime;
  uint32 public testTimeModified;

  uint private unlocked = 1;
  modifier lock() {
    require(unlocked == 1, "ccUniswapV2: LOCKED");
    unlocked = 0;
    _;
    unlocked = 1;
  }

  constructor() {
    factory = msg.sender;
  }

  function getReserves() public view returns (uint256 _reserve0, uint256 _reserve1, uint32 _blockTimestampLast) {
    _reserve0 = reserve0;
    _reserve1 = reserve1;
    _blockTimestampLast = blockTimestampLast;
  }

  function initialize(address _token0, address _token1) public {
    require(msg.sender == factory, "forbidden");
    token0 = _token0;
    token1 = _token1;
  }

  function mint(address _to) public lock returns (uint256 liquidity) {
    (uint256 _reserve0, uint256 _reserve1,) = getReserves();
  }

  function _update(uint256 _balance0, uint256 _balance1, uint256 _reserve0, uint256 _reserve1) private {

  }

  function timestamp() public returns (uint256) {
    testTime = block.timestamp;
    return testTime;
  }

  function timestampModified() public returns (uint32) {
    testTimeModified = uint32(block.timestamp % 2**32);
    return testTimeModified;
  }
  
}