// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.11;
import "./Erc20Modified.sol";
import "./Erc721Modified.sol";


//Problem Statement - ERC 20 Token Factory, Store NFTs, create Tokens against it.
contract MintFactory {

    //Array of ERC20 Contracts deployed
    ModErc20[] public tokenContractArray;

    //creating mapping of NFT stored to make an condition for minitng ERC20 tokens against it
    mapping(address => mapping(uint => bool)) tokenToBool;

    //mapping ERC 20 token address to NFT id
    mapping(address => uint) ERC20AddressToTokenId; 
    
    //Creating mapping of NFT to address (original staker) that deposited the NFT 
    mapping(uint => address) tokenToNFTAddress; 

    
    constructor() {}


    //store(Stake) function to deposit NFT
    function store(address _NFTcontarctAddress, uint _NFTtokenId) public {
        ERC721Modified(_NFTcontarctAddress).transfer(
            msg.sender, 
            address(this), 
            _NFTtokenId
        );

        tokenToNFTAddress[_NFTtokenId] = _NFTcontarctAddress;

        tokenToBool[msg.sender][_NFTtokenId] = true;
    }


    //Function to retrive NFT
    //Should be able to retrive without making token

    function retrive(uint256 _tokenContarctIndex) public {
        address ERC20Address = address(tokenContractArray[_tokenContarctIndex]);

        Erc20Modified(ERC20Address).burnall();

        uint _NFTtokenId = ERC20AddressToTokenId[ERC20Address];
        address _NFTcontarctAddress = tokenToNFTAddress[_NFTtokenId];
        
        ERC721Modified(_NFTcontarctAddress).transfer(
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

       require(tokenToBool[msg.sender][_NFTtokenId] == true) ;

       Erc20Modified tokenContract = new Erc20Modified(_name,_symbol);
       tokenContractArray.push(tokenContract);    
    }
}