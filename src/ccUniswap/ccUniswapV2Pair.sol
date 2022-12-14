// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "./ccUniswapV2ERC20.sol";

library Math {
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
}

contract ccUniswapV2Pair is ERC20("ccUniswapV2Pair", "ccUni") {

  uint public constant MINIMUM_LIQUIDITY = 10**3;
  address public factory;
  address public token0;
  address public token1;
  address public zero = 0xFB38050d2dEF04c1bb5Ff21096d50cD992418be3;

  uint256 public reserve0;
  uint256 public reserve1;
  uint256 public blockTimestampLast;

  uint private unlocked = 1;
  modifier lock() {
    require(unlocked == 1, "ccUniswapV2: LOCKED");
    unlocked = 0;
    _;
    unlocked = 1;
  }

  constructor()  {
    factory = msg.sender;
  }

  function getReserves() public view returns (uint256 _reserve0, uint256 _reserve1) {
    _reserve0 = reserve0;
    _reserve1 = reserve1;
  }

  function initialize(address _token0, address _token1) public {
    require(msg.sender == factory, "forbidden");
    token0 = _token0;
    token1 = _token1;
  }

  function mint(address _to) public lock returns (uint256 liquidity) {
    (uint256 _reserve0, uint256 _reserve1) = getReserves();
    uint256 _balance0 = IERC20(token0).balanceOf(address(this));
    uint256 _balance1 = IERC20(token1).balanceOf(address(this));
    uint256 _amount0 = _balance0 - _reserve0;
    uint256 _amount1 = _balance1 - _reserve1;
    uint256 _totalSupply = totalSupply();
    if (_totalSupply == 0) {
      liquidity = Math.sqrt((_amount0 * _amount1) / MINIMUM_LIQUIDITY);
      _mint(zero, MINIMUM_LIQUIDITY);
    }
    else {
      liquidity = Math.min((_amount0 * _totalSupply) / _reserve0, (_amount1 * _totalSupply) / _reserve1);
    }
    require(liquidity > 0, "insufficient liquidity mined");
    _mint(_to, liquidity);
    _update(_balance0, _balance1);
  }

  function burn(address _to) public lock returns (uint256 amount0, uint256 amount1) {
    uint256 _balance0 = IERC20(token0).balanceOf(address(this));
    uint256 _balance1 = IERC20(token1).balanceOf(address(this));
    uint256 liquidity = balanceOf(address(this));
    uint256 _totalSupply = totalSupply();
    amount0 = (liquidity * _balance0) / _totalSupply;
    amount1 = (liquidity * _balance1) / _totalSupply;
    _burn(address(this), liquidity);
    IERC20(token0).transfer(_to, amount0);
    IERC20(token1).transfer(_to, amount1);
    _balance0 = IERC20(token0).balanceOf(address(this));
    _balance1 = IERC20(token1).balanceOf(address(this));
    _update(_balance0, _balance1);
  }

  function swap(uint256 _amount0out, uint256 _amount1out, address _to) public lock {
    require(_amount0out > 0 || _amount1out > 0, "insufficient output amount");
    (uint256 _reserve0, uint256 _reserve1) = getReserves();
    require(_amount0out < _reserve0 && _amount1out < _reserve1, "insufficient liquidity");
    uint256 _balance0;
    uint256 _balance1;
    address _token0 = token0;
    address _token1 = token1;
    require(_to != _token0 && _to != _token1, "invalid to");
    if (_amount0out > 0) {
      IERC20(_token0).transfer(_to, _amount0out);
    }
    if (_amount1out > 0) {
      IERC20(_token1).transfer(_to, _amount1out);
    }
    _balance0 = IERC20(_token0).balanceOf(address(this));
    _balance1 = IERC20(_token1).balanceOf(address(this));
    uint256 _amount0in = _balance0 > _reserve0 - _amount0out ? _balance0 - (_reserve0 - _amount0out) : 0;
    uint256 _amount1in = _balance1 > _reserve1 - _amount1out ? _balance1 - (_reserve1 - _amount1out) : 0;
    require(_amount0in > 0 || _amount1in > 0, "insufficient input amount");
    _update(_balance0, _balance1);
  }

  function _update(uint256 _balance0, uint256 _balance1) private {
    reserve0 = _balance0;
    reserve1 = _balance1;
    blockTimestampLast = block.timestamp;
  }

}