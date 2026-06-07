class Drink {
  final String id;
  final String name;
  final String category;
  final String baseSpirit;
  final String imageEmoji;
  final String shortDescription;
  final String origin;
  final String glassType;
  final String ice;
  final String method;
  final String garnish;
  final String tasteProfile;
  final String difficulty;
  final bool isAlcoholic;
  final bool isPremium;
  final List<String> ingredients;
  final List<String> recipeSteps;
  final List<String> allergens;
  final List<String> tags;

  const Drink({
    required this.id,
    required this.name,
    required this.category,
    required this.baseSpirit,
    required this.imageEmoji,
    required this.shortDescription,
    required this.origin,
    required this.glassType,
    required this.ice,
    required this.method,
    required this.garnish,
    required this.tasteProfile,
    required this.difficulty,
    required this.isAlcoholic,
    required this.isPremium,
    required this.ingredients,
    required this.recipeSteps,
    required this.allergens,
    required this.tags,
  });
}
