import 'dart:io';
import 'dart:typed_data';

import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/portrait_rules.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// "Use my own pet". The AI check isn't called here: portraits are inserted
// directly, and the upload checks tested are the ones that run before it.
void main() {
  withServerpod('Pet portraits', (sessionBuilder, endpoints) {
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
      await endpoints.pet.adopt(alice, key, 'Fluffy');
      await endpoints.pet.adopt(bob, key, 'Rex');
    });

    Future<PetPortrait> portrait(UuidValue owner, {DateTime? at}) =>
        PetPortrait.db.insertRow(
          alice.build(),
          PetPortrait(
            ownerId: owner,
            image: ByteData.sublistView(Uint8List.fromList([1, 2, 3])),
            animal: 'dog',
            used: false,
            createdAt: at ?? DateTime.now().toUtc(),
          ),
        );

    final photo = ByteData.sublistView(
      File('test/fixtures/app_bg.jpg').readAsBytesSync(),
    );

    test('a portrait goes on the pet and shows up for friends', () async {
      final draft = await portrait(aliceId);

      // Nobody else can see a draft
      await expectLater(
        endpoints.portrait.image(bob, draft.id!),
        throwsA(isA<BiteBuddyException>()),
      );
      // ...or use someone else's
      await expectLater(
        endpoints.portrait.apply(bob, draft.id!),
        throwsA(isA<BiteBuddyException>()),
      );

      final pet = await endpoints.portrait.apply(alice, draft.id!);
      expect(pet.portraitId, draft.id);
      expect(
        (await endpoints.portrait.image(bob, draft.id!)).lengthInBytes,
        3,
      );

      final cleared = await endpoints.portrait.clear(alice);
      expect(cleared.portraitId, isNull);
      expect((await endpoints.pet.getMyPet(alice))!.portraitId, isNull);
    });

    test('bad uploads are refused before the AI is asked', () async {
      await expectLater(
        endpoints.portrait.create(
          alice,
          ByteData.sublistView(Uint8List(100)),
        ),
        throwsA(
          isA<BiteBuddyException>().having(
            (e) => e.code,
            'code',
            'INVALID_INPUT',
          ),
        ),
      );
    });

    test('only $maxPortraitsPerDay pictures can be made a day', () async {
      for (var i = 0; i < maxPortraitsPerDay; i++) {
        await portrait(aliceId);
      }
      await expectLater(
        endpoints.portrait.create(alice, photo),
        throwsA(
          isA<BiteBuddyException>().having(
            (e) => e.code,
            'code',
            'TOO_MANY_PORTRAITS',
          ),
        ),
      );
    });
  });
}
