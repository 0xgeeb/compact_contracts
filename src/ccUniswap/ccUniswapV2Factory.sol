// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./ccUniswapV2Pair.sol";

contract ccUniswapV2Factory {

  mapping(address => mapping(address => address)) public getPair;
  address[] public allPairs;

  function createPair(address _tokenA, address _tokenB) public returns (address _pair) {
    require(_tokenA != _tokenB, "identical addresses");
    require(getPair[_tokenA][_tokenB] == address(0), "pair exists");
    bytes memory _bytecode = type(ccUniswapV2Pair).creationCode;
    bytes32 salt = keccak256(abi.encodePacked(_tokenA, _tokenB));
    assembly {
      _pair := create2(0, add(_bytecode, 32), mload(_bytecode), salt)
    }
    ccUniswapV2Pair(_pair).initialize(_tokenA, _tokenB);
    getPair[_tokenA][_tokenB] = _pair;
    getPair[_tokenB][_tokenA] = _pair;
    allPairs.push(_pair);
  }
  
}