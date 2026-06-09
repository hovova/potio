import 'package:flutter/material.dart';

class PotioAchievement {
  final String id;
  final String title;
  final String subtitle;
  final int current;
  final int target;
  final IconData icon;
  final String? reward;

  const PotioAchievement({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.current,
    required this.target,
    required this.icon,
    this.reward,
  });

  bool get unlocked => current >= target;
}

const potioAchievements = [
  PotioAchievement(
    id: 'first_login',
    title: 'Welcome to Potio',
    subtitle: 'Open Potio for the first time.',
    current: 1,
    target: 1,
    icon: Icons.waving_hand,
    reward: 'Unlocks Welcome Bartender avatar and Welcome Frame',
  ),
  PotioAchievement(
    id: 'first_sip',
    title: 'First Sip',
    subtitle: 'Complete your first quiz.',
    current: 0,
    target: 1,
    icon: Icons.local_bar,
    reward: 'Unlocks Copper Frame',
  ),
  PotioAchievement(
    id: 'recipe_rookie',
    title: 'Recipe Rookie',
    subtitle: 'Complete 5 recipe questions.',
    current: 0,
    target: 5,
    icon: Icons.receipt_long,
    reward: 'Unlocks Recipe Rookie avatar',
  ),
  PotioAchievement(
    id: 'daily_regular',
    title: 'Daily Regular',
    subtitle: 'Complete 3 Daily Mixology challenges.',
    current: 0,
    target: 3,
    icon: Icons.calendar_month,
    reward: 'Unlocks Daily Regular avatar',
  ),
  PotioAchievement(
    id: 'academy_starter',
    title: 'Academy Starter',
    subtitle: 'Complete 5 Basic Academy levels.',
    current: 0,
    target: 5,
    icon: Icons.school,
    reward: 'Unlocks Academy Student avatar',
  ),
  PotioAchievement(
    id: 'collector',
    title: 'Collector',
    subtitle: 'Save 5 drinks to favourites.',
    current: 0,
    target: 5,
    icon: Icons.favorite,
    reward: 'Unlocks Mint Frame',
  ),
  PotioAchievement(
    id: 'perfect_pour',
    title: 'Perfect Pour',
    subtitle: 'Score 100% in any quiz mode.',
    current: 0,
    target: 1,
    icon: Icons.workspace_premium,
    reward: 'Unlocks Perfect Pour avatar',
  ),
  PotioAchievement(
    id: 'gold_pour',
    title: 'Gold Pour',
    subtitle: 'Earn one gold award in a level.',
    current: 0,
    target: 1,
    icon: Icons.emoji_events,
    reward: 'Unlocks Gold Award Frame',
  ),
  PotioAchievement(
    id: 'basic_campaign_complete',
    title: 'Basic Bar Graduate',
    subtitle: 'Complete all 20 Basic Bar Academy levels.',
    current: 0,
    target: 20,
    icon: Icons.route,
    reward: 'Unlocks Graduate Badge',
  ),
  PotioAchievement(
    id: 'diamond_bar',
    title: 'Diamond Bar',
    subtitle: 'Earn gold on all Basic Academy levels.',
    current: 0,
    target: 20,
    icon: Icons.diamond,
    reward: 'Unlocks Diamond Bar Frame',
  ),
  PotioAchievement(
    id: 'add_friend',
    title: 'First Bar Friend',
    subtitle: 'Add one friend when multiplayer arrives.',
    current: 0,
    target: 1,
    icon: Icons.person_add,
    reward: 'Coming soon with multiplayer',
  ),
  PotioAchievement(
    id: 'duel_win',
    title: 'First Duel Win',
    subtitle: 'Win your first multiplayer duel.',
    current: 0,
    target: 1,
    icon: Icons.sports_esports,
    reward: 'Coming soon with multiplayer',
  ),
];