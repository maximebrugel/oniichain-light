// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Owned} from "solmate/auth/Owned.sol";
import {ERC721} from "solmate/tokens/ERC721.sol";
import {IOniiChainDescriptor} from "./interfaces/IOniiChainDescriptor.sol";

contract OniiChain is ERC721, Owned {
    uint256 public constant MAX_SUPPLY = 10_000;

    /* -------------------------------------------------------------------------- */
    /*                                   STORAGE                                  */
    /* -------------------------------------------------------------------------- */

    uint96 public totalSupply;

    address public sudoPair;

    IOniiChainDescriptor public descriptor;

    /* -------------------------------------------------------------------------- */
    /*                                 CONSTRUCTOR                                */
    /* -------------------------------------------------------------------------- */

    constructor(IOniiChainDescriptor _descriptor, uint256 fundSize)
        ERC721("OniiChain", "ONII")
        Owned(msg.sender)
    {
        require(fundSize <= type(uint96).max, "UNSAFE_UINT96_CAST");
        descriptor = _descriptor;

        // Mint team fund
        unchecked {
            for (uint256 i = 1; i <= fundSize; ++i) {
                _mint(msg.sender, i);
            }
        }

        totalSupply = uint96(fundSize);
    }

    /* -------------------------------------------------------------------------- */
    /*                             EXTERNAL FUNCTIONS                             */
    /* -------------------------------------------------------------------------- */

    function tokenURI(uint256 id) public view override returns (string memory) {
        address owner = ownerOf(id);
        require(owner != address(0), "NONEXISTENT_TOKEN");

        return descriptor.tokenURI(id, owner);
    }

    /// @notice Add liquidity to the sudoswap pool
    ///         Can add up to the max supply (with multiple calls)
    /// @param quantity The number of Onii to mint and add to the liquidity pool
    function addLiquidity(uint96 quantity) external {
        require(sudoPair != address(0), "NOT_INITIALIZED");
        totalSupply += quantity;
        require(totalSupply <= MAX_SUPPLY, "MINT_LIMIT");

        unchecked {
            for (uint256 i = 1; i <= quantity; ++i) {
                _mint(sudoPair, i);
            }
        }
    }

    /* -------------------------------------------------------------------------- */
    /*                               OWNER FUNCTIONS                              */
    /* -------------------------------------------------------------------------- */

    /// @notice Initialize the sudoPair (created by the owner/deployer)
    /// @param _sudoPair The sudoswap ONII-ETH pair address
    function initializeSudoPair(address _sudoPair) external onlyOwner {
        require(sudoPair == address(0), "ALREADY_INITIALIZED");
        require(_sudoPair != address(0), "ADDRESS_ZERO");
        sudoPair = _sudoPair;
    }

    /// @notice Withdraw ETH from the contract
    function withdrawAll() public payable onlyOwner {
        require(payable(msg.sender).send(address(this).balance));
    }
}
