import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._internal();
  static final AudioService instance = AudioService._internal();

  AudioPlayer? _player;
  bool get isPlaying => _player != null;

  Future<void> init() async {
    // Yeni sürümde AudioCache'i manuel init etmeye gerek kalmadı.
    // Varsayılan olarak 'assets/' klasörüne bakar.
  }

  Future<void> play() async {
    if (_player != null) return;
    try {
      // 1. Yeni bir player oluşturuyoruz
      _player = AudioPlayer();
      
      // 2. Döngü modunu (Loop) aktif ediyoruz
      await _player!.setReleaseMode(ReleaseMode.loop);
      
      // 3. Dosyayı çalıyoruz (prefix 'assets/sounds/' ise yol 'sounds/gamesound.mpeg' olmalı)
      // Not: Eğer ses dosyası assets/sounds içindeyse:
      await _player!.play(AssetSource('sounds/gamesound.mpeg'));
      
    } catch (e) {
      print("Ses çalma hatası: $e");
      _player = null;
    }
  }

  Future<void> stop() async {
    try {
      await _player?.stop();
      await _player?.dispose(); // Belleği temizlemek için ekledik
    } catch (_) {}
    _player = null;
  }
}
