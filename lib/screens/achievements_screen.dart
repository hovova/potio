import 'package:flutter/material.dart';

import '../data/achievements.dart';
import '../data/app_text.dart';
import '../models/achievement.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../services/progress_storage_service.dart';
import '../widgets/potio_card.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final ProgressStorageService _storage = ProgressStorageService();

  PlayerProgress _progress = PlayerProgress.initial();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final loaded = await _storage.loadProgress();

    if (!mounted) return;

    setState(() {
      _progress = loaded;
      _loading = false;
    });
  }

  int get unlockedCount {
    return allAchievements
        .where((achievement) => _progress.hasAchievement(achievement.id))
        .length;
  }

  int _progressCurrent(Achievement achievement) {
    switch (achievement.id) {
      case AchievementIds.firstLogin:
        return _progress.hasAchievement(AchievementIds.firstLogin) ? 1 : 0;
      case AchievementIds.firstQuiz:
        return _progress.hasAchievement(AchievementIds.firstQuiz) ? 1 : 0;
      case AchievementIds.recipeRookie:
        return _progress.hasAchievement(AchievementIds.recipeRookie) ? 5 : 0;
      case AchievementIds.dailyRegular:
        return _progress.hasAchievement(AchievementIds.dailyRegular) ? 3 : 0;
      case AchievementIds.academyStarter:
        return _progress.completedBasicLevels.clamp(0, 5);
      case AchievementIds.collector:
        return _progress.favouriteDrinkIds.length.clamp(0, 5);
      case AchievementIds.goldPour:
        return _progress.hasAchievement(AchievementIds.goldPour) ? 1 : 0;
      case AchievementIds.basicCampaignComplete:
        return _progress.completedBasicLevels.clamp(0, 20);
      case AchievementIds.diamondBar:
        return _progress.goldAwards.clamp(0, 20);
      case AchievementIds.addFriend:
        return _progress.hasAchievement(AchievementIds.addFriend) ? 1 : 0;
      case AchievementIds.duelWin:
        return _progress.hasAchievement(AchievementIds.duelWin) ? 1 : 0;
      default:
        return _progress.hasAchievement(achievement.id) ? 1 : 0;
    }
  }

  int _progressTarget(Achievement achievement) {
    switch (achievement.id) {
      case AchievementIds.recipeRookie:
        return 5;
      case AchievementIds.dailyRegular:
        return 3;
      case AchievementIds.academyStarter:
        return 5;
      case AchievementIds.collector:
        return 5;
      case AchievementIds.basicCampaignComplete:
        return 20;
      case AchievementIds.diamondBar:
        return 20;
      default:
        return 1;
    }
  }

  bool _isUnlocked(Achievement achievement) {
    return _progress.hasAchievement(achievement.id);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const PotioScaffold(
        child: Center(
          child: CircularProgressIndicator(
            color: potioCopperLight,
          ),
        ),
      );
    }

    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.languageCode,
      builder: (context, languageCode, _) {
        return PotioScaffold(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                  decoration: BoxDecoration(
                    color: potioPaper,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: potioEmerald,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppText.get(languageCode, 'achievements')
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: potioCopper,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              AppText.get(languageCode, 'mixology_rewards'),
                              style: const TextStyle(
                                color: potioInk,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.lock_open,
                        value: '$unlockedCount/${allAchievements.length}',
                        label: AppText.get(languageCode, 'unlocked'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.workspace_premium_outlined,
                        value: '${_progress.goldAwards}/20',
                        label: AppText.get(languageCode, 'gold_awards'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                for (final achievement in allAchievements) ...[
                  _AchievementCard(
                    achievement: achievement,
                    languageCode: languageCode,
                    unlocked: _isUnlocked(achievement),
                    current: _progressCurrent(achievement),
                    target: _progressTarget(achievement),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final String languageCode;
  final bool unlocked;
  final int current;
  final int target;

  const _AchievementCard({
    required this.achievement,
    required this.languageCode,
    required this.unlocked,
    required this.current,
    required this.target,
  });

  String get _titleKey {
    return 'achievement_${achievement.id}_title';
  }

  String get _subtitleKey {
    return 'achievement_${achievement.id}_subtitle';
  }

  String get _rewardKey {
    return 'achievement_${achievement.id}_reward';
  }

  @override
  Widget build(BuildContext context) {
    final safeTarget = target <= 0 ? 1 : target;
    final progress = (current / safeTarget).clamp(0.0, 1.0);

    final translatedTitle = AppText.get(languageCode, _titleKey);
    final translatedSubtitle = AppText.get(languageCode, _subtitleKey);
    final translatedReward = achievement.reward == null
        ? null
        : AppText.get(languageCode, _rewardKey);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          PotioAudioService.instance.playTap();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: unlocked
                ? potioEmerald.withValues(alpha: 0.95)
                : potioDarkCoffee.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: unlocked
                  ? potioPaper.withValues(alpha: 0.28)
                  : potioCopperLight.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: potioPaper.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  achievement.icon,
                  color: unlocked ? potioPaper : potioCopperLight,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translatedTitle,
                      style: const TextStyle(
                        color: potioPaper,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      translatedSubtitle,
                      style: const TextStyle(
                        color: potioPaperDeep,
                        height: 1.3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: potioPaper.withValues(alpha: 0.16),
                        color: unlocked ? potioCopperLight : potioSage,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$current/$target',
                      style: const TextStyle(
                        color: potioPaperDeep,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (translatedReward != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        translatedReward,
                        style: const TextStyle(
                          color: potioCopperLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                unlocked ? Icons.check_circle : Icons.lock_outline,
                color: unlocked ? potioPaper : potioCopperLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}