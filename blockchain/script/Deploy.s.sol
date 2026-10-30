// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {BiteBuddyKeepsakes} from "../src/BiteBuddyKeepsakes.sol";

/// Deploys the keepsakes contract. Reads from the environment:
///   ADMIN_ADDRESS   - can change the base URI and roles (your own wallet)
///   MINTER_ADDRESS  - the Bite Buddy server's minting wallet
///   BASE_URI        - e.g. https://api.your-domain/keepsakes/
contract Deploy is Script {
    function run() external returns (BiteBuddyKeepsakes keepsakes) {
        address admin = vm.envAddress("ADMIN_ADDRESS");
        address minter = vm.envAddress("MINTER_ADDRESS");
        string memory baseURI = vm.envString("BASE_URI");

        vm.startBroadcast();
        keepsakes = new BiteBuddyKeepsakes(admin, minter, baseURI);
        vm.stopBroadcast();

        console.log("BiteBuddyKeepsakes deployed at", address(keepsakes));
    }
}
