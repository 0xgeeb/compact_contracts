// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract ccSushiBar is ERC20("ccSushiBar", "ccxSUSHI") {

  IERC20 public ccSushi;

  uint256 public ccSushiBal = ccSushi.balanceOf(address(this));
  uint256 public ccxSushiBal = totalSupply();

  mapping(address => uint256) public balances;

  constructor(IERC20 _ccSushi) {
    ccSushi = _ccSushi;
  }

  function enter(uint256 _amount) public {
    if (ccxSushiBal == 0 || ccSushiBal == 0) {
      _mint(msg.sender, _amount);
    }
    else {
      uint256 ccxAmount = (_amount * ccxSushiBal) / ccSushiBal;
      _mint(msg.sender, ccxAmount);
    }
    ccSushi.transferFrom(msg.sender, address(this), _amount);
  }

  function leave(uint256 _amount) public {
    uint256 ccAmount = (_amount * ccSushiBal) / ccxSushiBal;
    _burn(msg.sender, _amount);
    ccSushi.transfer(msg.sender, ccAmount);
  }
  
}