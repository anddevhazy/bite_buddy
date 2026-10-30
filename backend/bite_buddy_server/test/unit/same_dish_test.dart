import 'package:bite_buddy_server/src/utils/same_dish.dart';
import 'package:test/test.dart';

void main() {
  bool same(String a, int ca, String b, int cb) =>
      isSameDish(nameA: a, caloriesA: ca, nameB: b, caloriesB: cb);

  test('the same dish named the same or reworded matches', () {
    expect(
      same('Jollof Rice with Chicken', 650, 'Jollof Rice with Chicken', 640),
      isTrue,
    );
    expect(
      same('Jollof Rice with Chicken', 650, 'Chicken Jollof Rice', 700),
      isTrue,
    );
    expect(same('Bread', 250, 'bread', 260), isTrue);
  });

  test('different dishes do not match', () {
    expect(same('Jollof Rice', 600, 'Fried Rice', 600), isFalse);
    expect(
      same('Spaghetti Bolognese', 700, 'Beans and Plantain', 650),
      isFalse,
    );
  });

  test('the same dish with a very different portion does not match', () {
    expect(same('Jollof Rice', 400, 'Jollof Rice', 900), isFalse);
  });
}
