import 'dart:typed_data';

import 'package:image/image.dart' as img;

// A 64-bit "difference hash" of a photo: shrink it to 9x8 grey pixels and note,
// for each row, whether each pixel is brighter than the one to its right.
// Two shots of the same plate give nearly the same bits even with a slightly
// different angle, light or zoom; different meals differ in about half of
// them. Stored as 16 hex characters.
// Null if the photo can't be decoded; the caller then skips the check.
String? photoFingerprint(Uint8List jpeg) {
  final img.Image? decoded;
  try {
    decoded = img.decodeJpg(jpeg);
  } on Object {
    return null; // a corrupt or truncated file
  }
  if (decoded == null) return null;

  // Phones often store photos sideways with a "rotate me" tag; apply it so
  // the same plate shot in portrait and landscape still compares sensibly
  final upright = img.bakeOrientation(decoded);
  final small = img.copyResize(
    upright,
    width: 9,
    height: 8,
    interpolation: img.Interpolation.average,
  );

  // Built as two 32-bit halves (rows 0-3, rows 4-7): a full 64-bit value
  // would turn negative in Dart once its top bit is set
  String rows(int from) {
    var bits = 0;
    for (var y = from; y < from + 4; y++) {
      for (var x = 0; x < 8; x++) {
        final left = small.getPixel(x, y).luminance;
        final right = small.getPixel(x + 1, y).luminance;
        bits = (bits << 1) | (left > right ? 1 : 0);
      }
    }
    return bits.toRadixString(16).padLeft(8, '0');
  }

  return rows(0) + rows(4);
}

// How many of the 64 bits differ: 0 for the same picture, ~32 for unrelated
// ones. Compared in two 32-bit halves so nothing depends on the sign bit.
int fingerprintDistance(String a, String b) =>
    _bitCount(_half(a, 0) ^ _half(b, 0)) + _bitCount(_half(a, 8) ^ _half(b, 8));

int _half(String hex, int start) =>
    int.parse(hex.substring(start, start + 8), radix: 16);

int _bitCount(int v) {
  var count = 0;
  for (; v != 0; v &= v - 1) {
    count++;
  }
  return count;
}
