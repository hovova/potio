import 'package:flutter/material.dart';

import '../data/achievements.dart';
import '../data/app_text.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../services/progress_storage_service.dart';
import '../widgets/potio_card.dart';
import 'achievements_screen.dart';
import 'avatar_selection_screen.dart';
import 'credits_screen.dart';
import 'leaderboard_screen.dart';
import 'premium_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProgressStorageService _storage = ProgressStorageService();

  PlayerProgress _progress = PlayerProgress.initial();
  bool _loading = true;

  int get unlockedAchievements {
    return allAchievements
        .where((achievement) => _progress.hasAchievement(achievement.id))
        .length;
  }

  bool get premiumActive {
    return _progress.hasPremium || potioPremiumActiveNotifier.value;
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final loaded = await _storage.loadProgress();

    PotioAudioService.instance.soundEnabled.value = loaded.soundEnabled;
    PotioAudioService.instance.musicEnabled.value = loaded.musicEnabled;
    LanguageService.instance.setLanguage(loaded.selectedLanguageCode);

    if (loaded.hasPremium) {
      potioPremiumActiveNotifier.value = true;
    }

    if (!mounted) return;

    setState(() {
      _progress = loaded;
      _loading = false;
    });
  }

  Future<void> _saveProgress(PlayerProgress progress) async {
    if (!mounted) return;

    setState(() {
      _progress = progress;
    });

    await _storage.saveProgress(progress);
  }

  Future<void> _openScreen(BuildContext context, Widget screen) async {
    await PotioAudioService.instance.playTap();

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    ).then((_) => _loadProgress());
  }

  void _editName(String languageCode) {
    final controller = TextEditingController(text: _progress.playerName);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          decoration: const BoxDecoration(
            color: potioPaper,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _SheetHandle(),
                const SizedBox(height: 18),
                Text(
                  AppText.get(languageCode, 'edit_player_name'),
                  style: const TextStyle(
                    color: potioInk,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  maxLength: 18,
                  style: const TextStyle(
                    color: potioInk,
                    fontWeight: FontWeight.w800,
                  ),
                  decoration: InputDecoration(
                    labelText: AppText.get(languageCode, 'player_name'),
                    labelStyle: const TextStyle(
                      color: potioMutedInk,
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    counterStyle: const TextStyle(color: potioMutedInk),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: potioEmerald,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: potioMutedInk.withValues(alpha: 0.18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: potioEmerald,
                      foregroundColor: potioPaper,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: () {
                      PotioAudioService.instance.playTap();

                      final newName = controller.text.trim();

                      if (newName.isEmpty) {
                        return;
                      }

                      _saveProgress(
                        _progress.copyWith(playerName: newName),
                      );

                      if (sheetContext.mounted) {
                        Navigator.pop(sheetContext);
                      }
                    },
                    child: Text(
                      AppText.get(languageCode, 'save_name'),
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openSettings(String languageCode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              decoration: const BoxDecoration(
                color: potioPaper,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                top: false,
                child: ValueListenableBuilder<bool>(
                  valueListenable: potioPremiumActiveNotifier,
                  builder: (context, debugPremiumActive, _) {
                    final activePremium =
                        _progress.hasPremium || debugPremiumActive;

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const _SheetHandle(),
                          const SizedBox(height: 18),
                          const Icon(
                            Icons.settings,
                            color: potioEmerald,
                            size: 38,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppText.get(languageCode, 'settings'),
                            style: const TextStyle(
                              color: potioInk,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _SettingRow(
                            icon: activePremium
                                ? Icons.verified
                                : Icons.workspace_premium,
                            title: AppText.get(languageCode, 'premium_status'),
                            value: activePremium
                                ? AppText.get(languageCode, 'active')
                                : AppText.get(languageCode, 'not_active'),
                          ),
                          _UnitDropdownRow(
                            languageCode: languageCode,
                            value: _progress.selectedUnitSystem,
                            onChanged: (unit) async {
                              if (unit == null) return;

                              await PotioAudioService.instance.playTap();

                              final updatedProgress =
                                  _progress.setUnitSystem(unit);

                              setModalState(() {
                                _progress = updatedProgress;
                              });

                              if (mounted) {
                                setState(() {
                                  _progress = updatedProgress;
                                });
                              }

                              await _storage.saveProgress(updatedProgress);
                            },
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable:
                                PotioAudioService.instance.soundEnabled,
                            builder: (context, enabled, _) {
                              return _SettingRow(
                                icon: enabled
                                    ? Icons.volume_up
                                    : Icons.volume_off,
                                title: AppText.get(
                                  languageCode,
                                  'sound_effects',
                                ),
                                value: enabled
                                    ? AppText.get(languageCode, 'on')
                                    : AppText.get(languageCode, 'off'),
                                onTap: () async {
                                  await PotioAudioService.instance.toggleSound();

                                  final updatedProgress =
                                      _progress.setSoundEnabled(
                                    PotioAudioService
                                        .instance.soundEnabled.value,
                                  );

                                  setModalState(() {
                                    _progress = updatedProgress;
                                  });

                                  if (mounted) {
                                    setState(() {
                                      _progress = updatedProgress;
                                    });
                                  }

                                  await _storage.saveProgress(updatedProgress);
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable:
                                PotioAudioService.instance.musicEnabled,
                            builder: (context, enabled, _) {
                              return _SettingRow(
                                icon: enabled
                                    ? Icons.music_note
                                    : Icons.music_off,
                                title: AppText.get(languageCode, 'music'),
                                value: enabled
                                    ? AppText.get(languageCode, 'on')
                                    : AppText.get(languageCode, 'off'),
                                onTap: () async {
                                  await PotioAudioService.instance.toggleMusic();

                                  final updatedProgress =
                                      _progress.setMusicEnabled(
                                    PotioAudioService
                                        .instance.musicEnabled.value,
                                  );

                                  setModalState(() {
                                    _progress = updatedProgress;
                                  });

                                  if (mounted) {
                                    setState(() {
                                      _progress = updatedProgress;
                                    });
                                  }

                                  await _storage.saveProgress(updatedProgress);
                                },
                              );
                            },
                          ),
                          _LanguageDropdownRow(
                            languageCode: languageCode,
                            value: _progress.selectedLanguageCode,
                            onChanged: (newLanguageCode) async {
                              if (newLanguageCode == null) return;

                              await PotioAudioService.instance.playTap();

                              final updatedProgress =
                                  _progress.setLanguage(newLanguageCode);

                              LanguageService.instance
                                  .setLanguage(newLanguageCode);

                              setModalState(() {
                                _progress = updatedProgress;
                              });

                              if (mounted) {
                                setState(() {
                                  _progress = updatedProgress;
                                });
                              }

                              await _storage.saveProgress(updatedProgress);
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: potioEmerald,
                                foregroundColor: potioPaper,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              onPressed: () {
                                PotioAudioService.instance.playTap();

                                if (sheetContext.mounted) {
                                  Navigator.pop(sheetContext);
                                }
                              },
                              child: Text(
                                AppText.get(languageCode, 'done'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
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
                        Icons.person,
                        color: potioEmerald,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          AppText.get(languageCode, 'bartender_profile')
                              .toUpperCase(),
                          style: const TextStyle(
                            color: potioCopper,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: potioPaper,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _ProfileAvatarPreview(
                        avatarId: _progress.selectedAvatarId,
                        frameId: _progress.selectedFrameId,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _progress.playerName,
                              style: const TextStyle(
                                color: potioInk,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              premiumActive
                                  ? AppText.get(
                                      languageCode,
                                      'premium_bartender',
                                    )
                                  : AppText.get(
                                      languageCode,
                                      'beginner_bartender',
                                    ),
                              style: const TextStyle(
                                color: potioMutedInk,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                PotioAudioService.instance.playTap();
                                _editName(languageCode);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    color: potioEmerald,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    AppText.get(languageCode, 'edit_name'),
                                    style: const TextStyle(
                                      color: potioEmerald,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: potioEmerald.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${AppText.get(languageCode, 'lvl')} ${_progress.level}',
                          style: const TextStyle(
                            color: potioEmerald,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.route_outlined,
                        value: '${_progress.completedBasicLevels}/20',
                        label: AppText.get(languageCode, 'levels_done'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.emoji_events_outlined,
                        value: '$unlockedAchievements/${allAchievements.length}',
                        label: AppText.get(languageCode, 'achievements'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.favorite_border,
                        value: '${_progress.favouriteDrinkIds.length}',
                        label: AppText.get(languageCode, 'favourites'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.bolt_outlined,
                        value: '${_progress.totalXp}',
                        label: AppText.get(languageCode, 'xp'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                PotioCard(
                  badge: AppText.get(languageCode, 'progress'),
                  icon: Icons.emoji_events_outlined,
                  title: AppText.get(languageCode, 'achievements'),
                  subtitle: AppText.get(
                    languageCode,
                    'achievement_card_subtitle',
                  ),
                  onTap: () => _openScreen(
                    context,
                    const AchievementsScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'profile'),
                  icon: Icons.face_outlined,
                  title: AppText.get(languageCode, 'avatar_selection'),
                  subtitle: AppText.get(
                    languageCode,
                    'avatar_selection_subtitle',
                  ),
                  onTap: () => _openScreen(
                    context,
                    const AvatarSelectionScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'ranking'),
                  icon: Icons.leaderboard_outlined,
                  title: AppText.get(languageCode, 'leaderboard'),
                  subtitle: AppText.get(
                    languageCode,
                    'leaderboard_card_subtitle',
                  ),
                  onTap: () => _openScreen(
                    context,
                    const LeaderboardScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'app'),
                  icon: Icons.settings_outlined,
                  title: AppText.get(languageCode, 'settings'),
                  subtitle: AppText.get(languageCode, 'settings_subtitle'),
                  onTap: () => _openSettings(languageCode),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'about'),
                  icon: Icons.info_outline,
                  title: AppText.get(languageCode, 'credits'),
                  subtitle: AppText.get(languageCode, 'credits_subtitle'),
                  onTap: () => _openScreen(context, const CreditsScreen()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileAvatarPreview extends StatelessWidget {
  final String avatarId;
  final String frameId;

  const _ProfileAvatarPreview({
    required this.avatarId,
    required this.frameId,
  });

  IconData get avatarIcon {
    switch (avatarId) {
      case 'welcome_bartender':
        return Icons.waving_hand;
      case 'recipe_rookie':
        return Icons.receipt_long;
      case 'daily_regular':
        return Icons.calendar_month;
      case 'academy_student':
        return Icons.school;
      case 'gold_pour_avatar':
        return Icons.emoji_events;
      case 'master_mixologist':
        return Icons.auto_awesome;
      case 'golden_shaker':
        return Icons.star;
      case 'classic_bartender':
      default:
        return Icons.local_bar;
    }
  }

  @override
  Widget build(BuildContext context) {
    final frameStyle = _ProfileFrameStyle.fromId(frameId);

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: frameStyle.gradient,
        border: frameStyle.border,
        boxShadow: frameStyle.shadows,
      ),
      child: Container(
        padding: EdgeInsets.all(frameId == 'none' ? 0 : 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: frameId == 'none'
              ? Colors.transparent
              : potioPaper.withValues(alpha: 0.50),
        ),
        child: Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: potioEmerald,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            avatarIcon,
            color: potioPaper,
            size: 36,
          ),
        ),
      ),
    );
  }
}

class _ProfileFrameStyle {
  final Gradient? gradient;
  final Border? border;
  final List<BoxShadow>? shadows;

  const _ProfileFrameStyle({
    this.gradient,
    this.border,
    this.shadows,
  });

  factory _ProfileFrameStyle.fromId(String id) {
    switch (id) {
      case 'copper_frame':
        return _ProfileFrameStyle(
          gradient: LinearGradient(
            colors: [
              potioCopper,
              potioCopperLight,
            ],
          ),
          border: Border.all(
            color: potioPaper,
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: potioCopper.withValues(alpha: 0.40),
              blurRadius: 14,
            ),
          ],
        );
      case 'mint_frame':
        return _ProfileFrameStyle(
          gradient: LinearGradient(
            colors: [
              potioSage,
              potioEmerald,
            ],
          ),
          border: Border.all(
            color: potioPaper,
            width: 2,
          ),
        );
      case 'gold_award_frame':
        return _ProfileFrameStyle(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD36A),
              potioCopperLight,
              Color(0xFFFFF0B8),
            ],
          ),
          border: Border.all(
            color: Color(0xFFFFF0B8),
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFFFFD36A).withValues(alpha: 0.45),
              blurRadius: 18,
            ),
          ],
        );
      case 'diamond_bar_frame':
        return _ProfileFrameStyle(
          gradient: LinearGradient(
            colors: [
              Color(0xFFDBF7FF),
              Color(0xFF8FD8FF),
              Color(0xFFFFFFFF),
            ],
          ),
          border: Border.all(
            color: Color(0xFFFFFFFF),
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFF8FD8FF).withValues(alpha: 0.45),
              blurRadius: 18,
            ),
          ],
        );
      case 'premium_emerald_frame':
        return _ProfileFrameStyle(
          gradient: LinearGradient(
            colors: [
              potioEmerald,
              Color(0xFF34D399),
              potioCopperLight,
            ],
          ),
          border: Border.all(
            color: potioCopperLight,
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: potioEmerald.withValues(alpha: 0.45),
              blurRadius: 18,
            ),
          ],
        );
      case 'premium_platinum_frame':
        return _ProfileFrameStyle(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD8E4F0),
              Color(0xFFB7C6D9),
            ],
          ),
          border: Border.all(
            color: Color(0xFFFFFFFF),
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFFD8E4F0).withValues(alpha: 0.55),
              blurRadius: 22,
            ),
          ],
        );
      case 'none':
      default:
        return const _ProfileFrameStyle();
    }
  }
}

class _UnitDropdownRow extends StatelessWidget {
  final String languageCode;
  final String value;
  final ValueChanged<String?> onChanged;

  const _UnitDropdownRow({
    required this.languageCode,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final safeValue = value == 'cl' ? 'cl' : 'ml';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: potioMutedInk.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.straighten,
            color: potioEmerald,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppText.get(languageCode, 'recipe_units'),
              style: const TextStyle(
                color: potioInk,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: safeValue,
              borderRadius: BorderRadius.circular(18),
              dropdownColor: potioPaper,
              iconEnabledColor: potioEmerald,
              style: const TextStyle(
                color: potioInk,
                fontWeight: FontWeight.w900,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'ml',
                  child: Text('ml'),
                ),
                DropdownMenuItem(
                  value: 'cl',
                  child: Text('cl'),
                ),
              ],
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageDropdownRow extends StatelessWidget {
  final String languageCode;
  final String value;
  final ValueChanged<String?> onChanged;

  const _LanguageDropdownRow({
    required this.languageCode,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final safeValue = switch (value) {
      'uk' => 'uk',
      'ru' => 'ru',
      _ => 'en',
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: potioMutedInk.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.language,
            color: potioEmerald,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppText.get(languageCode, 'language'),
              style: const TextStyle(
                color: potioInk,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: safeValue,
              borderRadius: BorderRadius.circular(18),
              dropdownColor: potioPaper,
              iconEnabledColor: potioEmerald,
              style: const TextStyle(
                color: potioInk,
                fontWeight: FontWeight.w900,
              ),
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(AppText.get(languageCode, 'english')),
                ),
                DropdownMenuItem(
                  value: 'uk',
                  child: Text(AppText.get(languageCode, 'ukrainian')),
                ),
                DropdownMenuItem(
                  value: 'ru',
                  child: Text(AppText.get(languageCode, 'russian')),
                ),
              ],
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _SettingRow({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: potioMutedInk.withValues(alpha: 0.12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: potioEmerald),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: potioInk,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: potioMutedInk,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 5,
      decoration: BoxDecoration(
        color: potioMutedInk.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}