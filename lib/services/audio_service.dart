import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class PotioAudioService {
  PotioAudioService._();

  static final PotioAudioService instance = PotioAudioService._();

  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _musicPlayer = AudioPlayer();

  final ValueNotifier<bool> soundEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> musicEnabled = ValueNotifier<bool>(true);

  final ValueNotifier<double> soundVolume = ValueNotifier<double>(0.75);
  final ValueNotifier<double> musicVolume = ValueNotifier<double>(0.25);

  bool _musicStarted = false;

  Future<void> playTap() async {
    // The audioplayers package automatically prefixes with "assets/"
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
      await _sfxPlayer.setVolume(soundVolume.value);
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
      await _musicPlayer.setVolume(musicVolume.value);
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

  Future<void> setSoundVolume(double value) async {
    final clamped = value.clamp(0.0, 1.0);
    soundVolume.value = clamped;
    await _sfxPlayer.setVolume(clamped);

    if (soundEnabled.value) {
      await playTap();
    }
  }

  Future<void> setMusicVolume(double value) async {
    final clamped = value.clamp(0.0, 1.0);
    musicVolume.value = clamped;
    await _musicPlayer.setVolume(clamped);
  }

  int get soundVolumePercent {
    return (soundVolume.value * 100).round();
  }

  int get musicVolumePercent {
    return (musicVolume.value * 100).round();
  }

  Future<void> dispose() async {
    await _sfxPlayer.dispose();
    await _musicPlayer.dispose();
  }
}