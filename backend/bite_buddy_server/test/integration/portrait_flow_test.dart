import 'dart:io';
import 'dart:typed_data';

import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/portrait_rules.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// "My own pet" on the buddy picker. The AI check isn't called here: portraits are inserted
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
      // Alice is new and will pick "My own pet"; Bob has a normal buddy
      final key = (await endpoints.pet.listSpecies(bob)).first.key;
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

    test('adopting with a portrait picks a species and shows the picture '
        'to friends', () async {
      final draft = await portrait(aliceId);

      // Nobody else can see a draft, or adopt with it
      await expectLater(
        endpoints.portrait.image(bob, draft.id!),
        throwsA(isA<BiteBuddyException>()),
      );
      await expectLater(
        endpoints.portrait.adopt(signIn(const Uuid().v4obj()), draft.id!, 'X'),
        throwsA(isA<BiteBuddyException>()),
      );

      final pet = await endpoints.portrait.adopt(alice, draft.id!, 'Biscuit');
      expect(pet.name, 'Biscuit');
      expect(pet.portraitId, draft.id);
      final species = await endpoints.pet.listSpecies(alice);
      expect(species.map((s) => s.key), contains(pet.speciesKey));

      expect(
        (await endpoints.portrait.image(bob, draft.id!)).lengthInBytes,
        3,
      );

      // One pet per user, however it was adopted
      await expectLater(
        endpoints.portrait.adopt(alice, draft.id!, 'Again'),
        throwsA(isA<BiteBuddyException>()),
      );
      await expectLater(
        endpoints.portrait.create(bob, photo),
        throwsA(
          isA<BiteBuddyException>().having((e) => e.code, 'code', 'PET_EXISTS'),
        ),
      );
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
