// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract BaseRewardPool{

  IERC20 public rewardToken;
  IERC20 public stakingToken;

  uint256 private _totalSupply;
  address public operator;

  mapping(address => uint256) public userRewardPerTokenPaid;
  mapping(address => uint256) public rewards;
  mapping(address => uint256) private _balances;

  constructor(address _stakingToken, address _rewardToken, address _operator) {
    rewardToken = IERC20(_rewardToken);
    stakingToken = IERC20(_stakingToken);
    operator = _operator;
  }

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address _account) public view returns (uint256) {
    return _balances[_account];
  }

  function earned(address _account) public view returns (uint256) {
    // return balanceOf(_account) * rewardPerToken() - userRewardPerTokenPaid[_account] / 1e18 + rewards[_account];
  }

}