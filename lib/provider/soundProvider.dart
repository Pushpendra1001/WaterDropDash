import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundProvider with ChangeNotifier {
  bool _soundEnabled = true;
  late AudioPlayer _audioPlayer;

  SoundProvider() {
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  bool get soundEnabled => _soundEnabled;

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    if (_soundEnabled) {
      _playBackgroundMusic();
    } else {
      _stopBackgroundMusic();
    }
    notifyListeners();
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('m2.mp3'));
  }

  void _stopBackgroundMusic() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}