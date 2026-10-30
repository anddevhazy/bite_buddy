# Bite Buddy Keepsakes (smart contract)

`src/BiteBuddyKeepsakes.sol` is the NFT contract behind "My collection": a
soulbound ERC-721 (ERC-5192) on Base. Only the Bite Buddy server's minting
wallet can mint; players can't transfer or sell keepsakes, only burn their
own. Each token's details come from the server at `BASE_URI + tokenId`
(`backend/bite_buddy_server/lib/src/web/keepsake_routes.dart`).

Right now the app runs in **test mode**: wallets are made-up addresses and
the server's minter is a stub (`StubKeepsakeMinter`), so nothing reaches a
blockchain. This folder is ready for when you go live.

## 1. Install Foundry (once)

Foundry is the Solidity toolkit used to build, test and deploy the contract.

```
curl -L https://foundry.paradigm.xyz | bash
```

Open a new terminal, then:

```
foundryup
forge --version
```

## 2. Get the libraries and run the tests

```
cd ~/dev/projects/flutter/bite_buddy/blockchain
forge install foundry-rs/forge-std --no-git
forge install OpenZeppelin/openzeppelin-contracts@v5.4.0 --no-git
forge test -vv
```

All 8 tests should pass.

## 3. Deploy to Base Sepolia (free testnet)

You need a wallet with a little Base Sepolia test ETH (free from a faucet,
e.g. the Coinbase Developer Platform faucet).

```
export ADMIN_ADDRESS=0xYourOwnWallet
export MINTER_ADDRESS=0xTheServersMintingWallet   # from Privy, step 5
export BASE_URI=https://your-staging-web-host/keepsakes/
export BASESCAN_API_KEY=your_key                  # free at basescan.org

forge script script/Deploy.s.sol --rpc-url base_sepolia \
  --interactive --broadcast --verify
```

`--interactive` asks for the deployer's private key in the terminal, so it
never lands in a file or your shell history. The script prints the contract
address.

## 4. Deploy to Base mainnet

Same command with `--rpc-url base`, a deployer holding a little real ETH on
Base, and the production `BASE_URI`
(`config/production.yaml` → `webServer.publicHost`).

## 5. Switch the server from test mode to real mints (needs a Privy account)

1. Create a Privy app at https://privy.io, turn on gas sponsorship for Base,
   and create a server wallet. Its address is `MINTER_ADDRESS` above.
2. Add to `backend/bite_buddy_server/config/passwords.yaml`:
   `privyAppId`, `privyAppSecret`, `privyMinterWalletId`,
   `keepsakeContract` (the deployed address).
3. Write `PrivyKeepsakeMinter` (the request shape is in
   `lib/src/services/keepsake/keepsake_minter.dart`) and use it in
   `KeepsakeService`.
4. In the app, create wallets with the `privy_flutter` SDK (needs iOS 17+
   and Android 8.1+), and have the server check each address with Privy
   before saving it (`KeepsakeService.createWallet`).
