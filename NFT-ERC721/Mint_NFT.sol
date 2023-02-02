//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract MintNFT is ERC721, Ownable{
    uint256 public mintPrice = 1 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedwallets;

    constructor() payable ERC721('NFT', 'W3A'){
        maxSupply = 2;        
    }

    function enableMint() external onlyOwner{
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint _maxSupply) external onlyOwner{
        maxSupply = _maxSupply;
    }

    function mint() external payable{
        require(isMintEnabled, "Minting NFTs is not enabled!");
        require(mintedwallets[msg.sender] < 1, "Exceeds the limit of NFTs per wallet");
        require(msg.value == mintPrice, "Exact 1 ether is required for a NFT");
        require(maxSupply > totalSupply, "sold out");

        mintedwallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);   
    }
}
