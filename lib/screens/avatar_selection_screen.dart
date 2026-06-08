import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';
import 'premium_screen.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({super.key});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int selectedTab = 0;
  String selectedAvatarId = 'classic_bartender';
  String selectedFrameId = 'none';

  final Set<String> unlockedAchievementIds = const {
    // Later these will come from PlayerProgress / achievement storage.
    // For now, keep achievement rewards locked until real progress is connected.
  };

  final List<_AvatarItem> avatars = const [
    _AvatarItem(
      id: 'classic_bartender',
      name: 'Classic Bartender',
      subtitle: 'Default starter avatar',
      icon: Icons.local_bar,
      unlockType: _UnlockType.free,
    ),
    _AvatarItem(
      id: 'recipe_rookie',
      name: 'Recipe Rookie',
      subtitle: 'Unlocked by completing your first quiz',
      icon: Icons.receipt_long,
      unlockType: _UnlockType.achievement,
      achievementId: 'first_sip',
      unlockRequirement: 'Achievement: First Sip',
    ),
    _AvatarItem(
      id: 'daily_regular',
      name: 'Daily Regular',
      subtitle: 'Unlocked by completing 3 Daily Mixology challenges',
      icon: Icons.calendar_month,
      unlockType: _UnlockType.achievement,
      achievementId: 'daily_regular',
      unlockRequirement: 'Achievement: Daily Regular',
    ),
    _AvatarItem(
      id: 'academy_student',
      name: 'Academy Student',
      subtitle: 'Unlocked by completing 5 Basic Academy levels',
      icon: Icons.school,
      unlockType: _UnlockType.achievement,
      achievementId: 'academy_starter',
      unlockRequirement: 'Achievement: Academy Starter',
    ),
    _AvatarItem(
      id: 'perfect_pour',
      name: 'Perfect Pour',
      subtitle: 'Unlocked by scoring 100% in any quiz mode',
      icon: Icons.workspace_premium,
      unlockType: _UnlockType.achievement,
      achievementId: 'perfect_pour',
      unlockRequirement: 'Achievement: Perfect Pour',
    ),
    _AvatarItem(
      id: 'master_mixologist',
      name: 'Master Mixologist',
      subtitle: 'Premium avatar',
      icon: Icons.auto_awesome,
      unlockType: _UnlockType.premium,
      unlockRequirement: 'Requires Potio Premium',
    ),
    _AvatarItem(
      id: 'golden_shaker',
      name: 'Golden Shaker',
      subtitle: 'Premium avatar',
      icon: Icons.star,
      unlockType: _UnlockType.premium,
      unlockRequirement: 'Requires Potio Premium',
    ),
  ];

  final List<_AvatarItem> frames = const [
    _AvatarItem(
      id: 'none',
      name: 'No Frame',
      subtitle: 'Clean default profile style',
      icon: Icons.crop_square,
      unlockType: _UnlockType.free,
    ),
    _AvatarItem(
      id: 'copper_frame',
      name: 'Copper Frame',
      subtitle: 'Unlocked by completing your first quiz',
      icon: Icons.hexagon_outlined,
      unlockType: _UnlockType.achievement,
      achievementId: 'first_sip',
      unlockRequirement: 'Achievement: First Sip',
    ),
    _AvatarItem(
      id: 'mint_frame',
      name: 'Mint Frame',
      subtitle: 'Unlocked by saving 5 favourite drinks',
      icon: Icons.eco,
      unlockType: _UnlockType.achievement,
      achievementId: 'collector',
      unlockRequirement: 'Achievement: Collector',
    ),
    _AvatarItem(
      id: 'gold_award_frame',
      name: 'Gold Award Frame',
      subtitle: 'Unlocked by earning one gold award',
      icon: Icons.emoji_events,
      unlockType: _UnlockType.achievement,
      achievementId: 'gold_pour',
      unlockRequirement: 'Achievement: Gold Pour',
    ),
    _AvatarItem(
      id: 'diamond_bar_frame',
      name: 'Diamond Bar Frame',
      subtitle: 'Unlocked by earning gold on all Basic Academy levels',
      icon: Icons.diamond_outlined,
      unlockType: _UnlockType.achievement,
      achievementId: 'diamond_bar',
      unlockRequirement: 'Achievement: Diamond Bar',
    ),
    _AvatarItem(
      id: 'premium_emerald_frame',
      name: 'Emerald Premium Frame',
      subtitle: 'Premium frame',
      icon: Icons.workspace_premium,
      unlockType: _UnlockType.premium,
      unlockRequirement: 'Requires Potio Premium',
    ),
    _AvatarItem(
      id: 'premium_gold_frame',
      name: 'Golden Premium Frame',
      subtitle: 'Premium frame',
      icon: Icons.star_border,
      unlockType: _UnlockType.premium,
      unlockRequirement: 'Requires Potio Premium',
    ),
  ];

  List<_AvatarItem> get currentItems {
    return selectedTab == 0 ? avatars : frames;
  }

  String get selectedId {
    return selectedTab == 0 ? selectedAvatarId : selectedFrameId;
  }

  bool _isUnlocked(_AvatarItem item, bool premiumActive) {
    if (item.unlockType == _UnlockType.free) {
      return true;
    }

    if (item.unlockType == _UnlockType.premium) {
      return premiumActive;
    }

    if (item.unlockType == _UnlockType.achievement) {
      return item.achievementId != null &&
          unlockedAchievementIds.contains(item.achievementId);
    }

    return false;
  }

  void _selectItem(_AvatarItem item, bool premiumActive) {
    final unlocked = _isUnlocked(item, premiumActive);

    if (!unlocked) {
      _showLockedSheet(item);
      return;
    }

    setState(() {
      if (selectedTab == 0) {
        selectedAvatarId = item.id;
      } else {
        selectedFrameId = item.id;
      }
    });
  }

  void _showLockedSheet(_AvatarItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final isPremium = item.unlockType == _UnlockType.premium;

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
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: potioInk,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.unlockRequirement ?? 'Locked',
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
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: potioEmerald,
                      foregroundColor: potioPaper,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      isPremium ? 'Unlock Premium First' : 'Continue Playing',
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

  _AvatarItem _fallbackSelectedAvatar(bool premiumActive) {
    final selected = avatars.firstWhere(
      (avatar) => avatar.id == selectedAvatarId,
      orElse: () => avatars.first,
    );

    if (_isUnlocked(selected, premiumActive)) {
      return selected;
    }

    return avatars.first;
  }

  _AvatarItem _fallbackSelectedFrame(bool premiumActive) {
    final selected = frames.firstWhere(
      (frame) => frame.id == selectedFrameId,
      orElse: () => frames.first,
    );

    if (_isUnlocked(selected, premiumActive)) {
      return selected;
    }

    return frames.first;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: potioPremiumActiveNotifier,
      builder: (context, premiumActive, _) {
        final items = currentItems;
        final previewAvatar = _fallbackSelectedAvatar(premiumActive);
        final previewFrame = _fallbackSelectedFrame(premiumActive);

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
                  child: const Row(
                    children: [
                      Icon(
                        Icons.face,
                        color: potioEmerald,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PROFILE STYLE',
                              style: TextStyle(
                                color: potioCopper,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.3,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Avatars and frames',
                              style: TextStyle(
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
                            const Text(
                              'Hernandez',
                              style: TextStyle(
                                color: potioInk,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              premiumActive
                                  ? 'Premium active: premium avatars and frames unlocked.'
                                  : 'Preview your selected avatar and frame.',
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
                  onChanged: (index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                ),
                const SizedBox(height: 16),
                for (final item in items) ...[
                  _AvatarOptionCard(
                    item: item,
                    selected: item.id == selectedId,
                    unlocked: _isUnlocked(item, premiumActive),
                    onTap: () => _selectItem(item, premiumActive),
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

enum _UnlockType {
  free,
  achievement,
  premium,
}

class _AvatarItem {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final _UnlockType unlockType;
  final String? achievementId;
  final String? unlockRequirement;

  const _AvatarItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.unlockType,
    this.achievementId,
    this.unlockRequirement,
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
    final hasFrame = frame.id != 'none';

    return Container(
      padding: EdgeInsets.all(hasFrame ? 5 : 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: hasFrame
            ? Border.all(
                color: frame.unlockType == _UnlockType.premium
                    ? potioCopperLight
                    : potioEmerald,
                width: 4,
              )
            : null,
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
    );
  }
}

class _AvatarTabs extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onChanged;

  const _AvatarTabs({
    required this.selectedTab,
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
            label: 'Avatars',
            icon: Icons.face,
            selected: selectedTab == 0,
            onTap: () => onChanged(0),
          ),
          _TabButton(
            label: 'Frames',
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
  final bool selected;
  final bool unlocked;
  final VoidCallback onTap;

  const _AvatarOptionCard({
    required this.item,
    required this.selected,
    required this.unlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPremium = item.unlockType == _UnlockType.premium;
    final isAchievement = item.unlockType == _UnlockType.achievement;

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
                  Container(
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
                      item.name,
                      style: const TextStyle(
                        color: potioPaper,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        color: potioPaperDeep,
                        height: 1.3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (item.unlockRequirement != null) ...[
                      const SizedBox(height: 7),
                      Text(
                        item.unlockRequirement!,
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