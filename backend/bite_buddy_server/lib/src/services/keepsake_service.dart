import 'dart:io';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/keepsake_rules.dart';
import '../utils/portrait_rules.dart';
import 'keepsake/keepsake_minter.dart';
import 'memory_service.dart';
import 'pet_service.dart';

// Keepsakes: soulbound NFTs on Base for the buddy's certificate and its big
// milestones. Players get a wallet, then mint keepsakes they've earned from
// their memory book; wallets and marketplaces read each one's details from
// the public web routes (web/keepsake_routes.dart).
//
// Until a wallet provider (Privy) is set up, wallets are test wallets and
// the minter is a stub, so nothing reaches a real blockchain; the app says
// so wherever keepsakes appear.
class KeepsakeService {
  final PetService pets;
  final MemoryService memories;
  final KeepsakeMinter minter;
  final Random _rng;

  KeepsakeService({
    required this.pets,
    required this.memories,
    KeepsakeMinter? minter,
    Random? rng,
  }) : minter = minter ?? StubKeepsakeMinter(),
       _rng = rng ?? Random.secure();

  // ── Wallet ──────────────────────────────────────────────────────────────

  Future<WalletView?> wallet(Session session, UuidValue ownerId) async {
    final w = await _findWallet(session, ownerId);
    return w == null ? null : _walletView(w);
  }

  // Test mode makes up an address. With a real provider, the app would
  // create the wallet with the provider's SDK and the server would check
  // the address really belongs to this user before saving it.
  Future<WalletView> createWallet(
    Session session,
    UuidValue ownerId, {
    required bool showPetPhoto,
  }) async {
    await pets.requireMine(session, ownerId);
    final existing = await _findWallet(session, ownerId);
    if (existing != null) return _walletView(existing);
    try {
      final saved = await CryptoWallet.db.insertRow(
        session,
        CryptoWallet(
          ownerId: ownerId,
          address: _testAddress(),
          isTest: true,
          showPetPhoto: showPetPhoto,
          createdAt: DateTime.now().toUtc(),
        ),
      );
      return _walletView(saved);
    } on DatabaseUniqueViolationException {
      // Created by another request at the same moment
      return _walletView((await _findWallet(session, ownerId))!);
    }
  }

  Future<WalletView> setShowPetPhoto(
    Session session,
    UuidValue ownerId,
    bool show,
  ) async {
    final w = await _findWallet(session, ownerId);
    if (w == null) throw notFoundError('Wallet');
    return _walletView(
      await CryptoWallet.db.updateRow(session, w.copyWith(showPetPhoto: show)),
    );
  }

  // ── Keepsakes ───────────────────────────────────────────────────────────

  // Minted keepsakes and the ones that can be minted now, newest first
  Future<List<KeepsakeView>> list(Session session, UuidValue ownerId) async {
    final book = await memories.book(session, ownerId);
    final wallet = await _findWallet(session, ownerId);
    // Previews match what minting would make now
    final paw = book.portraitId != null && !(wallet?.showPetPhoto ?? false);
    final minted = {
      for (final k in await Keepsake.db.find(
        session,
        where: (t) => t.ownerId.equals(ownerId),
      ))
        k.key: k,
    };
    final views = <KeepsakeView>[
      for (final k in minted.values) _mintedView(session, k),
      for (final m in book.memories)
        if (keepsakeKeyFor(m.key) case final key?)
          if (!minted.containsKey(key))
            KeepsakeView(
              key: key,
              title: key == certificateKey ? 'Buddy certificate' : m.title,
              emoji: key == certificateKey ? '📜' : m.emoji,
              kind: keepsakeKind(key),
              earnedAt: m.happenedAt,
              minted: false,
              petName: book.petName,
              speciesKey: book.speciesKey,
              portraitId: paw ? null : book.portraitId,
              showPaw: paw,
            ),
    ];
    return views..sort((a, b) => b.earnedAt.compareTo(a.earnedAt));
  }

  // The keys of the caller's minted keepsakes, for the memory book
  Future<Set<String>> mintedKeys(Session session, UuidValue ownerId) async => {
    for (final k in await Keepsake.db.find(
      session,
      where: (t) => t.ownerId.equals(ownerId),
    ))
      k.key,
  };

  Future<KeepsakeView> mint(
    Session session,
    UuidValue ownerId,
    String key,
  ) async {
    final wallet = await _findWallet(session, ownerId);
    if (wallet == null) {
      throw conflictError('NO_WALLET', 'Create your wallet first.');
    }
    if (wallet.isTest && !minter.isTest) {
      throw conflictError(
        'TEST_WALLET',
        'This is a test wallet. Create a real wallet to mint on Base.',
      );
    }
    final pet = await pets.requireMine(session, ownerId);
    final book = await memories.book(session, ownerId);
    final memory = book.memories
        .where((m) => keepsakeKeyFor(m.key) == key)
        .firstOrNull;
    if (memory == null) {
      throw conflictError(
        'NOT_EARNED',
        "You haven't earned that keepsake yet.",
      );
    }
    final already = await Keepsake.db.findFirstRow(
      session,
      where: (t) => t.ownerId.equals(ownerId) & t.key.equals(key),
    );
    if (already != null) return _mintedView(session, already);

    final fedMeals = await Meal.db.find(
      session,
      where: (t) => t.ownerId.equals(ownerId) & t.fed.equals(true),
      orderBy: (t) => t.createdAt,
    );
    final group = editionGroupFor(key);
    final draft = Keepsake(
      ownerId: ownerId,
      key: key,
      editionGroup: group,
      edition: 0,
      title: key == certificateKey ? 'Buddy certificate' : memory.title,
      emoji: key == certificateKey ? '📜' : memory.emoji,
      petName: pet.name,
      speciesKey: pet.speciesKey,
      portraitId: wallet.showPetPhoto ? pet.portraitId : null,
      showPaw: pet.portraitId != null && !wallet.showPetPhoto,
      stat: keepsakeStat(
        key: key,
        earnedAt: memory.happenedAt,
        fedMeals: fedMeals,
        memoryDetail: memory.detail,
      ),
      earnedAt: memory.happenedAt,
      walletAddress: wallet.address,
      chainId: minter.chainId,
      mintedAt: DateTime.now().toUtc(),
    );

    // The row's id is the token id, so it's saved before minting. Editions
    // are numbered in order; two mints racing for one number retry.
    Keepsake? saved;
    for (var attempt = 0; saved == null; attempt++) {
      final count = await Keepsake.db.count(
        session,
        where: (t) => t.editionGroup.equals(group),
      );
      try {
        saved = await Keepsake.db.insertRow(
          session,
          draft.copyWith(edition: count + 1),
        );
      } on DatabaseUniqueViolationException {
        // Same key minted at the same moment: return that one
        final same = await Keepsake.db.findFirstRow(
          session,
          where: (t) => t.ownerId.equals(ownerId) & t.key.equals(key),
        );
        if (same != null) return _mintedView(session, same);
        if (attempt >= 4) rethrow;
      }
    }

    final pending = saved;
    final Keepsake minted;
    try {
      final txHash = await minter.mint(
        session,
        to: wallet.address,
        tokenId: pending.id!,
      );
      minted = await Keepsake.db.updateRow(
        session,
        pending.copyWith(txHash: txHash),
      );
    } catch (e) {
      // Nothing was minted: free the slot so it can be tried again
      await Keepsake.db.deleteRow(session, pending);
      session.log('Keepsake mint failed: $e', level: LogLevel.error);
      throw conflictError(
        'MINT_FAILED',
        "Couldn't mint right now. Please try again.",
      );
    }
    return _mintedView(session, minted);
  }

  // ── Public metadata (web/keepsake_routes.dart) ──────────────────────────

  Future<Keepsake?> findMinted(Session session, int tokenId) async {
    final k = await Keepsake.db.findById(session, tokenId);
    return k?.txHash == null ? null : k;
  }

  Future<Map<String, dynamic>> metadata(Session session, Keepsake k) async =>
      keepsakeMetadata(k, imageUrl: imageUrl(session, k.id!));

  Future<String> cardSvg(Session session, Keepsake k) async {
    if (k.showPaw) return keepsakeSvg(k);
    final portraitId = k.portraitId;
    if (portraitId != null) {
      final portrait = await PetPortrait.db.findById(session, portraitId);
      if (portrait != null) {
        final bytes = portrait.image.buffer.asUint8List(
          portrait.image.offsetInBytes,
          portrait.image.lengthInBytes,
        );
        return keepsakeSvg(
          k,
          picture: bytes,
          pictureMime: photoMimeType(bytes) ?? 'image/jpeg',
        );
      }
    }
    // The species art, copied from the app (assets/pets/)
    final art = File('assets/pets/pet_${k.speciesKey}.png');
    return art.existsSync()
        ? keepsakeSvg(
            k,
            picture: art.readAsBytesSync(),
            pictureMime: 'image/png',
          )
        : keepsakeSvg(k);
  }

  String metadataUrl(Session session, int tokenId) =>
      '${_webBase(session)}/keepsakes/$tokenId';

  String imageUrl(Session session, int tokenId) =>
      '${_webBase(session)}/keepsakes/$tokenId/image.svg';

  // ── Helpers ─────────────────────────────────────────────────────────────

  Future<CryptoWallet?> _findWallet(Session session, UuidValue ownerId) =>
      CryptoWallet.db.findFirstRow(
        session,
        where: (t) => t.ownerId.equals(ownerId),
      );

  WalletView _walletView(CryptoWallet w) => WalletView(
    address: w.address,
    isTest: w.isTest,
    networkName: w.isTest ? 'Test mode' : minter.networkName,
    showPetPhoto: w.showPetPhoto,
    explorerUrl: w.isTest ? null : walletExplorerUrl(minter.chainId, w.address),
  );

  KeepsakeView _mintedView(Session session, Keepsake k) => KeepsakeView(
    key: k.key,
    title: k.title,
    emoji: k.emoji,
    kind: keepsakeKind(k.key),
    earnedAt: k.earnedAt,
    minted: true,
    tokenId: k.id,
    edition: k.edition,
    stat: k.stat,
    petName: k.petName,
    speciesKey: k.speciesKey,
    portraitId: k.portraitId,
    showPaw: k.showPaw,
    isTest: k.chainId == 0,
    txUrl: k.chainId == 0 || k.txHash == null
        ? null
        : keepsakeTxUrl(k.chainId, k.txHash!),
    metadataUrl: metadataUrl(session, k.id!),
    imageUrl: imageUrl(session, k.id!),
  );

  String _webBase(Session session) {
    final web =
        session.serverpod.config.webServer ??
        session.serverpod.config.apiServer;
    final defaultPort =
        (web.publicScheme == 'https' && web.publicPort == 443) ||
        (web.publicScheme == 'http' && web.publicPort == 80);
    return '${web.publicScheme}://${web.publicHost}'
        '${defaultPort ? '' : ':${web.publicPort}'}';
  }

  String _testAddress() =>
      '0x${List.generate(20, (_) => _rng.nextInt(256).toRadixString(16).padLeft(2, '0')).join()}';
}
