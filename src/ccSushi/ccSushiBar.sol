// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract ccSushiBar is ERC20("ccSushiBar", "ccxSUSHI") {

  IERC20 public ccSushi;

  constructor(IERC20 _ccSushi) {
    ccSushi = _ccSushi;
  }

  function enter(uint256 _amount) public {
    uint256 ccSushiBal = ccSushi.balanceOf(address(this));
    uint256 ccxSushiBal = totalSupply();
    
  }

  function leave(uint256 _amount) public {

  }
  
}