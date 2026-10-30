import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

// Turns a photo of the user's pet into a buddy picture.
abstract class PortraitGenerator {
  Future<Uint8List> redraw(Session session, Uint8List photo, String animal);
}

// For now the "redraw" is the photo itself: Gemini's image models have no
// free tier (checked 30 Oct 2026: about 3-7 US cents a picture on a paid
// key). The app shows portraits in a circle, so a plain photo still looks
// right.
//
// To switch to real redraws: add a GeminiPortraitGenerator that calls an
// image model (e.g. gemini-3.1-flash-lite-image) with the photo, one of the
// species pictures as a style example and responseModalities: ["IMAGE"],
// using its own geminiImageApiKey from a billed project; then return it from
// PortraitService's default below.
class StubPortraitGenerator implements PortraitGenerator {
  const StubPortraitGenerator();

  @override
  Future<Uint8List> redraw(
    Session session,
    Uint8List photo,
    String animal,
  ) async => photo;
}
