import '../data/achievements.dart';

class PlayerProgress {
  final int totalXp;
  final int completedBasicLevels;
  final int goldAwards;

  final Set<String> favouriteDrinkIds;
  final Set<String> unlockedAchievements;

  final String playerName;
  final bool hasNoAds;
  final bool hasPremium;

  final String selectedLanguageCode;
  final String selectedUnitSystem;

  final bool soundEnabled;
  final bool musicEnabled;

  final String selectedAvatarId;
  final String selectedFrameId;

  final String? lastDailyMixologyDate;

  const PlayerProgress({
    required this.totalXp,
    required this.completedBasicLevels,
    required this.goldAwards,
    required this.favouriteDrinkIds,
    required this.unlockedAchievements,
    required this.playerName,
    required this.hasNoAds,
    required this.hasPremium,
    required this.selectedLanguageCode,
    required this.selectedUnitSystem,
    required this.soundEnabled,
    required this.musicEnabled,
    required this.selectedAvatarId,
    required this.selectedFrameId,
    required this.lastDailyMixologyDate,
  });

  factory PlayerProgress.initial() {
    return const PlayerProgress(
      totalXp: 0,
      completedBasicLevels: 0,
      goldAwards: 0,
      favouriteDrinkIds: {},
      unlockedAchievements: {
        AchievementIds.firstLogin,
      },
      playerName: 'Hernandez',
      hasNoAds: false,
      hasPremium: false,
      selectedLanguageCode: 'en',
      selectedUnitSystem: 'ml',
      soundEnabled: true,
      musicEnabled: true,
      selectedAvatarId: 'classic_bartender',
      selectedFrameId: 'none',
      lastDailyMixologyDate: null,
    );
  }

  bool get adsRemoved => hasNoAds || hasPremium;

  int get level => 1 + (totalXp ~/ 100);

  bool get hasCompletedBasicCampaign {
    return completedBasicLevels >= 20;
  }

  bool get hasDiamondBar {
    return goldAwards >= 20;
  }

  PlayerProgress copyWith({
    int? totalXp,
    int? completedBasicLevels,
    int? goldAwards,
    Set<String>? favouriteDrinkIds,
    Set<String>? unlockedAchievements,
    String? playerName,
    bool? hasNoAds,
    bool? hasPremium,
    String? selectedLanguageCode,
    String? selectedUnitSystem,
    bool? soundEnabled,
    bool? musicEnabled,
    String? selectedAvatarId,
    String? selectedFrameId,
    String? lastDailyMixologyDate,
  }) {
    return PlayerProgress(
      totalXp: totalXp ?? this.totalXp,
      completedBasicLevels: completedBasicLevels ?? this.completedBasicLevels,
      goldAwards: goldAwards ?? this.goldAwards,
      favouriteDrinkIds: favouriteDrinkIds ?? this.favouriteDrinkIds,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      playerName: playerName ?? this.playerName,
      hasNoAds: hasNoAds ?? this.hasNoAds,
      hasPremium: hasPremium ?? this.hasPremium,
      selectedLanguageCode: selectedLanguageCode ?? this.selectedLanguageCode,
      selectedUnitSystem: selectedUnitSystem ?? this.selectedUnitSystem,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      selectedAvatarId: selectedAvatarId ?? this.selectedAvatarId,
      selectedFrameId: selectedFrameId ?? this.selectedFrameId,
      lastDailyMixologyDate:
          lastDailyMixologyDate ?? this.lastDailyMixologyDate,
    );
  }

  PlayerProgress addXp(int amount) {
    if (amount <= 0) {
      return this;
    }

    return copyWith(
      totalXp: totalXp + amount,
    );
  }

  PlayerProgress toggleFavouriteDrink(String drinkId) {
    final updated = Set<String>.from(favouriteDrinkIds);

    if (updated.contains(drinkId)) {
      updated.remove(drinkId);
    } else {
      updated.add(drinkId);
    }

    var nextProgress = copyWith(favouriteDrinkIds: updated);

    if (updated.length >= 5) {
      nextProgress = nextProgress.unlockAchievement(AchievementIds.collector);
    }

    return nextProgress;
  }

  PlayerProgress unlockAchievement(String achievementId) {
    if (unlockedAchievements.contains(achievementId)) {
      return this;
    }

    return copyWith(
      unlockedAchievements: {
        ...unlockedAchievements,
        achievementId,
      },
    );
  }

  bool hasAchievement(String achievementId) {
    return unlockedAchievements.contains(achievementId);
  }

  PlayerProgress markFirstQuizCompleted({int xpReward = 10}) {
    return addXp(xpReward).unlockAchievement(AchievementIds.firstQuiz);
  }

  PlayerProgress markRecipeQuestionCompleted({
    int xpReward = 5,
    int completedRecipeQuestions = 1,
  }) {
    var nextProgress = addXp(xpReward);

    if (completedRecipeQuestions >= 5) {
      nextProgress =
          nextProgress.unlockAchievement(AchievementIds.recipeRookie);
    }

    return nextProgress;
  }

  PlayerProgress markBasicLevelCompleted({
    required bool earnedGold,
    int xpReward = 10,
  }) {
    var nextProgress = copyWith(
      totalXp: totalXp + xpReward,
      completedBasicLevels: completedBasicLevels + 1,
      goldAwards: earnedGold ? goldAwards + 1 : goldAwards,
    );

    if (nextProgress.completedBasicLevels >= 5) {
      nextProgress =
          nextProgress.unlockAchievement(AchievementIds.academyStarter);
    }

    if (nextProgress.completedBasicLevels >= 20) {
      nextProgress =
          nextProgress.unlockAchievement(AchievementIds.basicCampaignComplete);
    }

    if (earnedGold) {
      nextProgress = nextProgress.unlockAchievement(AchievementIds.goldPour);
    }

    if (nextProgress.goldAwards >= 20) {
      nextProgress = nextProgress.unlockAchievement(AchievementIds.diamondBar);
    }

    return nextProgress;
  }

  PlayerProgress selectAvatar(String avatarId) {
    return copyWith(selectedAvatarId: avatarId);
  }

  PlayerProgress selectFrame(String frameId) {
    return copyWith(selectedFrameId: frameId);
  }

  PlayerProgress setPremiumActive(bool active) {
    return copyWith(hasPremium: active);
  }

  PlayerProgress setNoAdsActive(bool active) {
    return copyWith(hasNoAds: active);
  }

  PlayerProgress setLanguage(String languageCode) {
    return copyWith(selectedLanguageCode: languageCode);
  }

  PlayerProgress setUnitSystem(String unitSystem) {
    return copyWith(selectedUnitSystem: unitSystem);
  }

  PlayerProgress setSoundEnabled(bool enabled) {
    return copyWith(soundEnabled: enabled);
  }

  PlayerProgress setMusicEnabled(bool enabled) {
    return copyWith(musicEnabled: enabled);
  }

  static String todayKey() {
    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');

    return '${now.year}-$month-$day';
  }

  bool get hasCompletedDailyMixologyToday {
    return lastDailyMixologyDate == todayKey();
  }

  PlayerProgress markDailyMixologyCompleted({int xpReward = 10}) {
    if (hasCompletedDailyMixologyToday) {
      return this;
    }

    return copyWith(
      totalXp: totalXp + xpReward,
      lastDailyMixologyDate: todayKey(),
    ).unlockAchievement(AchievementIds.dailyRegular);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalXp': totalXp,
      'completedBasicLevels': completedBasicLevels,
      'goldAwards': goldAwards,
      'favouriteDrinkIds': favouriteDrinkIds.toList(),
      'unlockedAchievements': unlockedAchievements.toList(),
      'playerName': playerName,
      'hasNoAds': hasNoAds,
      'hasPremium': hasPremium,
      'selectedLanguageCode': selectedLanguageCode,
      'selectedUnitSystem': selectedUnitSystem,
      'soundEnabled': soundEnabled,
      'musicEnabled': musicEnabled,
      'selectedAvatarId': selectedAvatarId,
      'selectedFrameId': selectedFrameId,
      'lastDailyMixologyDate': lastDailyMixologyDate,
    };
  }

  factory PlayerProgress.fromJson(Map<String, dynamic> json) {
    return PlayerProgress(
      totalXp: json['totalXp'] as int? ?? 0,
      completedBasicLevels: json['completedBasicLevels'] as int? ?? 0,
      goldAwards: json['goldAwards'] as int? ?? 0,
      favouriteDrinkIds: Set<String>.from(
        json['favouriteDrinkIds'] as List? ?? [],
      ),
      unlockedAchievements: Set<String>.from(
        json['unlockedAchievements'] as List? ?? [AchievementIds.firstLogin],
      ),
      playerName: json['playerName'] as String? ?? 'Hernandez',
      hasNoAds: json['hasNoAds'] as bool? ?? false,
      hasPremium: json['hasPremium'] as bool? ?? false,
      selectedLanguageCode: json['selectedLanguageCode'] as String? ?? 'en',
      selectedUnitSystem: json['selectedUnitSystem'] as String? ?? 'ml',
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      selectedAvatarId:
          json['selectedAvatarId'] as String? ?? 'classic_bartender',
      selectedFrameId: json['selectedFrameId'] as String? ?? 'none',
      lastDailyMixologyDate: json['lastDailyMixologyDate'] as String?,
    );
  }
}