// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./ccSushiToken.sol";
import "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";


contract ccSushiMaker is Ownable {

  ccSushiToken ccsushitoken;
  address public ccsushibar;
  uint256 public constant DAILY_EMISSIONS = 1388;
  uint256 public constant DAY_SECONDS = 86400;
  uint256 public constant TOKENS_PER_SECOND = DAILY_EMISSIONS / DAY_SECONDS;
  uint256 public prevEmission;

  constructor() {
    prevEmission = block.timestamp;
  }

  modifier timeLock() {
    require(block.timestamp - DAY_SECONDS > prevEmission, "time is locked ser");
    _;
  }

  function updateEmissions() public timeLock() {
    uint256 _emitAmount= _getEmissions();
    prevEmission = block.timestamp;
    ccsushitoken.mint(ccsushibar, _emitAmount);
  }


  function _getEmissions() internal view returns (uint256 _emission) {
    uint256 _emissionPeriod = block.timestamp - prevEmission;
    uint256 emission = _emissionPeriod * TOKENS_PER_SECOND;
    return emission;
  }

  function updateTokenAddy(address _ccsushitoken) public onlyOwner() {
    ccsushitoken = ccSushiToken(_ccsushitoken);
  }

  function updateBarAddy(address _ccsushibar) public onlyOwner() {
    ccsushibar = _ccsushibar;
  }



  
}