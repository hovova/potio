class CampaignLevel {
  final String id;
  final String title;
  final String description;
  final int levelNumber;
  final int requiredXp;
  final bool premiumOnly;
  final List<String> drinkIds;

  const CampaignLevel({
    required this.id,
    required this.title,
    required this.description,
    required this.levelNumber,
    required this.requiredXp,
    required this.premiumOnly,
    required this.drinkIds,
  });
}
