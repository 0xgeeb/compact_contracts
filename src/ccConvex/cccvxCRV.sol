// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract cccvxCRV is ERC20("ccConvex CRV", "cccvxCRV") {

  address public operator;

  constructor() {
    operator = msg.sender;
  }

  modifier onlyOperator() {
    require(msg.sender == operator,"u ser are not the operator");
    _;
  }

  function mint(address _to, uint256 _amount) public onlyOperator() {
    _mint(_to, _amount);
  }

  function burn(address _to, uint256 _amount) public onlyOperator() {
    _burn(_to, _amount);
  }

}