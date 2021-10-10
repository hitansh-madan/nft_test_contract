// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    mapping(uint256 => uint256) _tokenTransferCount;

    constructor() ERC721("3pass", "3ps") {}

    modifier thriceOnly(uint256 tokenId){
        require(_tokenTransferCount[tokenId] < 3);
        _;
    }

    function transferFrom(address from, address to, uint256 tokenId) thriceOnly(tokenId) public override{
        super.transferFrom(from,to,tokenId);
        _tokenTransferCount[tokenId]++;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) thriceOnly(tokenId) public override{
        super.transferFrom(from,to,tokenId);
        _tokenTransferCount[tokenId]++;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId , bytes memory data) thriceOnly(tokenId) public override{
        super.safeTransferFrom(from,to,tokenId,data);
        _tokenTransferCount[tokenId]++;
    }

    function safeMint(address to) public {
        _safeMint(to, _tokenIdCounter.current());
        _tokenIdCounter.increment();
    }
    

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
