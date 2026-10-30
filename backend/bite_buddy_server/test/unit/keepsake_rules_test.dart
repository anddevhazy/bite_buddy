import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/services/keepsake/keepsake_minter.dart';
import 'package:bite_buddy_server/src/utils/keepsake_rules.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final owner = UuidValue.fromString('11111111-1111-4111-8111-111111111111');
  final earned = DateTime.utc(2026, 10, 20, 9);

  Meal meal(DateTime at, int score) => Meal(
    ownerId: owner,
    name: 'meal',
    description: '',
    calories: 400,
    proteinPct: 20,
    carbsPct: 20,
    fatsPct: 20,
    vitaminsPct: 20,
    mineralsPct: 20,
    fiberPct: 20,
    healthScore: score,
    grade: 'B',
    imageHash: '',
    fed: true,
    createdAt: at,
  );

  Keepsake keepsake({String key = 'streak_30', String name = 'Biscuit'}) =>
      Keepsake(
        id: 12,
        ownerId: owner,
        key: key,
        editionGroup: editionGroupFor(key),
        edition: 7,
        title: '30-day streak',
        emoji: '🔥',
        petName: name,
        speciesKey: 'fluffy',
        stat: 'Avg meal score 82 over the streak',
        earnedAt: earned,
        walletAddress: '0x${'ab' * 20}',
        txHash: '0x01',
        chainId: 0,
        mintedAt: earned,
      );

  test('only big milestones can be minted', () {
    expect(keepsakeKeyFor('adopted'), certificateKey);
    expect(keepsakeKeyFor('streak_30'), 'streak_30');
    expect(keepsakeKeyFor('streak_3'), isNull);
    expect(keepsakeKeyFor('level_25'), 'level_25');
    expect(keepsakeKeyFor('level_2'), isNull);
    expect(keepsakeKeyFor('meals_100'), 'meals_100');
    expect(keepsakeKeyFor('meals_10'), isNull);
    expect(keepsakeKeyFor('trophy_3_1761523200000'), 'trophy_3_1761523200000');
    expect(keepsakeKeyFor('first_meal'), isNull);
  });

  test('editions count per milestone, and trophies all together', () {
    expect(editionGroupFor('streak_30'), 'streak_30');
    expect(editionGroupFor('trophy_3_1'), 'trophy');
    expect(editionGroupFor('trophy_9_2'), 'trophy');
    expect(keepsakeKind(certificateKey), 'certificate');
    expect(keepsakeKind('level_10'), 'level');
  });

  test('the mint call is encoded for mint(address,uint256)', () {
    final data = encodeMintCall('0x${'AB' * 20}', 255);
    expect(data, startsWith('0x40c10f19'));
    expect(data.length, 2 + 8 + 64 + 64);
    expect(data.substring(10, 74), '${'0' * 24}${'ab' * 20}');
    expect(data.substring(74), '${'0' * 62}ff');
    expect(() => encodeMintCall('0x1234', 1), throwsArgumentError);
  });

  test("each card's stat describes its moment", () {
    final meals = [
      meal(earned.subtract(const Duration(days: 40)), 40),
      meal(earned.subtract(const Duration(days: 10)), 80),
      meal(earned.subtract(const Duration(days: 2)), 90),
      meal(earned.add(const Duration(days: 1)), 10),
    ];
    expect(
      keepsakeStat(key: 'streak_30', earnedAt: earned, fedMeals: meals),
      'Avg meal score 85 over the streak',
    );
    expect(
      keepsakeStat(key: 'level_10', earnedAt: earned, fedMeals: meals),
      '3 meals eaten by then',
    );
    expect(
      keepsakeStat(key: 'meals_100', earnedAt: earned, fedMeals: meals),
      'Avg meal score 55 across them',
    );
    expect(
      keepsakeStat(key: certificateKey, earnedAt: earned, fedMeals: []),
      'Adopted 20 Oct 2026',
    );
    expect(
      keepsakeStat(
        key: 'trophy_1_2',
        earnedAt: earned,
        fedMeals: [],
        memoryDetail: 'Season score 88',
      ),
      'Season score 88',
    );
  });

  test('metadata follows the NFT standard and names the buddy', () {
    final m = keepsakeMetadata(keepsake(), imageUrl: 'https://x/12/image.svg');
    expect(m['name'], '30-day streak · Biscuit');
    expect(m['image'], 'https://x/12/image.svg');
    final traits = {
      for (final a in m['attributes'] as List) a['trait_type']: a['value'],
    };
    expect(traits['Edition'], 7);
    expect(traits['Kind'], 'STREAK');
    expect(traits['Soulbound'], 'Yes');
  });

  test('the card escapes names and shows the edition', () {
    final svg = keepsakeSvg(keepsake(name: 'Tom & <Jerry>'));
    expect(svg, contains('Tom &amp; &lt;Jerry&gt;'));
    expect(svg, isNot(contains('<Jerry>')));
    expect(svg, contains('#7'));
    expect(svg, contains('🐾')); // no picture given
    final withPicture = keepsakeSvg(
      keepsake(),
      picture: [1, 2, 3],
      pictureMime: 'image/png',
    );
    expect(withPicture, contains('data:image/png;base64,AQID'));
  });

  test('explorer links only exist on real networks', () {
    expect(keepsakeTxUrl(8453, '0xab'), 'https://basescan.org/tx/0xab');
    expect(keepsakeTxUrl(84532, '0xab'), contains('sepolia'));
    expect(walletExplorerUrl(0, '0xab'), isNull);
  });
}
