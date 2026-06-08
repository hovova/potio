import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedFilter = 'XP';

  final List<String> filters = const [
    'XP',
    'Levels',
    'Gold',
  ];

  final List<_LeaderboardPlayer> players = const [
  _LeaderboardPlayer(
    name: 'Hernandez',
    title: 'Beginner Bartender',
    xp: 0,
    level: 1,
    completedLevels: 0,
    goldAwards: 0,
    isCurrentPlayer: true,
  ),
  _LeaderboardPlayer(
    name: 'Bot Amelia',
    title: 'Mojito Apprentice',
    xp: 980,
    level: 9,
    completedLevels: 15,
    goldAwards: 6,
  ),
  _LeaderboardPlayer(
    name: 'Bot Marco',
    title: 'Whiskey Specialist',
    xp: 840,
    level: 8,
    completedLevels: 13,
    goldAwards: 5,
  ),
  _LeaderboardPlayer(
    name: 'Bot Sofia',
    title: 'Citrus Expert',
    xp: 720,
    level: 7,
    completedLevels: 11,
    goldAwards: 4,
  ),
  _LeaderboardPlayer(
    name: 'Bot Leo',
    title: 'Recipe Rookie',
    xp: 610,
    level: 6,
    completedLevels: 9,
    goldAwards: 3,
  ),
  _LeaderboardPlayer(
    name: 'Bot Maya',
    title: 'Daily Mixology Regular',
    xp: 470,
    level: 5,
    completedLevels: 7,
    goldAwards: 2,
  ),
  _LeaderboardPlayer(
    name: 'Bot Noah',
    title: 'Bar Student',
    xp: 320,
    level: 4,
    completedLevels: 5,
    goldAwards: 1,
  ),
  _LeaderboardPlayer(
    name: 'Bot Emma',
    title: 'Glassware Learner',
    xp: 190,
    level: 3,
    completedLevels: 3,
    goldAwards: 0,
  ),
  _LeaderboardPlayer(
    name: 'Bot Oliver',
    title: 'New Bartender',
    xp: 90,
    level: 2,
    completedLevels: 1,
    goldAwards: 0,
  ),
];

  List<_LeaderboardPlayer> get sortedPlayers {
    final sorted = [...players];

    if (selectedFilter == 'XP') {
      sorted.sort((a, b) => b.xp.compareTo(a.xp));
    } else if (selectedFilter == 'Levels') {
      sorted.sort((a, b) => b.completedLevels.compareTo(a.completedLevels));
    } else {
      sorted.sort((a, b) => b.goldAwards.compareTo(a.goldAwards));
    }

    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final rankedPlayers = sortedPlayers;

    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const PotioPageHeader(
              eyebrow: 'Ranking',
              title: 'Leaderboard',
              subtitle:
                  'Compare mixology XP, academy progress, and gold awards. Online ranking can be connected later.',
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
                      label: filter,
                      selected: selectedFilter == filter,
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 18),
            const Row(
              children: [
                Expanded(
                  child: PotioStatPill(
                    icon: Icons.bolt_outlined,
                    value: '0',
                    label: 'Your XP',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PotioStatPill(
                    icon: Icons.workspace_premium_outlined,
                    value: '0',
                    label: 'Gold awards',
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
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _LeaderboardPlayer {
  final String name;
  final String title;
  final int xp;
  final int level;
  final int completedLevels;
  final int goldAwards;
  final bool isCurrentPlayer;

  const _LeaderboardPlayer({
    required this.name,
    required this.title,
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

  const _LeaderboardCard({
    required this.rank,
    required this.player,
    required this.selectedFilter,
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
                  player.isCurrentPlayer ? '${player.name}  •  You' : player.name,
                  style: TextStyle(
                    color: highlight ? potioPaper : potioPaper,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  player.title,
                  style: TextStyle(
                    color: highlight ? potioPaperDeep : potioPaperDeep,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    _MiniStat(label: 'XP', value: '${player.xp}', highlighted: highlight),
                    _MiniStat(label: 'LVL', value: '${player.level}', highlighted: highlight),
                    _MiniStat(
                      label: 'Levels',
                      value: '${player.completedLevels}/20',
                      highlighted: highlight,
                    ),
                    _MiniStat(
                      label: 'Gold',
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
    if (selectedFilter == 'XP') {
      return '${player.xp} XP';
    }

    if (selectedFilter == 'Levels') {
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