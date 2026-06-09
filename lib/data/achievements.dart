import 'package:flutter/material.dart';

import '../models/achievement.dart';

class AchievementIds {
  static const firstLogin = 'first_login';
  static const firstQuiz = 'first_quiz';
  static const recipeRookie = 'recipe_rookie';
  static const dailyRegular = 'daily_regular';
  static const academyStarter = 'academy_starter';
  static const collector = 'collector';
  static const goldPour = 'gold_pour';
  static const basicCampaignComplete = 'basic_campaign_complete';
  static const diamondBar = 'diamond_bar';
  static const addFriend = 'add_friend';
  static const duelWin = 'duel_win';
}

const Achievement firstLoginAchievement = Achievement(
  id: AchievementIds.firstLogin,
  title: 'Welcome to Potio',
  description: 'Open Potio for the first time.',
  icon: Icons.local_bar,
  reward: 'Unlocks Welcome Bartender avatar and Welcome Frame',
);

const Achievement firstQuizAchievement = Achievement(
  id: AchievementIds.firstQuiz,
  title: 'First Sip',
  description: 'Complete your first quiz.',
  icon: Icons.sports_bar,
  reward: 'Unlocks Copper Frame',
);

const Achievement recipeRookieAchievement = Achievement(
  id: AchievementIds.recipeRookie,
  title: 'Recipe Rookie',
  description: 'Complete 5 recipe questions.',
  icon: Icons.receipt_long,
  reward: 'Unlocks Recipe Rookie avatar',
);

const Achievement dailyRegularAchievement = Achievement(
  id: AchievementIds.dailyRegular,
  title: 'Daily Regular',
  description: 'Complete 3 Daily Mixology challenges.',
  icon: Icons.calendar_month,
  reward: 'Unlocks Daily Regular avatar',
);

const Achievement academyStarterAchievement = Achievement(
  id: AchievementIds.academyStarter,
  title: 'Academy Starter',
  description: 'Complete 5 Basic Academy levels.',
  icon: Icons.school,
  reward: 'Unlocks Academy Student avatar',
);

const Achievement collectorAchievement = Achievement(
  id: AchievementIds.collector,
  title: 'Collector',
  description: 'Save 5 drinks to favourites.',
  icon: Icons.favorite,
  reward: 'Unlocks Mint Frame',
);

const Achievement goldPourAchievement = Achievement(
  id: AchievementIds.goldPour,
  title: 'Gold Pour',
  description: 'Score 100% in any level.',
  icon: Icons.emoji_events,
  reward: 'Unlocks Gold Pour avatar and Gold Award Frame',
);

const Achievement basicCampaignCompleteAchievement = Achievement(
  id: AchievementIds.basicCampaignComplete,
  title: 'Basic Bar Graduate',
  description: 'Complete all 20 Basic Bar Academy levels.',
  icon: Icons.route,
  reward: 'Unlocks Graduate Badge',
);

const Achievement diamondBarAchievement = Achievement(
  id: AchievementIds.diamondBar,
  title: 'Diamond Bar',
  description: 'Earn gold awards on every Basic Bar Academy level.',
  icon: Icons.diamond,
  reward: 'Unlocks Diamond Bar Frame',
);

const Achievement addFriendAchievement = Achievement(
  id: AchievementIds.addFriend,
  title: 'First Bar Friend',
  description: 'Add one friend when multiplayer arrives.',
  icon: Icons.group_add,
  reward: 'Coming soon with multiplayer',
);

const Achievement duelWinAchievement = Achievement(
  id: AchievementIds.duelWin,
  title: 'First Duel Win',
  description: 'Win your first multiplayer duel.',
  icon: Icons.sports_esports,
  reward: 'Coming soon with multiplayer',
);

const List<Achievement> allAchievements = [
  firstLoginAchievement,
  firstQuizAchievement,
  recipeRookieAchievement,
  dailyRegularAchievement,
  academyStarterAchievement,
  collectorAchievement,
  goldPourAchievement,
  basicCampaignCompleteAchievement,
  diamondBarAchievement,
  addFriendAchievement,
  duelWinAchievement,
];