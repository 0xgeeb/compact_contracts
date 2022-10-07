// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ccUniswapV2ERC20 is ERC20("ccUniswapERC20", "ccUni20") {
  
  address public immutable pairAddress;

  constructor(address _pairAddress) {
    pairAddress = _pairAddress;
  }

  modifier onlyPair() {
    require(msg.sender == pairAddress, "not the pair");
    _;
  }

  function mint(address _to, uint256 _amount) public onlyPair {
    _mint(_to, _amount);
  }

  function burn(address _to, uint256 _amount) public onlyPair {
    _burn(_to, _amount);
  }

}