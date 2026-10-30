import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Every sound in the game. Files live in assets/audio/ as <name>.mp3 (mp3
// rather than ogg because iPhones can't play ogg). A missing file is simply
// skipped, so the game works before every sound has been added.
enum Sfx {
  hit,
  heavyHit,
  block,
  perfectBlock,
  dodge,
  windup,
  special,
  stun,
  knockout,
  victory,
  defeat,
  countdown,
  fight,
  tap,
  feed,
  levelUp;

  // heavyHit -> heavy_hit.mp3
  String get file =>
      '${name.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}')}.mp3';
}

class SoundService extends ChangeNotifier {
  final FlutterSecureStorage _storage;
  static const _mutedKey = 'sound_muted';

  bool _muted = false;
  // The files that were found and preloaded
  final _available = <Sfx>{};

  SoundService(this._storage);

  bool get muted => _muted;

  // Loads the mute setting and preloads whichever sound files exist
  Future<void> init() async {
    try {
      _muted = await _storage.read(key: _mutedKey) == 'true';
    } on PlatformException {
      _muted = false;
    }
    for (final sfx in Sfx.values) {
      try {
        await FlameAudio.audioCache.load(sfx.file);
        _available.add(sfx);
      } catch (_) {
        // Not added yet: play() will skip it
      }
    }
  }

  void play(Sfx sfx, {double volume = 1}) {
    if (_muted || !_available.contains(sfx)) return;
    // Fire and forget; a sound that fails to play isn't worth an error
    FlameAudio.play(sfx.file, volume: volume).ignore();
  }

  Future<void> setMuted(bool muted) async {
    _muted = muted;
    notifyListeners();
    try {
      await _storage.write(key: _mutedKey, value: '$muted');
    } on PlatformException {
      // Not remembered this time; the setting still applies now
    }
  }
}
