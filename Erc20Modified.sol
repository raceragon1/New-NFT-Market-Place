// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.11;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";



//ERC 20 token Type
//Had to create this to call internal function which i could use in mint Factory

contract Erc20Modified is ERC20 {
    string _name;
    string _symbol;
    uint _totalSupply = totalSupply();
    

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_)
    {
        _name = name_;
        _symbol = symbol_;
    }

    function mint(address _minter, uint256 _amount) public {
        _mint(_minter, _amount);
    }

    function burnAll() public {
        uint _amount = totalSupply();
        _burn(msg.sender, _amount);
    }
  
}