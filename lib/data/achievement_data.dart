import 'package:flutter/material.dart';

import '../models/achievement.dart';

class AchievementIds {
  static const String firstLogin = 'first_login';
  static const String firstQuiz = 'first_sip';
  static const String recipeRookie = 'recipe_rookie';
  static const String dailyRegular = 'daily_regular';
  static const String academyStarter = 'academy_starter';
  static const String collector = 'collector';
  static const String perfectPour = 'perfect_pour';
  static const String goldPour = 'gold_pour';
  static const String basicCampaignComplete = 'basic_campaign_complete';
  static const String diamondBar = 'diamond_bar';
  static const String addFriend = 'add_friend';
  static const String duelWin = 'duel_win';
}

const List<Achievement> allAchievements = [
  Achievement(
    id: AchievementIds.firstLogin,
    title: 'Welcome to Potio',
    description: 'Open Potio for the first time.',
    icon: Icons.waving_hand,
    reward: 'Unlocks Welcome Bartender avatar',
  ),
  Achievement(
    id: AchievementIds.firstQuiz,
    title: 'First Sip',
    description: 'Complete your first quiz.',
    icon: Icons.local_bar,
    reward: 'Unlocks Copper Frame',
  ),
  Achievement(
    id: AchievementIds.recipeRookie,
    title: 'Recipe Rookie',
    description: 'Complete 5 recipe questions.',
    icon: Icons.receipt_long,
    reward: 'Unlocks Recipe Rookie avatar',
  ),
  Achievement(
    id: AchievementIds.dailyRegular,
    title: 'Daily Regular',
    description: 'Complete 3 Daily Mixology challenges.',
    icon: Icons.calendar_month,
    reward: 'Unlocks Daily Regular avatar',
  ),
  Achievement(
    id: AchievementIds.academyStarter,
    title: 'Academy Starter',
    description: 'Complete 5 Basic Academy levels.',
    icon: Icons.school,
    reward: 'Unlocks Academy Student avatar',
  ),
  Achievement(
    id: AchievementIds.collector,
    title: 'Collector',
    description: 'Save 5 drinks to favourites.',
    icon: Icons.favorite,
    reward: 'Unlocks Mint Frame',
  ),
  Achievement(
    id: AchievementIds.perfectPour,
    title: 'Perfect Pour',
    description: 'Score 100% in any quiz mode.',
    icon: Icons.workspace_premium,
    reward: 'Unlocks Perfect Pour avatar',
  ),
  Achievement(
    id: AchievementIds.goldPour,
    title: 'Gold Pour',
    description: 'Earn one gold award in a level.',
    icon: Icons.emoji_events,
    reward: 'Unlocks Gold Award Frame',
  ),
  Achievement(
    id: AchievementIds.basicCampaignComplete,
    title: 'Basic Bar Graduate',
    description: 'Complete all 20 Basic Bar Academy levels.',
    icon: Icons.route,
    reward: 'Unlocks Graduate Badge',
  ),
  Achievement(
    id: AchievementIds.diamondBar,
    title: 'Diamond Bar',
    description: 'Earn gold on all Basic Academy levels.',
    icon: Icons.diamond,
    reward: 'Unlocks Diamond Bar Frame',
  ),
  Achievement(
    id: AchievementIds.addFriend,
    title: 'First Bar Friend',
    description: 'Add one friend when multiplayer arrives.',
    icon: Icons.person_add,
    reward: 'Coming soon with multiplayer',
  ),
  Achievement(
    id: AchievementIds.duelWin,
    title: 'First Duel Win',
    description: 'Win your first multiplayer duel.',
    icon: Icons.sports_esports,
    reward: 'Coming soon with multiplayer',
  ),
];