import 'package:audioplayers/audioplayers.dart';

class PotioAudioService {
  static final AudioPlayer _musicPlayer = AudioPlayer();
  static final AudioPlayer _sfxPlayer = AudioPlayer();

  static bool musicEnabled = true;
  static bool soundEnabled = true;
  static bool _musicStarted = false;

  static Future<void> updateMusicState({required bool enabled}) async {
    musicEnabled = enabled;

    if (!enabled) {
      await _musicPlayer.pause();
      return;
    }

    if (_musicStarted) {
      await _musicPlayer.resume();
    }
  }

  static Future<void> updateSoundState({required bool enabled}) async {
    soundEnabled = enabled;
  }

  static Future<void> startMusicAfterUserGesture() async {
    if (!musicEnabled || _musicStarted) {
      return;
    }

    try {
      _musicStarted = true;
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.play(AssetSource('audio/background_music.mp3'));
    } catch (_) {
      _musicStarted = false;
    }
  }

  static Future<void> playButtonTap() async {
    await _playSfx('audio/button_tap.mp3');
  }

  static Future<void> playCorrect() async {
    await _playSfx('audio/correct.mp3');
  }

  static Future<void> playWrong() async {
    await _playSfx('audio/wrong.mp3');
  }

  static Future<void> playAchievement() async {
    await _playSfx('audio/achievement.mp3');
  }

  static Future<void> _playSfx(String assetPath) async {
    if (!soundEnabled) {
      return;
    }

    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource(assetPath));
    } catch (_) {
      // Keep the app running if audio assets are not added yet.
    }
  }

  static Future<void> pauseAllAudioForAppBackground() async {
    await _musicPlayer.pause();
  }

  static Future<void> resumeAudioAfterAppForeground() async {
    if (musicEnabled && _musicStarted) {
      await _musicPlayer.resume();
    }
  }

  static Future<void> dispose() async {
    await _musicPlayer.dispose();
    await _sfxPlayer.dispose();
  }
}
