// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "./ccSushiToken.sol";
import "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract ccSushiBar is ERC20("ccSushiBar", "ccxSUSHI"), Ownable {

  ccSushiToken ccsushitoken;

  mapping(address => uint256) public balances;

  function enter(uint256 _amount) public {
    uint256 ccSushiBal = ccsushitoken.balanceOf(address(this));
    uint256 ccxSushiBal = totalSupply();
    if (ccxSushiBal == 0 || ccSushiBal == 0) {
      _mint(msg.sender, _amount);
    }
    else {
      uint256 ccxAmount = (_amount * ccxSushiBal) / ccSushiBal;
      _mint(msg.sender, ccxAmount);
    }
    ccsushitoken.transferFrom(msg.sender, address(this), _amount);
  }

  function leave(uint256 _amount) public {
    uint256 ccSushiBal = ccsushitoken.balanceOf(address(this));
    uint256 ccxSushiBal = totalSupply();
    uint256 ccAmount = (_amount * ccSushiBal) / ccxSushiBal;
    _burn(msg.sender, _amount);
    ccsushitoken.transfer(msg.sender, ccAmount);
  }

  function updateTokenAddy(address _ccsushitoken) public onlyOwner() {
    ccsushitoken = ccSushiToken(_ccsushitoken);
  }
  
}