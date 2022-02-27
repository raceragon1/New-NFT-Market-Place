// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.11;
import "./Erc20Modified.sol";
import "./Erc721Modified.sol";


//Problem Statement - ERC 20 Token Factory, Store NFTs, create Tokens against it.
contract MintFactory {

    //Array of ERC20 Contracts deployed
    Erc20Modified[] public tokenContractArray;

    //creating mapping of NFT stored to make an condition for minitng ERC20 tokens against it
    mapping(address => mapping(uint => bool)) conditionTokenStored;

    //mapping ERC 20 token address to NFT id
    mapping(address => uint) ERC20AddressToTokenId; 
    

    
    constructor() {}


    //store(Stake) function to deposit NFT
    function store(address _NFTcontractAddress, uint _NFTtokenId) public {
        Erc721Modified(_NFTcontractAddress).transfer(
            msg.sender, 
            address(this), 
            _NFTtokenId
        );


        conditionTokenStored[msg.sender][_NFTtokenId] = true;
    }


    //Function to retrive NFT
    //Should be able to retrive without making token

    function retrieve(uint256 _tokenContractIndex, address _NFTcontractAddress) public {
        address ERC20Address = address(tokenContractArray[_tokenContractIndex]);

        require (uint256 (Erc20Modified(ERC20Address).totalSupply()) == 0);

        uint _NFTtokenId = ERC20AddressToTokenId[ERC20Address];
        
        Erc721Modified(_NFTcontractAddress).transfer(
            address(this), 
            msg.sender, 
            _NFTtokenId
        );
 
    }

    //create, creating ERC 20 tokens for Stored NFTs
    function createTokenContract(
        string memory _name, 
        string memory _symbol, 
        uint _NFTtokenId
    ) 
        public 
    {

       require(conditionTokenStored[msg.sender][_NFTtokenId] == true) ;

       Erc20Modified tokenContract = new Erc20Modified(_name,_symbol);
       tokenContractArray.push(tokenContract);    
    }
}