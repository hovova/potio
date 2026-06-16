import 'package:flutter/material.dart';

import '../data/achievements.dart';
import '../data/app_text.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../services/progress_storage_service.dart';
import '../services/purchase_service.dart';
import '../widgets/potio_card.dart';
import 'premium_screen.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({super.key});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  final ProgressStorageService _storage = ProgressStorageService();

  int selectedTab = 0;
  PlayerProgress _progress = PlayerProgress.initial();
  bool _loading = true;

  final List<_AvatarItem> avatars = const [
    _AvatarItem(
      id: 'classic_bartender',
      titleKey: 'classic_bartender',
      subtitleKey: 'default_starter_avatar',
      icon: Icons.local_bar,
      unlockType: _UnlockType.free,
    ),
    _AvatarItem(
      id: 'welcome_bartender',
      titleKey: 'welcome_bartender',
      subtitleKey: 'unlocked_first_open',
      icon: Icons.waving_hand,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.firstLogin,
      unlockRequirementKey: 'achievement_first_login_title',
    ),
    _AvatarItem(
      id: 'recipe_rookie',
      titleKey: 'recipe_rookie',
      subtitleKey: 'unlocked_5_recipe_questions',
      icon: Icons.receipt_long,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.recipeRookie,
      unlockRequirementKey: 'achievement_recipe_rookie_title',
    ),
    _AvatarItem(
      id: 'daily_regular',
      titleKey: 'daily_regular',
      subtitleKey: 'unlocked_3_daily',
      icon: Icons.calendar_month,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.dailyRegular,
      unlockRequirementKey: 'achievement_daily_regular_title',
    ),
    _AvatarItem(
      id: 'academy_student',
      titleKey: 'academy_student',
      subtitleKey: 'unlocked_5_academy_levels',
      icon: Icons.school,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.academyStarter,
      unlockRequirementKey: 'achievement_academy_starter_title',
    ),
    _AvatarItem(
      id: 'gold_pour_avatar',
      titleKey: 'gold_pour_avatar',
      subtitleKey: 'unlocked_100_any_level',
      icon: Icons.emoji_events,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.goldPour,
      unlockRequirementKey: 'achievement_gold_pour_title',
    ),
    _AvatarItem(
      id: 'master_mixologist',
      titleKey: 'master_mixologist',
      subtitleKey: 'premium_avatar',
      icon: Icons.auto_awesome,
      unlockType: _UnlockType.premium,
      unlockRequirementKey: 'requires_potio_premium',
    ),
    _AvatarItem(
      id: 'golden_shaker',
      titleKey: 'golden_shaker',
      subtitleKey: 'premium_avatar',
      icon: Icons.star,
      unlockType: _UnlockType.premium,
      unlockRequirementKey: 'requires_potio_premium',
    ),
  ];

  final List<_AvatarItem> frames = const [
    _AvatarItem(
      id: 'none',
      titleKey: 'no_frame',
      subtitleKey: 'clean_default_profile_style',
      icon: Icons.crop_square,
      unlockType: _UnlockType.free,
    ),
    _AvatarItem(
      id: 'copper_frame',
      titleKey: 'copper_frame',
      subtitleKey: 'unlocked_first_quiz',
      icon: Icons.hexagon_outlined,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.firstQuiz,
      unlockRequirementKey: 'achievement_first_sip_title',
    ),
    _AvatarItem(
      id: 'mint_frame',
      titleKey: 'mint_frame',
      subtitleKey: 'unlocked_5_favourites',
      icon: Icons.eco,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.collector,
      unlockRequirementKey: 'achievement_collector_title',
    ),
    _AvatarItem(
      id: 'gold_award_frame',
      titleKey: 'gold_award_frame',
      subtitleKey: 'unlocked_100_any_level',
      icon: Icons.emoji_events,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.goldPour,
      unlockRequirementKey: 'achievement_gold_pour_title',
    ),
    _AvatarItem(
      id: 'diamond_bar_frame',
      titleKey: 'diamond_bar_frame',
      subtitleKey: 'unlocked_all_gold',
      icon: Icons.diamond_outlined,
      unlockType: _UnlockType.achievement,
      achievementId: AchievementIds.diamondBar,
      unlockRequirementKey: 'achievement_diamond_bar_title',
    ),
    _AvatarItem(
      id: 'premium_emerald_frame',
      titleKey: 'emerald_premium_frame',
      subtitleKey: 'premium_frame',
      icon: Icons.workspace_premium,
      unlockType: _UnlockType.premium,
      unlockRequirementKey: 'requires_potio_premium',
    ),
    _AvatarItem(
      id: 'premium_platinum_frame',
      titleKey: 'platinum_premium_frame',
      subtitleKey: 'premium_frame',
      icon: Icons.diamond_outlined,
      unlockType: _UnlockType.premium,
      unlockRequirementKey: 'requires_potio_premium',
    ),
  ];

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

  Future<void> _saveProgress(PlayerProgress progress) async {
    if (!mounted) return;

    setState(() {
      _progress = progress;
    });

    await _storage.saveProgress(progress);
  }

  List<_AvatarItem> get currentItems {
    return selectedTab == 0 ? avatars : frames;
  }

  String get selectedId {
    return selectedTab == 0
        ? _progress.selectedAvatarId
        : _progress.selectedFrameId;
  }

  bool get premiumActive {
    return _progress.hasPremium || PotioPurchaseService.instance.isPremium.value;
  }

  bool _isUnlocked(_AvatarItem item) {
    if (item.unlockType == _UnlockType.free) {
      return true;
    }

    if (item.unlockType == _UnlockType.premium) {
      return premiumActive;
    }

    if (item.unlockType == _UnlockType.achievement) {
      return item.achievementId != null &&
          _progress.hasAchievement(item.achievementId!);
    }

    return false;
  }

  Future<void> _selectItem(_AvatarItem item, String languageCode) async {
    PotioAudioService.instance.playTap();

    final unlocked = _isUnlocked(item);

    if (!unlocked) {
      _showLockedSheet(item, languageCode);
      return;
    }

    if (selectedTab == 0) {
      await _saveProgress(_progress.selectAvatar(item.id));
    } else {
      await _saveProgress(_progress.selectFrame(item.id));
    }
  }

  void _openPremiumSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.92,
        child: PremiumScreen(),
      ),
    ).then((_) => _loadProgress());
  }

  void _showLockedSheet(_AvatarItem item, String languageCode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final isPremium = item.unlockType == _UnlockType.premium;
        final title = AppText.get(languageCode, item.titleKey);
        final requirement = item.unlockRequirementKey == null
            ? AppText.get(languageCode, 'coming_soon')
            : isPremium
                ? AppText.get(languageCode, item.unlockRequirementKey!)
                : '${AppText.get(languageCode, 'achievements')}: ${AppText.get(languageCode, item.unlockRequirementKey!)}';

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
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: potioMutedInk.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 18),
                Icon(
                  isPremium ? Icons.workspace_premium : Icons.lock_outline,
                  color: potioEmerald,
                  size: 42,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: potioInk,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  requirement,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: potioMutedInk,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
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

                      Navigator.pop(sheetContext);

                      if (isPremium) {
                        Future.delayed(
                          const Duration(milliseconds: 180),
                          () {
                            if (!mounted) return;
                            _openPremiumSheet();
                          },
                        );
                      }
                    },
                    icon: Icon(
                      isPremium ? Icons.workspace_premium : Icons.play_arrow,
                    ),
                    label: Text(
                      isPremium
                          ? AppText.get(languageCode, 'go_to_premium')
                          : AppText.get(languageCode, 'continue_playing'),
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

  _AvatarItem _fallbackSelectedAvatar() {
    final selected = avatars.firstWhere(
      (avatar) => avatar.id == _progress.selectedAvatarId,
      orElse: () => avatars.first,
    );

    if (_isUnlocked(selected)) {
      return selected;
    }

    return avatars.first;
  }

  _AvatarItem _fallbackSelectedFrame() {
    final selected = frames.firstWhere(
      (frame) => frame.id == _progress.selectedFrameId,
      orElse: () => frames.first,
    );

    if (_isUnlocked(selected)) {
      return selected;
    }

    return frames.first;
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
        final items = currentItems;
        final previewAvatar = _fallbackSelectedAvatar();
        final previewFrame = _fallbackSelectedFrame();
        final previewFrameName = AppText.get(languageCode, previewFrame.titleKey);


        return ValueListenableBuilder<bool>(
          valueListenable: PotioPurchaseService.instance.isPremium,
          builder: (context, isPremiumActive, child) {
            return PotioScaffold(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      decoration: BoxDecoration(
                        color: potioPaper,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.16),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.face,
                            color: potioEmerald,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppText.get(languageCode, 'profile_style')
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
                                  AppText.get(
                                    languageCode,
                                    'avatars_and_frames',
                                  ),
                                  style: const TextStyle(
                                    color: potioInk,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          _ProfilePreview(
                            avatar: previewAvatar,
                            frame: previewFrame,
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
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  previewFrame.id == 'none'
                                      ? AppText.get(
                                          languageCode,
                                          'no_frame_selected',
                                        )
                                      : '$previewFrameName ${AppText.get(languageCode, 'selected').toLowerCase()}.',
                                  style: const TextStyle(
                                    color: potioMutedInk,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _AvatarTabs(
                      selectedTab: selectedTab,
                      avatarsLabel: AppText.get(languageCode, 'avatars'),
                      framesLabel: AppText.get(languageCode, 'frames'),
                      onChanged: (index) {
                        PotioAudioService.instance.playTap();

                        setState(() {
                          selectedTab = index;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    for (final item in items) ...[
                      _AvatarOptionCard(
                        item: item,
                        languageCode: languageCode,
                        selected: item.id == selectedId,
                        unlocked: _isUnlocked(item),
                        onTap: () => _selectItem(item, languageCode),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

enum _UnlockType {
  free,
  achievement,
  premium,
}

class _AvatarItem {
  final String id;
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final _UnlockType unlockType;
  final String? achievementId;
  final String? unlockRequirementKey;

  const _AvatarItem({
    required this.id,
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.unlockType,
    this.achievementId,
    this.unlockRequirementKey,
  });
}

class _ProfilePreview extends StatelessWidget {
  final _AvatarItem avatar;
  final _AvatarItem frame;

  const _ProfilePreview({
    required this.avatar,
    required this.frame,
  });

  @override
  Widget build(BuildContext context) {
    final frameStyle = _FrameStyle.fromId(frame.id);

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: frameStyle.gradient,
        border: frameStyle.border,
        boxShadow: frameStyle.shadows,
      ),
      child: Container(
        padding: EdgeInsets.all(frame.id == 'none' ? 0 : 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: frame.id == 'none'
              ? Colors.transparent
              : potioPaper.withValues(alpha: 0.50),
        ),
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: potioEmerald,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Icon(
            avatar.icon,
            color: potioPaper,
            size: 38,
          ),
        ),
      ),
    );
  }
}

class _AvatarTabs extends StatelessWidget {
  final int selectedTab;
  final String avatarsLabel;
  final String framesLabel;
  final ValueChanged<int> onChanged;

  const _AvatarTabs({
    required this.selectedTab,
    required this.avatarsLabel,
    required this.framesLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: potioDarkCoffee,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: potioCopperLight.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          _TabButton(
            label: avatarsLabel,
            icon: Icons.face,
            selected: selectedTab == 0,
            onTap: () => onChanged(0),
          ),
          _TabButton(
            label: framesLabel,
            icon: Icons.filter_frames,
            selected: selectedTab == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: selected ? potioPaper : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: selected ? potioEmerald : potioPaperDeep,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: selected ? potioInk : potioPaperDeep,
                    fontWeight: FontWeight.w900,
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

class _AvatarOptionCard extends StatelessWidget {
  final _AvatarItem item;
  final String languageCode;
  final bool selected;
  final bool unlocked;
  final VoidCallback onTap;

  const _AvatarOptionCard({
    required this.item,
    required this.languageCode,
    required this.selected,
    required this.unlocked,
    required this.onTap,
  });

  bool get isFrame {
    return item.id.contains('frame') || item.id == 'none';
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = item.unlockType == _UnlockType.premium;
    final isAchievement = item.unlockType == _UnlockType.achievement;

    final title = AppText.get(languageCode, item.titleKey);
    final subtitle = AppText.get(languageCode, item.subtitleKey);
    final requirement = item.unlockRequirementKey == null
        ? null
        : isPremium
            ? AppText.get(languageCode, item.unlockRequirementKey!)
            : '${AppText.get(languageCode, 'achievements')}: ${AppText.get(languageCode, item.unlockRequirementKey!)}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected
                ? potioEmerald.withValues(alpha: 0.95)
                : potioDarkCoffee.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: selected
                  ? potioPaper.withValues(alpha: 0.30)
                  : potioCopperLight.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  isFrame
                      ? _FrameMiniPreview(frameId: item.id)
                      : Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: potioPaper.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            item.icon,
                            color: selected ? potioPaper : potioCopperLight,
                          ),
                        ),
                  if (!unlocked)
                    Positioned(
                      right: -4,
                      bottom: -4,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isPremium ? potioCopperLight : potioEmerald,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPremium ? Icons.workspace_premium : Icons.lock,
                          color: potioInk,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: potioPaper,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: potioPaperDeep,
                        height: 1.3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (requirement != null) ...[
                      const SizedBox(height: 7),
                      Text(
                        requirement,
                        style: TextStyle(
                          color: isPremium
                              ? potioCopperLight
                              : isAchievement
                                  ? potioSage
                                  : potioPaperDeep,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (selected)
                const Icon(
                  Icons.check_circle,
                  color: potioPaper,
                )
              else if (unlocked)
                const Icon(
                  Icons.circle_outlined,
                  color: potioCopperLight,
                )
              else
                const Icon(
                  Icons.lock_outline,
                  color: potioCopperLight,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrameMiniPreview extends StatelessWidget {
  final String frameId;

  const _FrameMiniPreview({
    required this.frameId,
  });

  @override
  Widget build(BuildContext context) {
    final style = _FrameStyle.fromId(frameId);

    return Container(
      width: 54,
      height: 54,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: style.gradient,
        border: style.border,
        boxShadow: style.shadows,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: potioPaper.withValues(alpha: frameId == 'none' ? 0.10 : 0.70),
          shape: BoxShape.circle,
        ),
        child: Icon(
          frameId == 'none' ? Icons.block : Icons.local_bar,
          color: frameId == 'none' ? potioMutedInk : potioEmerald,
          size: 22,
        ),
      ),
    );
  }
}

class _FrameStyle {
  final Gradient? gradient;
  final Border? border;
  final List<BoxShadow>? shadows;

  const _FrameStyle({
    this.gradient,
    this.border,
    this.shadows,
  });

  factory _FrameStyle.fromId(String id) {
    switch (id) {
      case 'copper_frame':
        return _FrameStyle(
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
        return _FrameStyle(
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
        return _FrameStyle(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFD36A),
              potioCopperLight,
              const Color(0xFFFFF0B8),
            ],
          ),
          border: Border.all(
            color: const Color(0xFFFFF0B8),
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: const Color(0xFFFFD36A).withValues(alpha: 0.45),
              blurRadius: 18,
            ),
          ],
        );
      case 'diamond_bar_frame':
        return _FrameStyle(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFDBF7FF),
              Color(0xFF8FD8FF),
              Color(0xFFFFFFFF),
            ],
          ),
          border: Border.all(
            color: const Color(0xFFFFFFFF),
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: const Color(0xFF8FD8FF).withValues(alpha: 0.45),
              blurRadius: 18,
            ),
          ],
        );
      case 'premium_emerald_frame':
        return _FrameStyle(
          gradient: LinearGradient(
            colors: [
              potioEmerald,
              const Color(0xFF34D399),
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
        return _FrameStyle(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD8E4F0),
              Color(0xFFB7C6D9),
            ],
          ),
          border: Border.all(
            color: const Color(0xFFFFFFFF),
            width: 2,
          ),
          shadows: [
            BoxShadow(
              color: const Color(0xFFD8E4F0).withValues(alpha: 0.55),
              blurRadius: 22,
            ),
          ],
        );
      case 'none':
      default:
        return _FrameStyle(
          gradient: null,
          border: Border.all(
            color: potioMutedInk.withValues(alpha: 0.25),
            width: 2,
          ),
        );
    }
  }
}