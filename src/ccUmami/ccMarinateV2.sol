// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ccMarinateV2 is ERC20 {

  using EnumerableSet for EnumerableSet.AddressSet;

  mapping(address => uint256) public totalTokenRewardsPerStake;
  mapping(address => mapping(address => uint256)) public paidTokenRewardsPerStake;
  mapping(address => mapping(address => uint256)) public toBePaid;
  EnumerableSet.AddressSet private rewardTokens;
  address public immutable umami;
  uint256 public depositLimit;

  constructor(uint256 _depositLimit) ERC20() {
    depositLimit = _depositLimit;
  }

  function stake(uint256 _amount) public {
    require(_amount > 0, "invalid stake amount");
    require(totalSupply() + _amount <= depositLimit, "deposit capacity reached");
    IERC20(umami).transferFrom(msg.sender, address(this), _amount);
  }

  function withdraw() public {
    uint256 _balance = balanceOf(msg.sender);
    require(_balance > 0, "no staked balance");
    _collectRewards(msg.sender);
  }

  function _collectRewards(address _user) private {
    uint256 numberOfRewardTokens = rewardTokens.length();
    for (uint256 i = 0; i < numberOfRewardTokens; i++) {
      _collectRewardsForToken(rewardToken.at(i), _user);
    }
  }

  function _collectRewardsForToken(address _token, address _user) private {
    uint256 balance = balanceOf(_user);
    uint256 owedPerUnitStake = totalTokenRewardsPerStake[_token] - paidTokenRewardsPerStake[_token][_user];
  }


  
}