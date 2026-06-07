import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/player_progress.dart';

class ProgressStorageService {
  static const String _progressKey = 'potio_player_progress_v1';

  Future<PlayerProgress> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressKey);

    if (raw == null || raw.isEmpty) {
      return PlayerProgress.initial();
    }

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return PlayerProgress.fromJson(decoded);
    } catch (_) {
      return PlayerProgress.initial();
    }
  }

  Future<void> saveProgress(PlayerProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_progressKey, jsonEncode(progress.toJson()));
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey);
  }
}
