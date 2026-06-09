import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class PotioAudioService {
  PotioAudioService._();

  static final PotioAudioService instance = PotioAudioService._();

  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _musicPlayer = AudioPlayer();

  final ValueNotifier<bool> soundEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> musicEnabled = ValueNotifier<bool>(true);

  bool _musicStarted = false;

  Future<void> playTap() async {
    await _playSound('audio/button_tap.mp3');
  }

  Future<void> playCorrect() async {
    await _playSound('audio/correct.mp3');
  }

  Future<void> playWrong() async {
    await _playSound('audio/wrong.mp3');
  }

  Future<void> playAchievement() async {
    await _playSound('audio/achievement.mp3');
  }

  Future<void> _playSound(String assetPath) async {
    if (!soundEnabled.value) return;

    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource(assetPath));
    } catch (error) {
      debugPrint('Sound effect failed: $error');
    }
  }

  Future<void> startBackgroundMusic() async {
    if (!musicEnabled.value) return;
    if (_musicStarted) return;

    try {
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.setVolume(0.35);
      await _musicPlayer.play(AssetSource('audio/background_music.mp3'));
      _musicStarted = true;
    } catch (error) {
      debugPrint('Background music failed: $error');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer.stop();
      _musicStarted = false;
    } catch (error) {
      debugPrint('Stopping background music failed: $error');
    }
  }

  Future<void> toggleSound() async {
    soundEnabled.value = !soundEnabled.value;

    if (soundEnabled.value) {
      await playTap();
    }
  }

  Future<void> toggleMusic() async {
    musicEnabled.value = !musicEnabled.value;

    if (musicEnabled.value) {
      await startBackgroundMusic();
    } else {
      await stopBackgroundMusic();
    }
  }

  Future<void> dispose() async {
    await _sfxPlayer.dispose();
    await _musicPlayer.dispose();
  }
}