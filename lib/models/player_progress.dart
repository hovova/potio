class PlayerProgress {
  final int totalXp;
  final Set<String> favouriteDrinkIds;
  final Set<String> unlockedAchievements;
  final String playerName;
  final bool hasNoAds;
  final bool hasPremium;
  final String selectedLanguageCode;
  final String selectedUnitSystem;
  final bool soundEnabled;
  final bool musicEnabled;
  final String? lastDailyMixologyDate;

  const PlayerProgress({
    required this.totalXp,
    required this.favouriteDrinkIds,
    required this.unlockedAchievements,
    required this.playerName,
    required this.hasNoAds,
    required this.hasPremium,
    required this.selectedLanguageCode,
    required this.selectedUnitSystem,
    required this.soundEnabled,
    required this.musicEnabled,
    required this.lastDailyMixologyDate,
  });

  factory PlayerProgress.initial() {
    return const PlayerProgress(
      totalXp: 0,
      favouriteDrinkIds: {},
      unlockedAchievements: {},
      playerName: 'Bartender',
      hasNoAds: false,
      hasPremium: false,
      selectedLanguageCode: 'en',
      selectedUnitSystem: 'ml',
      soundEnabled: true,
      musicEnabled: true,
      lastDailyMixologyDate: null,
    );
  }

  bool get adsRemoved => hasNoAds || hasPremium;

  PlayerProgress copyWith({
    int? totalXp,
    Set<String>? favouriteDrinkIds,
    Set<String>? unlockedAchievements,
    String? playerName,
    bool? hasNoAds,
    bool? hasPremium,
    String? selectedLanguageCode,
    String? selectedUnitSystem,
    bool? soundEnabled,
    bool? musicEnabled,
    String? lastDailyMixologyDate,
  }) {
    return PlayerProgress(
      totalXp: totalXp ?? this.totalXp,
      favouriteDrinkIds: favouriteDrinkIds ?? this.favouriteDrinkIds,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      playerName: playerName ?? this.playerName,
      hasNoAds: hasNoAds ?? this.hasNoAds,
      hasPremium: hasPremium ?? this.hasPremium,
      selectedLanguageCode: selectedLanguageCode ?? this.selectedLanguageCode,
      selectedUnitSystem: selectedUnitSystem ?? this.selectedUnitSystem,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      lastDailyMixologyDate: lastDailyMixologyDate ?? this.lastDailyMixologyDate,
    );
  }

  PlayerProgress toggleFavouriteDrink(String drinkId) {
    final updated = Set<String>.from(favouriteDrinkIds);
    if (updated.contains(drinkId)) {
      updated.remove(drinkId);
    } else {
      updated.add(drinkId);
    }
    return copyWith(favouriteDrinkIds: updated);
  }

  PlayerProgress unlockAchievement(String achievementId) {
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalXp': totalXp,
      'favouriteDrinkIds': favouriteDrinkIds.toList(),
      'unlockedAchievements': unlockedAchievements.toList(),
      'playerName': playerName,
      'hasNoAds': hasNoAds,
      'hasPremium': hasPremium,
      'selectedLanguageCode': selectedLanguageCode,
      'selectedUnitSystem': selectedUnitSystem,
      'soundEnabled': soundEnabled,
      'musicEnabled': musicEnabled,
      'lastDailyMixologyDate': lastDailyMixologyDate,
    };
  }

  factory PlayerProgress.fromJson(Map<String, dynamic> json) {
    return PlayerProgress(
      totalXp: json['totalXp'] as int? ?? 0,
      favouriteDrinkIds: Set<String>.from(
        json['favouriteDrinkIds'] as List? ?? [],
      ),
      unlockedAchievements: Set<String>.from(
        json['unlockedAchievements'] as List? ?? [],
      ),
      playerName: json['playerName'] as String? ?? 'Bartender',
      hasNoAds: json['hasNoAds'] as bool? ?? false,
      hasPremium: json['hasPremium'] as bool? ?? false,
      selectedLanguageCode: json['selectedLanguageCode'] as String? ?? 'en',
      selectedUnitSystem: json['selectedUnitSystem'] as String? ?? 'ml',
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      lastDailyMixologyDate: json['lastDailyMixologyDate'] as String?,
    );
  }
}
