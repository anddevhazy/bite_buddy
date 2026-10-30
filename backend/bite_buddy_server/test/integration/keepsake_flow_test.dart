import 'dart:typed_data';

import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/services/services.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Wallets and keepsake NFTs in test mode (the stub minter).
void main() {
  withServerpod('Keepsakes', (sessionBuilder, endpoints) {
    late UuidValue aliceId, bobId;
    late TestSessionBuilder alice, bob;

    TestSessionBuilder signIn(UuidValue id) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        id.toString(),
        {},
      ),
    );

    setUp(() async {
      aliceId = const Uuid().v4obj();
      bobId = const Uuid().v4obj();
      alice = signIn(aliceId);
      bob = signIn(bobId);
      final key = (await endpoints.pet.listSpecies(alice)).first.key;
      await endpoints.pet.adopt(alice, key, 'Biscuit');
      await endpoints.pet.adopt(bob, key, 'Rex');
    });

    test('a new buddy can mint its certificate once a wallet exists', () async {
      expect(await endpoints.wallet.mine(alice), isNull);
      await expectLater(
        endpoints.keepsake.mint(alice, 'certificate'),
        throwsA(
          isA<BiteBuddyException>().having((e) => e.code, 'code', 'NO_WALLET'),
        ),
      );

      final wallet = await endpoints.wallet.create(alice, false);
      expect(wallet.address, matches(RegExp(r'^0x[0-9a-f]{40}$')));
      expect(wallet.isTest, isTrue);
      expect(wallet.explorerUrl, isNull);
      // Creating again keeps the same wallet
      expect(
        (await endpoints.wallet.create(alice, true)).address,
        wallet.address,
      );

      final available = await endpoints.keepsake.mine(alice);
      expect(available.single.key, 'certificate');
      expect(available.single.minted, isFalse);

      final minted = await endpoints.keepsake.mint(alice, 'certificate');
      expect(minted.minted, isTrue);
      expect(minted.edition, greaterThanOrEqualTo(1));
      expect(minted.isTest, isTrue);
      expect(minted.txUrl, isNull);
      expect(
        minted.imageUrl,
        endsWith('/keepsakes/${minted.tokenId}/image.svg'),
      );

      // Minting again returns the same keepsake
      final again = await endpoints.keepsake.mint(alice, 'certificate');
      expect(again.tokenId, minted.tokenId);

      // The memory book marks it as minted
      final book = await endpoints.memory.book(alice);
      expect(
        book.memories.firstWhere((m) => m.key == 'adopted').keepsake,
        'minted',
      );
    });

    test('editions are numbered in mint order', () async {
      await endpoints.wallet.create(alice, false);
      await endpoints.wallet.create(bob, false);
      final first = await endpoints.keepsake.mint(alice, 'certificate');
      final second = await endpoints.keepsake.mint(bob, 'certificate');
      expect(second.edition, first.edition! + 1);
    });

    test("milestones that weren't earned can't be minted", () async {
      await endpoints.wallet.create(alice, false);
      await expectLater(
        endpoints.keepsake.mint(alice, 'streak_30'),
        throwsA(
          isA<BiteBuddyException>().having((e) => e.code, 'code', 'NOT_EARNED'),
        ),
      );
    });

    test('public metadata and card exist only once minted', () async {
      await endpoints.wallet.create(alice, false);
      final minted = await endpoints.keepsake.mint(alice, 'certificate');
      final session = alice.build();
      final row = await keepsakeService.findMinted(session, minted.tokenId!);
      expect(row, isNotNull);
      final meta = await keepsakeService.metadata(session, row!);
      expect(meta['name'], 'Buddy certificate · Biscuit');
      final svg = await keepsakeService.cardSvg(session, row);
      expect(svg, startsWith('<svg'));
      expect(svg, contains('Biscuit'));
      // The species art is embedded (run from the server folder)
      expect(svg, contains('data:image/png;base64,'));

      expect(await keepsakeService.findMinted(session, 999999), isNull);
    });

    test("an own-pet buddy shows a paw unless its photo is allowed", () async {
      final carolId = const Uuid().v4obj();
      final carol = signIn(carolId);
      final portrait = await PetPortrait.db.insertRow(
        carol.build(),
        PetPortrait(
          ownerId: carolId,
          image: ByteData(3),
          animal: 'cat',
          used: false,
          createdAt: DateTime.now().toUtc(),
        ),
      );
      await endpoints.portrait.adopt(carol, portrait.id!, 'Mittens');
      await endpoints.wallet.create(carol, false);

      expect((await endpoints.keepsake.mine(carol)).single.showPaw, isTrue);
      final minted = await endpoints.keepsake.mint(carol, 'certificate');
      expect(minted.showPaw, isTrue);
      expect(minted.portraitId, isNull);
      final row = await keepsakeService.findMinted(
        carol.build(),
        minted.tokenId!,
      );
      expect(
        await keepsakeService.cardSvg(carol.build(), row!),
        contains('🐾'),
      );
    });
  });
}
