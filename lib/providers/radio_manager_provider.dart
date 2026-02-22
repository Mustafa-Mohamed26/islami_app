import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RadioMangerProvider extends ChangeNotifier {
  late AudioPlayer _player;
  String? _currentPlayingUrl;
  bool _isPlaying = false; // add initial value
  double _currentVolume = 1.0; // make volume range from 0.0 to 1.0

  String? get currentPlayingUrl => _currentPlayingUrl;
  bool get isPlaying => _isPlaying;
  double get currentVolume => _currentVolume;

  RadioMangerProvider() {
    _player = AudioPlayer();

    _player.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  // ▶️ play
  Future<void> play(String url) async {
    try {
      if (_currentPlayingUrl == url) {
        if (_isPlaying) {
          await _player.pause();
        } else {
          await _player.play();
        }
      } else {
        await _player.stop();
        _currentPlayingUrl = url;
        await _player.setUrl(url);
        await _player.play();
      }
    } catch (e) {
      debugPrint("❌ Error while playing radio: $e");
      _isPlaying = false;
      notifyListeners();
    }
  }

  // ⏹️ stop
  Future<void> stop(String url) async {
    try {
      if (_currentPlayingUrl == url) {
        await _player.stop();
        _currentPlayingUrl = null;
        _isPlaying = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("❌ Error while stopping radio: $e");
    }
  }

  // 🔇 mute / unmute
  Future<void> mute(String url, double volume) async {
    try {
      if (_currentPlayingUrl == url) {
        await _player.setVolume(volume);
        _currentVolume = volume;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("❌ Error changing volume: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
