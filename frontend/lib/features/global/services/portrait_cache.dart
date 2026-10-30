import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bite_buddy_client/bite_buddy_client.dart';
import 'package:flutter/painting.dart';

// Pictures of users' real pets ("My own pet"), fetched once per app run
// and shared by every screen that shows a buddy.
class PortraitCache {
  final Client client;

  PortraitCache({required this.client});

  final Map<int, Future<Uint8List?>> _loads = {};

  // Null if the picture can't be fetched; callers then show the species art
  Future<Uint8List?> load(int portraitId) => _loads.putIfAbsent(
    portraitId,
    () async {
      try {
        final data = await client.portrait.image(portraitId);
        return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      } catch (_) {
        // Try again next time it's needed
        _loads.remove(portraitId);
        return null;
      }
    },
  );

  // A picture just made by this user, so showing it needs no download
  void put(int portraitId, Uint8List bytes) =>
      _loads[portraitId] = Future.value(bytes);
}

// The photo cut into a circle with a mint ring, the way buddies made from
// photos are shown everywhere (the arena and the home widget can't clip, so
// they get it already cut)
Future<ui.Image> circularPortrait(Uint8List bytes, {int size = 512}) async {
  final codec = await ui.instantiateImageCodec(
    bytes,
    targetWidth: size,
    targetHeight: size,
  );
  final photo = (await codec.getNextFrame()).image;
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final s = size.toDouble();
  final ring = s * 0.04;
  final circle = ui.Rect.fromLTWH(ring, ring, s - 2 * ring, s - 2 * ring);
  canvas.save();
  canvas.clipPath(ui.Path()..addOval(circle));
  paintImage(canvas: canvas, rect: circle, image: photo, fit: BoxFit.cover);
  canvas.restore();
  canvas.drawCircle(
    circle.center,
    circle.width / 2,
    ui.Paint()
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = ring
      ..color = const ui.Color(0xFF12C48B),
  );
  return recorder.endRecording().toImage(size, size);
}

Future<Uint8List?> circularPortraitPng(Uint8List bytes) async {
  final image = await circularPortrait(bytes);
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  return png?.buffer.asUint8List();
}
