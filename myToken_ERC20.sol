// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import OpenZeppelin Contracts
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

// MyToken Contract
contract MyToken is ERC20, Ownable, Pausable {
    // Events
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    // Constructor to initialize the token
    constructor(uint256 initialSupply, address initialOwner) 
        ERC20("MyToken", "MTK") 
        Ownable(initialOwner) // Call Ownable constructor
    {
        transferOwnership(initialOwner); // Set the initial owner
        _mint(msg.sender, initialSupply); // Mint the initial supply to the deployer
    }

    // Function to mint new tokens
    function mint(uint256 amount) external onlyOwner whenNotPaused {
        _mint(msg.sender, amount);
        emit Mint(msg.sender, amount);
    }

    // Function to burn tokens
    function burn(uint256 amount) external whenNotPaused {
        _burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
    }

    // Function to pause token transfers
    function pause() external onlyOwner {
        _pause();
    }

    // Function to unpause token transfers
    function unpause() external onlyOwner {
        _unpause();
    }

    // Override transfer function to include pause functionality
    function transfer(address recipient, uint256 amount) public override(ERC20) whenNotPaused returns (bool) {
        return super.transfer(recipient, amount);
    }

    // Override transferFrom function to include pause functionality
    function transferFrom(address sender, address recipient, uint256 amount) public override(ERC20) whenNotPaused returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }

    // Override transferOwnership function
    function transferOwnership(address newOwner) public override(Ownable) onlyOwner {
        super.transferOwnership(newOwner);
    }

    // Function to set allowance
    function approve(address spender, uint256 amount) public override(ERC20) whenNotPaused returns (bool) {
        return super.approve(spender, amount);
    }

    // Function to increase allowance
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, allowance(_msgSender(), spender) + addedValue);
        return true;
    }

    // Function to decrease allowance
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        uint256 currentAllowance = allowance(_msgSender(), spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        return true;
    }
}
