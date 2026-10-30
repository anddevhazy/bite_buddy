import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';

// Sends keepsake mints to the BiteBuddyKeepsakes contract
// (bite_buddy/blockchain/src/BiteBuddyKeepsakes.sol).
abstract class KeepsakeMinter {
  // 8453 Base, 84532 Base Sepolia, 0 test mode
  int get chainId;
  String get networkName;
  bool get isTest => chainId == 0;

  // Returns the transaction hash
  Future<String> mint(
    Session session, {
    required String to,
    required int tokenId,
  });
}

// mint(address,uint256): the function selector, then the two arguments each
// padded to 32 bytes. This is the transaction's `data`.
String encodeMintCall(String to, int tokenId) {
  final address = to.toLowerCase().replaceFirst('0x', '');
  if (!RegExp(r'^[0-9a-f]{40}$').hasMatch(address)) {
    throw ArgumentError.value(to, 'to', 'Not an Ethereum address');
  }
  if (tokenId < 0) throw ArgumentError.value(tokenId, 'tokenId');
  return '0x40c10f19'
      '${address.padLeft(64, '0')}'
      '${tokenId.toRadixString(16).padLeft(64, '0')}';
}

// Test mode: records mints without sending anything to a blockchain, while
// no wallet provider is set up. The "transaction hash" is made up (but
// stable for the same mint).
//
// To mint for real: add a PrivyKeepsakeMinter that POSTs to
// https://api.privy.io/v1/wallets/{minterWalletId}/rpc (Basic auth with the
// Privy app id and secret, plus a privy-app-id header) with
//   {"method": "eth_sendTransaction", "caip2": "eip155:8453", "sponsor": true,
//    "params": {"transaction": {"to": <contract>, "data": encodeMintCall(...)}}}
// and returns the hash from the response; then pick it in KeepsakeService.
class StubKeepsakeMinter extends KeepsakeMinter {
  @override
  int get chainId => 0;

  @override
  String get networkName => 'Test mode';

  @override
  Future<String> mint(
    Session session, {
    required String to,
    required int tokenId,
  }) async {
    final data = encodeMintCall(to, tokenId);
    return '0x${sha256.convert(utf8.encode(data))}';
  }
}
