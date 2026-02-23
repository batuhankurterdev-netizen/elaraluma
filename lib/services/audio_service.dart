import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._internal();
  static final AudioService instance = AudioService._internal();

  AudioCache? _cache;
  AudioPlayer? _player;
  bool get isPlaying => _player != null;

  Future<void> init() async {
    _cache = AudioCache(prefix: 'assets/sounds/');
  }

  Future<void> play() async {
    if (_player != null) return;
    try {
      final p = await _cache!.loop('gamesound.mpeg');
      _player = p;
    } catch (_) {
      // ignore errors; best-effort playback
    }
  }

  Future<void> stop() async {
    try {
      await _player?.stop();
    } catch (_) {}
    _player = null;
  }
}
