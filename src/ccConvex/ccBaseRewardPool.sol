// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract BaseRewardPool{

  IERC20 public rewardToken;
  IERC20 public stakingToken;

  uint256 private _totalSupply;
  uint256 public rewardPerTokenStored;
  uint256 public periodFinish = 0;
  uint256 public rewardRate = 0;
  uint256 public lastUpdateTime;
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

  modifier updateReward(address _account) {
    rewardPerTokenStored = rewardPerToken();
    lastUpdateTime = lastTimeRewardApplicable();
    if (_account != address(0)) {
      rewards[_account] = earned(_account);
      userRewardPerTokenPaid[_account] = rewardPerTokenStored;
    }
    _;
  }

  function lastTimeRewardApplicable() public view returns (uint256) {
    if (block.timestamp > periodFinish) {
      return periodFinish;
    }
    else {
      return block.timestamp;
    }
  }

  function rewardPerToken() public view returns (uint256) {
    if (totalSupply() == 0) {
      return rewardPerTokenStored;
    }
    return rewardPerTokenStored + (lastTimeRewardApplicable() - lastUpdateTime * rewardRate * 1e18 / totalSupply());
  }

  function earned(address _account) public view returns (uint256) {
    return balanceOf(_account) * (rewardPerToken() - userRewardPerTokenPaid[_account]) / 1e18 + rewards[_account];
  }

  function stake(uint256 _amount) public updateReward(msg.sender) returns (bool) {
    require(_amount > 0, "have to stake something");
    _totalSupply += _amount;
    _balances[msg.sender] += _amount;
    stakingToken.transferFrom(msg.sender, address(this), _amount);
    return true;
  }

  function withdraw(uint256 _amount, bool _claim) public updateReward(msg.sender) returns (bool) {
    require(_amount > 0, "have to withdraw something");
    _totalSupply -= _amount;
    _balances[msg.sender] -= _amount;
    stakingToken.transfer(msg.sender, _amount);
    if (_claim) {
      getReward();
    }
    return true;
  }

  function getReward() public updateReward(msg.sender) returns (bool) {
    uint256 reward = earned(msg.sender);
    if (reward > 0) {
      rewards[msg.sender] = 0;
      rewardToken.transfer(msg.sender, reward);
    }
    return true;
  }

}