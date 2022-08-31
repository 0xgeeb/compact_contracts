// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract ccSushiToken is ERC20("ccSushiToken", "ccSUSHI"), Ownable {

  uint32 public constant MINT_LIMIT = 1000000;
  address public immutable makerAddress;

  constructor(address _makerAddress) {
    makerAddress = _makerAddress;
  }

  modifier onlyMaker() {
    require(msg.sender == makerAddress, "only ccSushiMaker can mint ccSUSHI tokens");
    _;
  }

  function mint(address _to, uint32 _amount) public onlyMaker {
    require(totalSupply() + _amount <= MINT_LIMIT, "will exceed the mint limit");
    _mint(_to, _amount);
  }

}