// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract ccMarinateV2 {

  using EnumerableSet for EnumerableSet.AddressSet;

  mapping(address => uint256) public totalTokenRewardsPerStake;
  mapping(address => mapping(address => uint256)) public paidTokenRewardsPerStake;
  mapping(address => mapping(address => uint256)) public toBePaid;
  EnumerableSet.AddressSet private rewardTokens;

  constructor(address) {

  }


  
}