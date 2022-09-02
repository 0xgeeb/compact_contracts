// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./ccSushiToken.sol";
import "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";


contract ccSushiMaker is Ownable {

  ccSushiToken ccsushitoken;
  uint256 public constant DAILY_EMISSIONS = 1388;
  uint256 public constant DAY_SECONDS = 86400;
  uint256 public prevEmission;

  constructor() {
    prevEmission = block.timestamp;
  }

  modifier timeLock() {
    require(block.timestamp - DAY_SECONDS > prevEmission, "time is locked ser");
    _;
  }

  function updateEmissions() public timeLock {
    uint256 _emitAmount= _getEmissions();
    prevEmission = block.timestamp;
    ccsushitoken.mint(address(this), _emitAmount);
  }


  function _getEmissions() internal returns (uint256 _emission) {
    uint256 _emission = block.timestamp - prevEmission;




    // return 999359;
  }

  function updateAddy(address _ccsushitoken) public onlyOwner() {
    ccsushitoken = ccSushiToken(_ccsushitoken);
  }




  
}