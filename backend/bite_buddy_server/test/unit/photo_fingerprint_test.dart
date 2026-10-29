import 'dart:io';
import 'dart:typed_data';

import 'package:bite_buddy_server/src/services/meal_service.dart';
import 'package:bite_buddy_server/src/utils/photo_fingerprint.dart';
import 'package:image/image.dart' as img;
import 'package:test/test.dart';

void main() {
  Uint8List load(String name) =>
      File('test/fixtures/$name.jpg').readAsBytesSync();

  // A second shot of the same scene: re-encoded, slightly brighter, a little
  // zoomed in and at a different resolution
  Uint8List reshoot(Uint8List jpeg) {
    final original = img.decodeJpg(jpeg)!;
    final w = original.width, h = original.height;
    var shot = img.copyCrop(
      original,
      x: (w * 0.04).round(),
      y: (h * 0.04).round(),
      width: (w * 0.92).round(),
      height: (h * 0.92).round(),
    );
    shot = img.adjustColor(shot, brightness: 1.08);
    shot = img.copyResize(shot, width: 480);
    return img.encodeJpg(shot, quality: 70);
  }

  const limit = MealService.maxSamePlateDistance;

  test('fingerprints are 16 hex characters and stable', () {
    final a = photoFingerprint(load('splash_bg'))!;
    expect(a, matches(RegExp(r'^[0-9a-f]{16}$')));
    expect(photoFingerprint(load('splash_bg')), a);
    expect(fingerprintDistance(a, a), 0);
  });

  test('a re-shot of the same scene counts as the same plate', () {
    for (final name in ['splash_bg', 'app_bg', 'arena_bg']) {
      final original = photoFingerprint(load(name))!;
      final again = photoFingerprint(reshoot(load(name)))!;
      expect(
        fingerprintDistance(original, again),
        lessThanOrEqualTo(limit),
        reason: name,
      );
    }
  });

  test('different scenes are not treated as the same plate', () {
    final names = ['splash_bg', 'app_bg', 'arena_bg'];
    for (var i = 0; i < names.length; i++) {
      for (var j = i + 1; j < names.length; j++) {
        final d = fingerprintDistance(
          photoFingerprint(load(names[i]))!,
          photoFingerprint(load(names[j]))!,
        );
        expect(d, greaterThan(limit), reason: '${names[i]} vs ${names[j]}');
      }
    }
  });

  test('anything that is not a JPEG has no fingerprint', () {
    expect(photoFingerprint(Uint8List.fromList([1, 2, 3])), isNull);
  });
}
