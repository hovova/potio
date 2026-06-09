import 'package:flutter/material.dart';

import '../data/achievements.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
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

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    ).then((_) => _loadProgress());
  }

  void _editName() {
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
                const Text(
                  'Edit Player Name',
                  style: TextStyle(
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
                    labelText: 'Player name',
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
                    child: const Text(
                      'Save Name',
                      style: TextStyle(fontWeight: FontWeight.w900),
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

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
            child: ValueListenableBuilder<bool>(
              valueListenable: potioPremiumActiveNotifier,
              builder: (context, debugPremiumActive, _) {
                final activePremium = _progress.hasPremium || debugPremiumActive;

                return Column(
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
                    const Text(
                      'Settings',
                      style: TextStyle(
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
                      title: 'Premium Status',
                      value: activePremium ? 'Active' : 'Not active',
                    ),
                    _SettingRow(
                      icon: Icons.straighten,
                      title: 'Recipe Units',
                      value: _progress.selectedUnitSystem,
                      onTap: () {
                        PotioAudioService.instance.playTap();
                        _cycleUnits();
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: PotioAudioService.instance.soundEnabled,
                      builder: (context, enabled, _) {
                        return _SettingRow(
                          icon: enabled ? Icons.volume_up : Icons.volume_off,
                          title: 'Sound Effects',
                          value: enabled ? 'On' : 'Off',
                          onTap: () async {
                            await PotioAudioService.instance.toggleSound();

                            await _saveProgress(
                              _progress.setSoundEnabled(
                                PotioAudioService.instance.soundEnabled.value,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: PotioAudioService.instance.musicEnabled,
                      builder: (context, enabled, _) {
                        return _SettingRow(
                          icon: enabled ? Icons.music_note : Icons.music_off,
                          title: 'Music',
                          value: enabled ? 'On' : 'Off',
                          onTap: () async {
                            await PotioAudioService.instance.toggleMusic();

                            await _saveProgress(
                              _progress.setMusicEnabled(
                                PotioAudioService.instance.musicEnabled.value,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    _SettingRow(
                      icon: Icons.language,
                      title: 'Language',
                      value: _progress.selectedLanguageCode.toUpperCase(),
                    ),
                    const SizedBox(height: 16),
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

                          if (sheetContext.mounted) {
                            Navigator.pop(sheetContext);
                          }
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _cycleUnits() {
    final nextUnit = switch (_progress.selectedUnitSystem) {
      'ml' => 'oz',
      'oz' => 'cl',
      _ => 'ml',
    };

    _saveProgress(
      _progress.setUnitSystem(nextUnit),
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
              child: const Row(
                children: [
                  Icon(
                    Icons.person,
                    color: potioEmerald,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'BARTENDER PROFILE',
                      style: TextStyle(
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
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: potioEmerald,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.local_bar,
                      color: potioPaper,
                      size: 36,
                    ),
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
                              ? 'Premium Bartender'
                              : 'Beginner Bartender',
                          style: const TextStyle(
                            color: potioMutedInk,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            PotioAudioService.instance.playTap();
                            _editName();
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit,
                                color: potioEmerald,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Edit name',
                                style: TextStyle(
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
                      'LVL ${_progress.level}',
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
                    label: 'Levels done',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PotioStatPill(
                    icon: Icons.emoji_events_outlined,
                    value: '$unlockedAchievements/${allAchievements.length}',
                    label: 'Achievements',
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
                    label: 'Favourites',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PotioStatPill(
                    icon: Icons.bolt_outlined,
                    value: '${_progress.totalXp}',
                    label: 'XP',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            PotioCard(
              badge: 'Progress',
              icon: Icons.emoji_events_outlined,
              title: 'Achievements',
              subtitle:
                  'View achievement progress, rewards, avatars, and frames.',
              onTap: () => _openScreen(context, const AchievementsScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Profile',
              icon: Icons.face_outlined,
              title: 'Avatar Selection',
              subtitle:
                  'Choose your bartender avatar and future profile frames.',
              onTap: () => _openScreen(context, const AvatarSelectionScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Ranking',
              icon: Icons.leaderboard_outlined,
              title: 'Leaderboard',
              subtitle: 'Compare progress by XP, levels, and achievements.',
              onTap: () => _openScreen(context, const LeaderboardScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'App',
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle:
                  'Units, premium status, language, sound, music, and app preferences.',
              onTap: _openSettings,
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'About',
              icon: Icons.info_outline,
              title: 'Credits',
              subtitle: 'View Potio asset, recipe, and app credits.',
              onTap: () => _openScreen(context, const CreditsScreen()),
            ),
          ],
        ),
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