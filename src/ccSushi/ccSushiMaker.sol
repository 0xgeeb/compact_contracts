// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./ccSushiToken.sol";
import "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract ccSushiMaker is Ownable {

  ccSushiToken ccsushitoken;
  address public ccsushibar;
  uint256 public constant DAILY_EMISSIONS = 1388;
  uint256 public constant DAY_SECONDS = 86400;
  uint256 public prevEmission;

  constructor() {
    prevEmission = block.timestamp;
  }

  modifier timeLock() {
    require(prevEmission + DAY_SECONDS < block.timestamp, "time is locked ser");
    _;
  }

  function updateEmissions() public timeLock {
    uint256 _emitAmount= getEmissions();
    prevEmission = block.timestamp;
    ccsushitoken.mint(ccsushibar, _emitAmount);
  }

  function getEmissions() public view returns (uint256) {
    uint256 _emissionPeriod = block.timestamp - prevEmission;
    return (_emissionPeriod * ((DAILY_EMISSIONS*(10**18)) / DAY_SECONDS)) / (10**18);
  }

  function updateTokenAddy(address _ccsushitoken) public onlyOwner() {
    ccsushitoken = ccSushiToken(_ccsushitoken);
  }

  function updateBarAddy(address _ccsushibar) public onlyOwner() {
    ccsushibar = _ccsushibar;
  } 
}