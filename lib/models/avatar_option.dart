class AvatarOption {
  final String id;
  final String name;
  final String emoji;
  final bool premiumOnly;

  const AvatarOption({
    required this.id,
    required this.name,
    required this.emoji,
    this.premiumOnly = false,
  });
}
