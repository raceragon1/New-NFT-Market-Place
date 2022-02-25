// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.11;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

//ERC721 NFT Minter
//Had to use ERC721URIStorage to use _setTokenURI function
//Using Counters as an increment tool for tokenId

contract Erc721Modified is ERC721URIStorage {
    
    constructor() ERC721("Creating NFT","NFTX") {}

    using Counters for Counters.Counter;

    Counters.Counter private tokenIdCounter;


    function mint(string memory _tokenURI) public {   
        uint tokenId = tokenIdCounter.current();

        _safeMint(msg.sender, tokenId,"");
        _setTokenURI(tokenId, _tokenURI);

        tokenIdCounter.increment();
    }


    function burn(uint256 tokenId) public { 
        _burn(tokenId);   
    }


    function transfer(
        address from, 
        address to, 
        uint256 tokenId
    ) 
        public 
    { 
        _transfer(from, to, tokenId);   
    }


    function contractAddress() view public returns(address) {
        return address(this);
    }

}