// Catches the same plate scanned again from a new angle, which the photo
// fingerprint can miss: the AI names it the same and its calories barely
// change.

const double maxCalorieDifference = 0.25; // as a share of the larger meal

Set<String> _words(String name) => name
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9 ]'), ' ')
    .split(' ')
    .where((w) => w.length > 2 && !_filler.contains(w))
    .toSet();

const _filler = {'and', 'with', 'the', 'plate', 'bowl', 'of', 'some', 'side'};

bool isSameDish({
  required String nameA,
  required int caloriesA,
  required String nameB,
  required int caloriesB,
}) {
  final a = _words(nameA);
  final b = _words(nameB);
  if (a.isEmpty || b.isEmpty) return false;
  // Most of the words in common: "Jollof Rice with Chicken" and "Chicken
  // Jollof Rice" match; "Jollof Rice" and "Fried Rice" don't
  final overlap = a.intersection(b).length / a.union(b).length;
  if (overlap < 0.6) return false;
  final larger = caloriesA > caloriesB ? caloriesA : caloriesB;
  if (larger == 0) return true;
  return (caloriesA - caloriesB).abs() / larger <= maxCalorieDifference;
}
