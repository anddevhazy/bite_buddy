// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";
import {IERC721Errors} from "@openzeppelin/contracts/interfaces/draft-IERC6093.sol";
import {BiteBuddyKeepsakes, IERC5192} from "../src/BiteBuddyKeepsakes.sol";

contract BiteBuddyKeepsakesTest is Test {
    BiteBuddyKeepsakes keepsakes;
    address admin = makeAddr("admin");
    address minter = makeAddr("minter");
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    event Locked(uint256 tokenId);

    function setUp() public {
        keepsakes = new BiteBuddyKeepsakes(admin, minter, "https://api.bitebuddy.app/keepsakes/");
    }

    function test_mintsToAPlayerWithTheServersTokenId() public {
        vm.expectEmit(address(keepsakes));
        emit Locked(42);
        vm.prank(minter);
        keepsakes.mint(alice, 42);

        assertEq(keepsakes.ownerOf(42), alice);
        assertEq(keepsakes.balanceOf(alice), 1);
        assertTrue(keepsakes.locked(42));
        assertEq(keepsakes.tokenURI(42), "https://api.bitebuddy.app/keepsakes/42");
    }

    function test_onlyTheMinterCanMint() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, alice, keepsakes.MINTER_ROLE()
            )
        );
        vm.prank(alice);
        keepsakes.mint(alice, 1);
    }

    function test_aTokenIdCanOnlyBeMintedOnce() public {
        vm.startPrank(minter);
        keepsakes.mint(alice, 7);
        vm.expectRevert(abi.encodeWithSelector(IERC721Errors.ERC721InvalidSender.selector, address(0)));
        keepsakes.mint(bob, 7);
        vm.stopPrank();
    }

    function test_cannotBeTransferred() public {
        vm.prank(minter);
        keepsakes.mint(alice, 1);

        vm.startPrank(alice);
        vm.expectRevert(BiteBuddyKeepsakes.Soulbound.selector);
        keepsakes.transferFrom(alice, bob, 1);
        vm.expectRevert(BiteBuddyKeepsakes.Soulbound.selector);
        keepsakes.safeTransferFrom(alice, bob, 1);
        vm.expectRevert(BiteBuddyKeepsakes.Soulbound.selector);
        keepsakes.approve(bob, 1);
        vm.expectRevert(BiteBuddyKeepsakes.Soulbound.selector);
        keepsakes.setApprovalForAll(bob, true);
        vm.stopPrank();

        assertEq(keepsakes.ownerOf(1), alice);
    }

    function test_onlyTheOwnerCanBurn() public {
        vm.prank(minter);
        keepsakes.mint(alice, 1);

        vm.prank(bob);
        vm.expectRevert(abi.encodeWithSelector(IERC721Errors.ERC721IncorrectOwner.selector, bob, 1, alice));
        keepsakes.burn(1);

        vm.prank(alice);
        keepsakes.burn(1);
        assertEq(keepsakes.balanceOf(alice), 0);
        vm.expectRevert(abi.encodeWithSelector(IERC721Errors.ERC721NonexistentToken.selector, 1));
        keepsakes.locked(1);
    }

    function test_onlyTheAdminCanChangeTheBaseURI() public {
        vm.prank(minter);
        keepsakes.mint(alice, 3);

        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, minter, keepsakes.DEFAULT_ADMIN_ROLE()
            )
        );
        vm.prank(minter);
        keepsakes.setBaseURI("https://evil.example/");

        vm.prank(admin);
        keepsakes.setBaseURI("https://cdn.bitebuddy.app/k/");
        assertEq(keepsakes.tokenURI(3), "https://cdn.bitebuddy.app/k/3");
    }

    function test_reportsSoulboundAndNftInterfaces() public view {
        assertTrue(keepsakes.supportsInterface(type(IERC5192).interfaceId));
        assertTrue(keepsakes.supportsInterface(0x80ac58cd)); // ERC-721
        assertTrue(keepsakes.supportsInterface(0x5b5e139f)); // ERC-721 metadata
        assertEq(type(IERC5192).interfaceId, bytes4(0xb45a3c0e));
    }

    function test_mintSelectorMatchesTheServer() public pure {
        // backend: lib/src/services/keepsake/keepsake_minter.dart
        assertEq(BiteBuddyKeepsakes.mint.selector, bytes4(0x40c10f19));
    }
}
