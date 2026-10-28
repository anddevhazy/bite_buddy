import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Two players become friends, battle each other's pets, build a shared streak
// and compete in a group challenge.
void main() {
  withServerpod('Bite Buddy social', (sessionBuilder, endpoints) {
    TestSessionBuilder player() => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        const Uuid().v4(),
        {},
      ),
    );

    late TestSessionBuilder ada;
    late TestSessionBuilder bo;

    setUp(() async {
      ada = player();
      bo = player();
      final key = (await endpoints.pet.listSpecies(ada)).first.key;
      await endpoints.pet.adopt(ada, key, 'Ada Pup');
      await endpoints.pet.adopt(bo, key, 'Bo Pup');
    });

    Future<void> befriend() async {
      await endpoints.friend.add(bo, await endpoints.friend.myCode(ada));
      final request = (await endpoints.friend.list(ada)).single;
      await endpoints.friend.accept(ada, request.friendshipId);
    }

    Future<FeedResult> feedHealthyMeal(TestSessionBuilder who) async {
      final userId = UuidValue.fromString(
        who.build().authenticated!.userIdentifier,
      );
      final meal = await Meal.db.insertRow(
        who.build(),
        Meal(
          ownerId: userId,
          name: 'Grilled fish',
          description: '',
          calories: 450,
          proteinPct: 50,
          carbsPct: 20,
          fatsPct: 15,
          vitaminsPct: 30,
          mineralsPct: 30,
          fiberPct: 20,
          healthScore: 85,
          grade: 'A',
          imageHash: const Uuid().v4(),
          fed: false,
          createdAt: DateTime.now().toUtc(),
        ),
      );
      return endpoints.meal.feed(who, meal.id!, 0);
    }

    test('a friend request is pending until accepted', () async {
      final sent = await endpoints.friend.add(
        bo,
        (await endpoints.friend.myCode(ada)).toLowerCase(),
      );
      expect(sent.status, FriendStatus.outgoing);
      expect(sent.petName, 'Ada Pup');

      final incoming = (await endpoints.friend.list(ada)).single;
      expect(incoming.status, FriendStatus.incoming);
      expect(incoming.petName, 'Bo Pup');

      final accepted = await endpoints.friend.accept(
        ada,
        incoming.friendshipId,
      );
      expect(accepted.status, FriendStatus.friends);
      expect(
        (await endpoints.friend.list(bo)).single.status,
        FriendStatus.friends,
      );
    });

    test('adding each other accepts the first request', () async {
      await endpoints.friend.add(bo, await endpoints.friend.myCode(ada));
      final friend = await endpoints.friend.add(
        ada,
        await endpoints.friend.myCode(bo),
      );
      expect(friend.status, FriendStatus.friends);
    });

    test('bad codes, your own code and repeats are rejected', () async {
      Matcher code(String c) =>
          throwsA(isA<BiteBuddyException>().having((e) => e.code, 'code', c));

      await expectLater(endpoints.friend.add(ada, 'ZZZZZZ'), code('NOT_FOUND'));
      await expectLater(
        endpoints.friend.add(ada, await endpoints.friend.myCode(ada)),
        code('INVALID_INPUT'),
      );
      await befriend();
      await expectLater(
        endpoints.friend.add(bo, await endpoints.friend.myCode(ada)),
        code('ALREADY_FRIENDS'),
      );
    });

    test("friends' pets show up as opponents and can be battled", () async {
      await befriend();
      final opponents = await endpoints.battle.opponents(ada);
      final bosPet = opponents.singleWhere((o) => o.difficulty == 'Friend');
      expect(bosPet.name, 'Bo Pup');

      var state = await endpoints.battle.start(ada, bosPet.key);
      while (state.battle.status == BattleStatus.ongoing) {
        state = await endpoints.battle.move(
          ada,
          state.battle.id!,
          BattleMove.attack,
        );
      }
      expect(state.battle.status, isNot(BattleStatus.ongoing));
    });

    test('strangers can not battle your pet', () async {
      final bosPetId = (await endpoints.pet.getMyPet(bo))!.id;
      await expectLater(
        endpoints.battle.start(ada, 'friend:$bosPetId'),
        throwsA(isA<BiteBuddyException>()),
      );
    });

    test('feeding on the same day starts a shared streak', () async {
      await befriend();
      await feedHealthyMeal(ada);
      expect((await endpoints.friend.list(ada)).single.sharedStreak, 0);

      await feedHealthyMeal(bo);
      expect((await endpoints.friend.list(ada)).single.sharedStreak, 1);
      expect((await endpoints.friend.list(bo)).single.sharedStreak, 1);
    });

    test('unfriending removes the friend for both players', () async {
      await befriend();
      final friend = (await endpoints.friend.list(ada)).single;
      await endpoints.friend.remove(ada, friend.friendshipId);
      expect(await endpoints.friend.list(bo), isEmpty);
    });

    test('a challenge ranks members by healthy meals', () async {
      final created = await endpoints.challenge.create(ada, 'Veggie Week', 7);
      expect(created.isOwner, isTrue);
      expect(created.standings.single.isYou, isTrue);

      final joined = await endpoints.challenge.join(
        bo,
        created.code.toLowerCase(),
      );
      expect(joined.standings, hasLength(2));

      await feedHealthyMeal(bo);
      final standings = (await endpoints.challenge.get(
        ada,
        created.id,
      )).standings;
      expect(standings.first.petName, 'Bo Pup');
      expect(standings.first.score, 1);
      expect(standings.last.score, 0);

      expect(await endpoints.challenge.mine(bo), hasLength(1));
    });

    test('only members can see a challenge, and the last one out deletes it',
        () async {
      final created = await endpoints.challenge.create(ada, 'Solo', 3);
      await expectLater(
        endpoints.challenge.get(bo, created.id),
        throwsA(isA<BiteBuddyException>()),
      );
      await endpoints.challenge.leave(ada, created.id);
      expect(await Challenge.db.findById(ada.build(), created.id), isNull);
    });
  });
}
