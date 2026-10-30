import 'dart:convert';

import '../generated/protocol.dart';

// Keepsakes: which milestones can be minted as NFTs, what each card says,
// and the NFT metadata and card picture wallets show. Plain functions with
// no database, so they're easy to test.

const _mintableMilestones = {
  'streak_7',
  'streak_30',
  'streak_100',
  'streak_365',
  'level_10',
  'level_25',
  'level_50',
  'meals_100',
  'meals_500',
};

// The memory book calls adoption 'adopted'; its keepsake is the certificate
const certificateKey = 'certificate';

String? keepsakeKeyFor(String memoryKey) {
  if (memoryKey == 'adopted') return certificateKey;
  if (_mintableMilestones.contains(memoryKey)) return memoryKey;
  if (memoryKey.startsWith('trophy_')) return memoryKey;
  return null;
}

String keepsakeKind(String key) =>
    key == certificateKey ? 'certificate' : key.substring(0, key.indexOf('_'));

// Editions count per milestone (every 30-day streak shares one count), and
// all trophies share one
String editionGroupFor(String key) =>
    keepsakeKind(key) == 'trophy' ? 'trophy' : key;

const _kindLabels = {
  'certificate': 'BUDDY CERTIFICATE',
  'streak': 'STREAK',
  'level': 'LEVEL UP',
  'meals': 'MEALS',
  'trophy': 'LEAGUE TROPHY',
};

const _kindColors = {
  'certificate': '#12C48B',
  'streak': '#FFA41B',
  'level': '#5B8CFF',
  'meals': '#1FB48F',
  'trophy': '#F2C14E',
};

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String shortDate(DateTime t) => '${t.day} ${_months[t.month - 1]} ${t.year}';

int? _averageScore(Iterable<Meal> meals) {
  final list = meals.toList();
  if (list.isEmpty) return null;
  return (list.fold(0, (s, m) => s + m.healthScore) / list.length).round();
}

// One line about the moment it was earned. [fedMeals] are all the pet's fed
// meals, oldest first; [memoryDetail] is the memory book's detail line.
String? keepsakeStat({
  required String key,
  required DateTime earnedAt,
  required List<Meal> fedMeals,
  String? memoryDetail,
}) {
  final kind = keepsakeKind(key);
  final n = int.tryParse(key.substring(key.indexOf('_') + 1));
  switch (kind) {
    case 'certificate':
      return 'Adopted ${shortDate(earnedAt)}';
    case 'streak':
      final from = earnedAt.subtract(Duration(days: n ?? 0));
      final avg = _averageScore(
        fedMeals.where(
          (m) => !m.createdAt.isBefore(from) && !m.createdAt.isAfter(earnedAt),
        ),
      );
      return avg == null ? null : 'Avg meal score $avg over the streak';
    case 'level':
      final count = fedMeals
          .where((m) => !m.createdAt.isAfter(earnedAt))
          .length;
      return '$count meals eaten by then';
    case 'meals':
      final avg = _averageScore(fedMeals.take(n ?? 0));
      return avg == null ? null : 'Avg meal score $avg across them';
    default:
      return memoryDetail;
  }
}

String keepsakeTxUrl(int chainId, String txHash) => switch (chainId) {
  8453 => 'https://basescan.org/tx/$txHash',
  84532 => 'https://sepolia.basescan.org/tx/$txHash',
  _ => '',
};

String? walletExplorerUrl(int chainId, String address) => switch (chainId) {
  8453 => 'https://basescan.org/address/$address',
  84532 => 'https://sepolia.basescan.org/address/$address',
  _ => null,
};

// The standard NFT metadata wallets and marketplaces read
Map<String, dynamic> keepsakeMetadata(Keepsake k, {required String imageUrl}) {
  final kind = keepsakeKind(k.key);
  return {
    'name': '${k.title} · ${k.petName}',
    'description':
        'A Bite Buddy keepsake: ${k.title.toLowerCase()} for ${k.petName}, '
        'earned ${shortDate(k.earnedAt)}. Soulbound: it stays in the wallet '
        'it was minted to.',
    'image': imageUrl,
    'attributes': [
      {'trait_type': 'Kind', 'value': _kindLabels[kind] ?? kind},
      {'trait_type': 'Buddy', 'value': k.petName},
      {'display_type': 'number', 'trait_type': 'Edition', 'value': k.edition},
      {
        'display_type': 'date',
        'trait_type': 'Earned',
        'value': k.earnedAt.millisecondsSinceEpoch ~/ 1000,
      },
      if (k.stat != null) {'trait_type': 'Moment', 'value': k.stat},
      {'trait_type': 'Soulbound', 'value': 'Yes'},
    ],
  };
}

String _xml(String s) => s
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');

// The card picture: frame and colour for the kind, the buddy's picture,
// name, date, the moment's stat and the edition number. [picture] is the
// buddy's image (PNG or JPEG), or null for a paw.
String keepsakeSvg(Keepsake k, {List<int>? picture, String? pictureMime}) {
  final kind = keepsakeKind(k.key);
  final color = _kindColors[kind] ?? '#12C48B';
  final label = _kindLabels[kind] ?? kind.toUpperCase();
  const font = "font-family=\"'Fredoka', 'Nunito', Arial, sans-serif\"";
  final image = picture == null
      ? '<circle cx="300" cy="360" r="150" fill="#1C3A31"/>'
            '<text x="300" y="410" text-anchor="middle" font-size="140">🐾</text>'
      : '<image href="data:$pictureMime;base64,${base64Encode(picture)}" '
            'x="150" y="210" width="300" height="300" clip-path="url(#pic)" '
            'preserveAspectRatio="xMidYMid slice"/>';
  return '''
<svg xmlns="http://www.w3.org/2000/svg" width="600" height="840" viewBox="0 0 600 840">
<defs>
<linearGradient id="bg" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#123A2F"/><stop offset="1" stop-color="#0B231D"/></linearGradient>
<clipPath id="pic"><circle cx="300" cy="360" r="150"/></clipPath>
</defs>
<rect width="600" height="840" rx="40" fill="url(#bg)"/>
<rect x="18" y="18" width="564" height="804" rx="28" fill="none" stroke="$color" stroke-width="6"/>
<text x="300" y="100" text-anchor="middle" $font font-size="26" font-weight="700" letter-spacing="4" fill="$color">$label</text>
<text x="300" y="160" text-anchor="middle" $font font-size="46" font-weight="700" fill="#FFFFFF">${_xml(k.emoji)} ${_xml(k.title)}</text>
<circle cx="300" cy="360" r="160" fill="$color"/>
$image
<text x="300" y="590" text-anchor="middle" $font font-size="44" font-weight="700" fill="#FFFFFF">${_xml(k.petName)}</text>
<text x="300" y="636" text-anchor="middle" $font font-size="26" fill="#B7C4BF">${shortDate(k.earnedAt)}</text>
${k.stat == null ? '' : '<text x="300" y="690" text-anchor="middle" $font font-size="26" fill="#FFFFFF">${_xml(k.stat!)}</text>'}
<text x="300" y="765" text-anchor="middle" $font font-size="40" font-weight="700" fill="$color">#${k.edition}</text>
<text x="300" y="800" text-anchor="middle" $font font-size="18" fill="#B7C4BF">Bite Buddy Keepsake · Soulbound on Base</text>
</svg>''';
}
