// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract Web3builders is ERC1155, Ownable, ERC1155Pausable, ERC1155Supply {
    uint256 public publicPrice = 0.01 ether;

    // Constructor to set the initial owner and token URI
    constructor(address initialOwner)
        ERC1155("https://wizard.openzeppelin.com/#erc1155")
        Ownable(initialOwner)
    {}

    // Function to update the token URI
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    // Function to pause all token transfers
    function pause() public onlyOwner {
        _pause();
    }

    // Function to unpause all token transfers
    function unpause() public onlyOwner {
        _unpause();
    }

    // Function to mint a specific token ID for the caller
    function mint(uint256 id, uint256 amount) public payable onlyOwner {
        require(msg.value == publicPrice , "wrong! not enough money sent");
        _mint(msg.sender, id, amount, "");
    }

    // Function to mint multiple token IDs for a specified address
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // Internal function to update token balances, required by Solidity
    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Pausable, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
