import 'package:flutter/material.dart';

import '../data/app_text.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../widgets/potio_card.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedFilter = 'xp';

  final List<_LeaderboardFilter> filters = const [
    _LeaderboardFilter(id: 'xp', labelKey: 'xp'),
    _LeaderboardFilter(id: 'levels', labelKey: 'levels'),
    _LeaderboardFilter(id: 'gold', labelKey: 'gold'),
  ];

  final List<_LeaderboardPlayer> players = const [
    _LeaderboardPlayer(
      name: 'Hernandez',
      titleKey: 'beginner_bartender',
      xp: 0,
      level: 1,
      completedLevels: 0,
      goldAwards: 0,
      isCurrentPlayer: true,
    ),
    _LeaderboardPlayer(
      name: 'Bot Amelia',
      titleKey: 'mojito_apprentice',
      xp: 980,
      level: 9,
      completedLevels: 15,
      goldAwards: 6,
    ),
    _LeaderboardPlayer(
      name: 'Bot Marco',
      titleKey: 'whiskey_specialist',
      xp: 840,
      level: 8,
      completedLevels: 13,
      goldAwards: 5,
    ),
    _LeaderboardPlayer(
      name: 'Bot Sofia',
      titleKey: 'citrus_expert',
      xp: 720,
      level: 7,
      completedLevels: 11,
      goldAwards: 4,
    ),
    _LeaderboardPlayer(
      name: 'Bot Leo',
      titleKey: 'recipe_rookie',
      xp: 610,
      level: 6,
      completedLevels: 9,
      goldAwards: 3,
    ),
    _LeaderboardPlayer(
      name: 'Bot Maya',
      titleKey: 'daily_mixology_regular',
      xp: 470,
      level: 5,
      completedLevels: 7,
      goldAwards: 2,
    ),
    _LeaderboardPlayer(
      name: 'Bot Noah',
      titleKey: 'bar_student',
      xp: 320,
      level: 4,
      completedLevels: 5,
      goldAwards: 1,
    ),
    _LeaderboardPlayer(
      name: 'Bot Emma',
      titleKey: 'glassware_learner',
      xp: 190,
      level: 3,
      completedLevels: 3,
      goldAwards: 0,
    ),
    _LeaderboardPlayer(
      name: 'Bot Oliver',
      titleKey: 'new_bartender',
      xp: 90,
      level: 2,
      completedLevels: 1,
      goldAwards: 0,
    ),
  ];

  List<_LeaderboardPlayer> get sortedPlayers {
    final sorted = [...players];

    if (selectedFilter == 'xp') {
      sorted.sort((a, b) => b.xp.compareTo(a.xp));
    } else if (selectedFilter == 'levels') {
      sorted.sort((a, b) => b.completedLevels.compareTo(a.completedLevels));
    } else {
      sorted.sort((a, b) => b.goldAwards.compareTo(a.goldAwards));
    }

    return sorted;
  }

  void _selectFilter(String filterId) {
    PotioAudioService.instance.playTap();

    setState(() {
      selectedFilter = filterId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rankedPlayers = sortedPlayers;

    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.languageCode,
      builder: (context, languageCode, _) {
        return PotioScaffold(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                PotioPageHeader(
                  eyebrow: AppText.get(languageCode, 'ranking'),
                  title: AppText.get(languageCode, 'leaderboard'),
                  subtitle: AppText.get(languageCode, 'compare_progress'),
                  icon: Icons.leaderboard,
                ),
                const SizedBox(height: 18),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: PotioChip(
                          label: AppText.get(languageCode, filter.labelKey),
                          selected: selectedFilter == filter.id,
                          onTap: () => _selectFilter(filter.id),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.bolt_outlined,
                        value: '0',
                        label: AppText.get(languageCode, 'your_xp'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PotioStatPill(
                        icon: Icons.workspace_premium_outlined,
                        value: '0',
                        label: AppText.get(languageCode, 'gold_awards'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                for (int index = 0; index < rankedPlayers.length; index++) ...[
                  _LeaderboardCard(
                    rank: index + 1,
                    player: rankedPlayers[index],
                    selectedFilter: selectedFilter,
                    languageCode: languageCode,
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LeaderboardFilter {
  final String id;
  final String labelKey;

  const _LeaderboardFilter({
    required this.id,
    required this.labelKey,
  });
}

class _LeaderboardPlayer {
  final String name;
  final String titleKey;
  final int xp;
  final int level;
  final int completedLevels;
  final int goldAwards;
  final bool isCurrentPlayer;

  const _LeaderboardPlayer({
    required this.name,
    required this.titleKey,
    required this.xp,
    required this.level,
    required this.completedLevels,
    required this.goldAwards,
    this.isCurrentPlayer = false,
  });
}

class _LeaderboardCard extends StatelessWidget {
  final int rank;
  final _LeaderboardPlayer player;
  final String selectedFilter;
  final String languageCode;

  const _LeaderboardCard({
    required this.rank,
    required this.player,
    required this.selectedFilter,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final highlight = player.isCurrentPlayer;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight
            ? potioEmerald.withValues(alpha: 0.92)
            : potioDarkCoffee.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: highlight
              ? potioPaper.withValues(alpha: 0.28)
              : potioCopperLight.withValues(alpha: 0.18),
        ),
        boxShadow: highlight
            ? [
                BoxShadow(
                  color: potioEmerald.withValues(alpha: 0.20),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          _RankBadge(rank: rank, highlighted: highlight),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: potioPaper.withValues(alpha: highlight ? 0.20 : 0.10),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              player.isCurrentPlayer ? Icons.local_bar : Icons.person,
              color: highlight ? potioPaper : potioCopperLight,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.isCurrentPlayer
                      ? '${player.name}  •  ${AppText.get(languageCode, 'you')}'
                      : player.name,
                  style: const TextStyle(
                    color: potioPaper,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  AppText.get(languageCode, player.titleKey),
                  style: const TextStyle(
                    color: potioPaperDeep,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    _MiniStat(
                      label: AppText.get(languageCode, 'xp'),
                      value: '${player.xp}',
                      highlighted: highlight,
                    ),
                    _MiniStat(
                      label: AppText.get(languageCode, 'lvl'),
                      value: '${player.level}',
                      highlighted: highlight,
                    ),
                    _MiniStat(
                      label: AppText.get(languageCode, 'levels'),
                      value: '${player.completedLevels}/20',
                      highlighted: highlight,
                    ),
                    _MiniStat(
                      label: AppText.get(languageCode, 'gold'),
                      value: '${player.goldAwards}',
                      highlighted: highlight,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _mainValueText(player),
            style: TextStyle(
              color: highlight ? potioPaper : potioCopperLight,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  String _mainValueText(_LeaderboardPlayer player) {
    if (selectedFilter == 'xp') {
      return '${player.xp} ${AppText.get(languageCode, 'xp')}';
    }

    if (selectedFilter == 'levels') {
      return '${player.completedLevels}/20';
    }

    return '${player.goldAwards} 🏅';
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;
  final bool highlighted;

  const _RankBadge({
    required this.rank,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    final icon = rank == 1
        ? Icons.looks_one
        : rank == 2
            ? Icons.looks_two
            : rank == 3
                ? Icons.looks_3
                : Icons.circle;

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: highlighted
            ? potioPaper.withValues(alpha: 0.18)
            : potioCopperLight.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Center(
        child: rank <= 3
            ? Icon(
                icon,
                color: highlighted ? potioPaper : potioCopperLight,
                size: 22,
              )
            : Text(
                '$rank',
                style: TextStyle(
                  color: highlighted ? potioPaper : potioCopperLight,
                  fontWeight: FontWeight.w900,
                ),
              ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final bool highlighted;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: highlighted
            ? potioPaper.withValues(alpha: 0.16)
            : potioPaper.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label $value',
        style: TextStyle(
          color: highlighted ? potioPaper : potioPaperDeep,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}