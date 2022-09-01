// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";


contract ccSushiMaker is Ownable {

  IERC20 public ccSushi;
  uint256 public immutable GENESIS;
  uint256 public constant DAILY_EMISSIONS = 1388;

  constructor() {
    GENESIS = block.timestamp;
  }

  function updateEmissions() public {

  }


  function _getEmissions() internal {

  }

  function updateAddy(address _ccSushi) public onlyOwner() {

  }




  
}