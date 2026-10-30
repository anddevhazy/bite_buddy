import 'package:bite_buddy_server/src/utils/portrait_rules.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> answer({
    bool isAnimal = true,
    bool? hasPeople = false,
    String animal = 'Dog',
    String reason = '',
  }) => {
    'isAnimal': isAnimal,
    'hasPeople': ?hasPeople,
    'animal': animal,
    'rejectionReason': reason,
  };

  test('a photo of just a pet is accepted', () {
    final check = readPortraitCheck(answer());
    expect(check.animal, 'dog');
  });

  test('no animal is rejected with the AI reason', () {
    final check = readPortraitCheck(
      answer(isAnimal: false, animal: '', reason: 'That looks like a shoe.'),
    );
    expect(check.animal, isNull);
    expect(check.reason, 'That looks like a shoe.');
  });

  test('people in the photo are always rejected', () {
    final check = readPortraitCheck(answer(hasPeople: true));
    expect(check.animal, isNull);
    expect(check.reason, contains('no people'));
  });

  test('a missing people answer counts as people', () {
    expect(readPortraitCheck(answer(hasPeople: null)).animal, isNull);
  });

  test('an animal with no name is rejected with a default reason', () {
    final check = readPortraitCheck(answer(animal: '  '));
    expect(check.animal, isNull);
    expect(check.reason, isNotEmpty);
  });

  test('photos are recognised as JPEG or PNG', () {
    expect(photoMimeType([0xFF, 0xD8, 0xFF, 0xE0]), 'image/jpeg');
    expect(
      photoMimeType([0x89, 0x50, 0x4E, 0x47, 13, 10, 26, 10, 0]),
      'image/png',
    );
    expect(photoMimeType([0x47, 0x49, 0x46, 0x38, 0x39]), isNull);
  });
}
