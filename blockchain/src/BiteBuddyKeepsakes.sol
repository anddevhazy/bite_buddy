// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

/// ERC-5192: minimal soulbound NFTs (https://eips.ethereum.org/EIPS/eip-5192)
interface IERC5192 {
    event Locked(uint256 tokenId);
    event Unlocked(uint256 tokenId);

    function locked(uint256 tokenId) external view returns (bool);
}

/// @title Bite Buddy Keepsakes
/// @notice Soulbound keepsakes from Bite Buddy: a buddy's certificate and
/// cards for milestones like streaks, levels and league trophies. They stay
/// in the wallet they were minted to: they can't be sold or transferred,
/// only burned by their owner.
/// @dev Token ids are chosen by the Bite Buddy server (the id of the
/// keepsake in its database), and token details are served from
/// `baseURI + tokenId`, so card pictures can improve without re-minting.
contract BiteBuddyKeepsakes is ERC721, AccessControl, IERC5192 {
    /// Held by the Bite Buddy server's minting wallet
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    string private _baseTokenURI;

    error Soulbound();

    event BaseURIChanged(string baseURI);

    constructor(address admin, address minter, string memory baseURI)
        ERC721("Bite Buddy Keepsakes", "BBK")
    {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, minter);
        _baseTokenURI = baseURI;
    }

    /// Mints keepsake [tokenId] to a player's wallet. Each id can only ever
    /// be minted once.
    function mint(address to, uint256 tokenId) external onlyRole(MINTER_ROLE) {
        // _mint, not _safeMint: players' wallets are plain accounts, and a
        // receiver hook would let a contract wallet block our mint
        _mint(to, tokenId);
        emit Locked(tokenId);
    }

    /// Owners can remove a keepsake from their wallet for good
    function burn(uint256 tokenId) external {
        if (ownerOf(tokenId) != msg.sender) revert ERC721IncorrectOwner(msg.sender, tokenId, ownerOf(tokenId));
        _burn(tokenId);
    }

    function locked(uint256 tokenId) external view returns (bool) {
        _requireOwned(tokenId);
        return true;
    }

    function setBaseURI(string calldata baseURI) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _baseTokenURI = baseURI;
        emit BaseURIChanged(baseURI);
    }

    // ── Soulbound: no transfers or approvals ─────────────────────────────

    function approve(address, uint256) public pure override {
        revert Soulbound();
    }

    function setApprovalForAll(address, bool) public pure override {
        revert Soulbound();
    }

    /// Every balance change goes through here; only mints (from nobody) and
    /// burns (to nobody) are allowed
    function _update(address to, uint256 tokenId, address auth) internal override returns (address) {
        address from = _ownerOf(tokenId);
        if (from != address(0) && to != address(0)) revert Soulbound();
        return super._update(to, tokenId, auth);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, AccessControl) returns (bool) {
        return interfaceId == type(IERC5192).interfaceId || super.supportsInterface(interfaceId);
    }
}
