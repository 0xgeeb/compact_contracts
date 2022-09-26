// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ccCVX is ERC20("ccConvex Token", "ccCVX") {

  address public operator;
  uint256 public maxSupply = 100 * 1000000 * 1e18;
  uint256 public totalCliffs = 1000;
  uint256 public reductionPerCliff;

  constructor() {
    operator = msg.sender;
    reductionPerCliff = maxSupply / totalCliffs;
  }

  modifier onlyOperator() {
    require(msg.sender == operator,"u ser are not the operator");
    _;
  }

  function mint(address _to, uint256 _amount) public onlyOperator() returns (uint256) {
    uint256 supply = totalSupply();
    uint256 cliff = supply / reductionPerCliff;
    if (cliff < totalCliffs) {
      uint256 reduction = totalCliffs - cliff;
      _amount = (_amount * reduction) / totalCliffs;
      uint256 amtTillMax = maxSupply - supply;
      if (_amount > amtTillMax) {
        _amount = amtTillMax;
      }
      _mint(_to, _amount);
    }
    return _amount;
  }

}