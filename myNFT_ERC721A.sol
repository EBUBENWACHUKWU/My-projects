// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import OpenZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; // Import Strings library
import "@openzeppelin/contracts/access/Ownable.sol"; // Import Ownable

// MyNFT Contract
contract MyNFT is ERC721, Ownable {
    using Strings for uint256; // Use Strings library for uint256

    // State Variables
    string private _baseTokenURI;
    uint256 private _currentTokenId;

    // Events
    event Mint(address indexed to, uint256 indexed tokenId);

    // Constructor
    constructor(string memory name, string memory symbol, string memory baseURI) 
        ERC721(name, symbol) 
        Ownable(msg.sender) // Pass deployer's address to Ownable
    {
        _baseTokenURI = baseURI;
    }

    // Override base URI function
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    // Mint function
    function mint() external onlyOwner {
        _currentTokenId++;
        _mint(msg.sender, _currentTokenId);
        emit Mint(msg.sender, _currentTokenId); // Emit mint event
    }

    // Set base URI
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    // Withdraw function
    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
