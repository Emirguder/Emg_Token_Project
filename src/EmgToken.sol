// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract EmgToken is ERC721, Ownable {
    uint256 private _nextTokenId;
    constructor() ERC721("EmgToken", "EMG") Ownable(msg.sender) {}

    // A function that only the contract owner can mint new tokens
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    // A function that allows users to purchase tokens at a dynamic price
    function buyToken() public payable {
        uint256 tokenId = _nextTokenId;
        
        // Pricing formula: 1. Token = 0.1 ETH, 2. Token = 0.2 ETH...
        uint256 expectedPrice = 0.1 ether;
        require(msg.value == expectedPrice, "Yanlis ETH miktari gonderildi");

        _nextTokenId++;
        _safeMint(msg.sender, tokenId);
    }

    // A function that produces a JSON metadata link automatically 
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // Check if the token exists
        _requireOwned(tokenId);

        // Modern string birleştirme (abi.encodePacked kullanmıyoruz!)
        return string.concat(
            "ipfs://bafybeiev4uxmlobx6dwp6656s7l2k6jspi4py5zibw567qslsdgevlznfq/", 
            Strings.toString(tokenId), 
            ".json"
        );
    }
}