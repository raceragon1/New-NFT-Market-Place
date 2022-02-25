// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.11;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";



//ERC 20 token Type
//Had to create this to call internal function which i could use in mint Factory

contract Erc20Modified is ERC20 {
    string _name;
    string _symbol;

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

//////////////////////////////////////////////////////////////////////////
/*
//Minting tokens
    function mintERC20Tokens(
        uint256 _amount, 
       // uint256 _tokenContarctIndex/
       address _ERC20contarctAddress
    ) 
        public 
    {
        address _minter = msg.sender;
        MintPalace(_ERC20contarctAddress).mint(_minter,_amount);
        //MintPalace(tokenContractArray[_tokenContarctIndex]).mint(_minter,_amount);
    }


    //Transfering tokens
    function transferERC20tokens(
        address _to, 
        uint256 _amount, 
        uint256 _tokenContarctIndex
    ) 
        public 
    {
        MintPalace(address(tokenContractArray[_tokenContarctIndex])).transfer(_to,_amount);

    }
 

    //View token information
   function viewERC20tokens(uint256 _tokenContarctIndex) 
       public 
       view 
       returns (
            string memory, 
            string memory, 
            uint256
        ) 
    {
        MintPalace ERC20TokenContarct = MintPalace(address(tokenContractArray[_tokenContarctIndex]));

        return (
            ERC20TokenContarct.name(),
            ERC20TokenContarct.symbol(),
            ERC20TokenContarct.totalSupply()
        );
    }   


Still have to add require statements for all
create a connect between the NFT and ERC token
*/ 

}