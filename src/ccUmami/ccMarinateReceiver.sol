// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IccMarinateV2 {
  function addReward(address token, uint256 amount) external;
}

contract ccMarinateReceiver {
  using EnumerableSet for EnumerableSet.AddressSet;

  IccMarinateV2 public ccmarinatev2;
  address public adminAddress;
  EnumerableSet.AddressSet private distributedTokens;

  constructor(address _ccmarinatev2) {
    ccmarinatev2 = IccMarinateV2(_ccmarinatev2);
    adminAddress = msg.sender;
  }

  modifier onlyAdmin() {
    require(msg.sender == adminAddress, "not admin");
    _;
  }

  function sendBalancesAsRewards() public onlyAdmin {
    uint256 _numberOfTokens = distributedTokens.length();
    for (uint256 i; i < _numberOfTokens; i++) {
      address _token = distributedTokens.at(i);
      uint256 _tokenBalance = IERC20(_token).balanceOf(address(this));
      if (_tokenBalance == 0) {
        continue;
      }
      _addRewards(_token, _tokenBalance);
    }
  }

  function addDistributedToken(address _token) public onlyAdmin {
    require(distributedTokens.add(_token), "distribution token exists");
  }

  function removeDistributedToken(address _token) public onlyAdmin {
    require(distributedTokens.remove(_token), "distribution token does not exist");
  }

  function setMarinateAddress(address _marinatev2) public onlyAdmin {
    ccmarinatev2 = IccMarinateV2(_marinatev2);
  }

  function _addRewards(address _token, uint256 _amount) private {
    IERC20(_token).approve(address(ccmarinatev2), _amount);
    ccmarinatev2.addReward(_token, _amount);
  }
  
}