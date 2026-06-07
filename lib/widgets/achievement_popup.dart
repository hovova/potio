import 'package:flutter/material.dart';

import '../models/achievement.dart';
import '../services/audio_service.dart';

void showAchievementPopup(
  BuildContext context,
  Achievement achievement,
) {
  PotioAudioService.playAchievement();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF3A1B0F),
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      content: Row(
        children: [
          Text(
            achievement.emoji,
            style: const TextStyle(fontSize: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: const TextStyle(
                    color: Color(0xFFFFE2B8),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  achievement.description,
                  style: const TextStyle(
                    color: Color(0xFFE8CBAA),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
