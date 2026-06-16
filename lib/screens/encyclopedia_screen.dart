import 'package:flutter/material.dart';

import '../data/app_text.dart';
import '../data/drink_data.dart';
import '../models/drink.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../services/progress_storage_service.dart';
import '../services/purchase_service.dart';
import '../widgets/potio_card.dart';
import 'premium_screen.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  final ProgressStorageService _storage = ProgressStorageService();

  PlayerProgress _progress = PlayerProgress.initial();
  bool _loading = true;

  String selectedAlcoholType = 'All';
  String selectedDifficulty = 'All';
  String selectedOrigin = 'All';
  bool showFavouritesOnly = false;

  final Set<String> expandedDrinkIds = {};

  bool get isPremium => PotioPurchaseService.instance.isPremium.value;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final loaded = await _storage.loadProgress();

    if (!mounted) return;

    setState(() {
      _progress = loaded;
      _loading = false;
    });
  }

  Future<void> _saveProgress(PlayerProgress progress) async {
    if (!mounted) return;

    setState(() {
      _progress = progress;
    });

    await _storage.saveProgress(progress);
  }

  List<String> get alcoholTypeOptions {
    final values = allDrinks.map((drink) => drink.baseSpirit).toSet().toList()
      ..sort();

    return ['All', ...values];
  }

  List<String> get difficultyOptions {
    final values = allDrinks.map((drink) => drink.difficulty).toSet().toList()
      ..sort();

    return ['All', ...values];
  }

  List<String> get originOptions {
    final values = allDrinks.map((drink) => drink.origin).toSet().toList()
      ..sort();

    return ['All', ...values];
  }

  List<Drink> get filteredDrinks {
    return allDrinks.where((drink) {
      final matchesAlcohol = selectedAlcoholType == 'All' ||
          drink.baseSpirit.toLowerCase() == selectedAlcoholType.toLowerCase();

      final matchesDifficulty = selectedDifficulty == 'All' ||
          drink.difficulty.toLowerCase() == selectedDifficulty.toLowerCase();

      final matchesOrigin = selectedOrigin == 'All' ||
          drink.origin.toLowerCase() == selectedOrigin.toLowerCase();

      final matchesFavourite =
          !showFavouritesOnly || _progress.favouriteDrinkIds.contains(drink.id);

      return matchesAlcohol &&
          matchesDifficulty &&
          matchesOrigin &&
          matchesFavourite;
    }).toList();
  }

  Future<void> _toggleFavourite(Drink drink) async {
    await PotioAudioService.instance.playTap();

    final updatedProgress = _progress.toggleFavouriteDrink(drink.id);
    await _saveProgress(updatedProgress);
  }

  void _toggleExpanded(Drink drink) {
    PotioAudioService.instance.playTap();

    setState(() {
      if (expandedDrinkIds.contains(drink.id)) {
        expandedDrinkIds.remove(drink.id);
      } else {
        expandedDrinkIds.add(drink.id);
      }
    });
  }

  void _resetFilters() {
    PotioAudioService.instance.playTap();

    setState(() {
      selectedAlcoholType = 'All';
      selectedDifficulty = 'All';
      selectedOrigin = 'All';
      showFavouritesOnly = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const PotioScaffold(
        child: Center(
          child: CircularProgressIndicator(
            color: potioCopperLight,
          ),
        ),
      );
    }

    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.languageCode,
      builder: (context, languageCode, _) {
        return PotioScaffold(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                _SmallEncyclopediaHeader(languageCode: languageCode),
                const SizedBox(height: 16),
                _FilterPanel(
                  languageCode: languageCode,
                  selectedAlcoholType: selectedAlcoholType,
                  selectedDifficulty: selectedDifficulty,
                  selectedOrigin: selectedOrigin,
                  showFavouritesOnly: showFavouritesOnly,
                  favouritesCount: _progress.favouriteDrinkIds.length,
                  alcoholTypeOptions: alcoholTypeOptions,
                  difficultyOptions: difficultyOptions,
                  originOptions: originOptions,
                  resultCount: filteredDrinks.length,
                  onAlcoholChanged: (value) async {
                    if (value == null) return;

                    await PotioAudioService.instance.playTap();

                    setState(() {
                      selectedAlcoholType = value;
                    });
                  },
                  onDifficultyChanged: (value) async {
                    if (value == null) return;

                    await PotioAudioService.instance.playTap();

                    setState(() {
                      selectedDifficulty = value;
                    });
                  },
                  onOriginChanged: (value) async {
                    if (value == null) return;

                    await PotioAudioService.instance.playTap();

                    setState(() {
                      selectedOrigin = value;
                    });
                  },
                  onFavouritesChanged: (value) async {
                    await PotioAudioService.instance.playTap();

                    setState(() {
                      showFavouritesOnly = value;
                    });
                  },
                  onReset: _resetFilters,
                ),
                const SizedBox(height: 20),
                if (filteredDrinks.isEmpty)
                  _EmptyState(languageCode: languageCode)
                else
                  for (final drink in filteredDrinks) ...[
                    DrinkRecipeCard(
                      drink: drink,
                      languageCode: languageCode,
                      expanded: expandedDrinkIds.contains(drink.id),
                      favourite: _progress.favouriteDrinkIds.contains(drink.id),
                      locked: drink.isPremium && !isPremium,
                      onToggleExpanded: () => _toggleExpanded(drink),
                      onToggleFavourite: () => _toggleFavourite(drink),
                    ),
                    const SizedBox(height: 18),
                  ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SmallEncyclopediaHeader extends StatelessWidget {
  final String languageCode;

  const _SmallEncyclopediaHeader({
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: potioPaper,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_bar,
            color: potioEmerald,
            size: 34,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'POTIO',
                  style: TextStyle(
                    color: potioCopper,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppText.get(languageCode, 'encyclopedia'),
                  style: const TextStyle(
                    color: potioInk,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  AppText.get(languageCode, 'encyclopedia_subtitle'),
                  style: const TextStyle(
                    color: potioMutedInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterPanel extends StatelessWidget {
  final String languageCode;
  final String selectedAlcoholType;
  final String selectedDifficulty;
  final String selectedOrigin;
  final bool showFavouritesOnly;
  final int favouritesCount;

  final List<String> alcoholTypeOptions;
  final List<String> difficultyOptions;
  final List<String> originOptions;

  final int resultCount;

  final ValueChanged<String?> onAlcoholChanged;
  final ValueChanged<String?> onDifficultyChanged;
  final ValueChanged<String?> onOriginChanged;
  final ValueChanged<bool> onFavouritesChanged;
  final VoidCallback onReset;

  const _FilterPanel({
    required this.languageCode,
    required this.selectedAlcoholType,
    required this.selectedDifficulty,
    required this.selectedOrigin,
    required this.showFavouritesOnly,
    required this.favouritesCount,
    required this.alcoholTypeOptions,
    required this.difficultyOptions,
    required this.originOptions,
    required this.resultCount,
    required this.onAlcoholChanged,
    required this.onDifficultyChanged,
    required this.onOriginChanged,
    required this.onFavouritesChanged,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: potioDarkCoffee.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: potioCopperLight.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.filter_alt_outlined,
                color: potioCopperLight,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppText.get(languageCode, 'drink_filters'),
                  style: const TextStyle(
                    color: potioPaper,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '$resultCount ${AppText.get(languageCode, 'results')}',
                style: const TextStyle(
                  color: potioSage,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _FilterDropdown(
            languageCode: languageCode,
            icon: Icons.local_bar,
            label: AppText.get(languageCode, 'alcohol_type'),
            value: selectedAlcoholType,
            values: alcoholTypeOptions,
            onChanged: onAlcoholChanged,
          ),
          const SizedBox(height: 12),
          _FilterDropdown(
            languageCode: languageCode,
            icon: Icons.school_outlined,
            label: AppText.get(languageCode, 'difficulty'),
            value: selectedDifficulty,
            values: difficultyOptions,
            onChanged: onDifficultyChanged,
          ),
          const SizedBox(height: 12),
          _FilterDropdown(
            languageCode: languageCode,
            icon: Icons.public,
            label: AppText.get(languageCode, 'country_origin'),
            value: selectedOrigin,
            values: originOptions,
            onChanged: onOriginChanged,
          ),
          const SizedBox(height: 12),
          _FavouritesFilterTile(
            languageCode: languageCode,
            value: showFavouritesOnly,
            favouritesCount: favouritesCount,
            onChanged: onFavouritesChanged,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: potioCopperLight,
                side: BorderSide(
                  color: potioCopperLight.withValues(alpha: 0.45),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onReset,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(
                AppText.get(languageCode, 'reset_filters'),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String languageCode;
  final IconData icon;
  final String label;
  final String value;
  final List<String> values;
  final ValueChanged<String?> onChanged;

  const _FilterDropdown({
    required this.languageCode,
    required this.icon,
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
  });

  String _displayValue(String value) {
    if (value.toLowerCase() == 'all') {
      return AppText.get(languageCode, 'all');
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final safeValue = values.contains(value) ? value : 'All';

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: potioPaper,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: potioMutedInk.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: potioEmerald,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: potioInk,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: safeValue,
                isExpanded: true,
                alignment: Alignment.centerRight,
                borderRadius: BorderRadius.circular(18),
                dropdownColor: potioPaper,
                iconEnabledColor: potioEmerald,
                style: const TextStyle(
                  color: potioInk,
                  fontWeight: FontWeight.w900,
                ),
                selectedItemBuilder: (context) {
                  return values.map((item) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _displayValue(item),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    );
                  }).toList();
                },
                items: [
                  for (final item in values)
                    DropdownMenuItem(
                      value: item,
                      child: Text(_displayValue(item)),
                    ),
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavouritesFilterTile extends StatelessWidget {
  final String languageCode;
  final bool value;
  final int favouritesCount;
  final ValueChanged<bool> onChanged;

  const _FavouritesFilterTile({
    required this.languageCode,
    required this.value,
    required this.favouritesCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: potioPaper,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onChanged(!value),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: value
                  ? potioCopperLight.withValues(alpha: 0.55)
                  : potioMutedInk.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            children: [
              Icon(
                value ? Icons.favorite : Icons.favorite_border,
                color: value ? potioCopperLight : potioEmerald,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppText.get(languageCode, 'favourites_only'),
                  style: const TextStyle(
                    color: potioInk,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '$favouritesCount ${AppText.get(languageCode, 'saved')}',
                style: const TextStyle(
                  color: potioMutedInk,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 10),
              Switch(
                value: value,
                activeThumbColor: potioCopperLight,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrinkRecipeCard extends StatelessWidget {
  final Drink drink;
  final String languageCode;
  final bool expanded;
  final bool favourite;
  final bool locked;
  final VoidCallback onToggleExpanded;
  final VoidCallback onToggleFavourite;

  const DrinkRecipeCard({
    super.key,
    required this.drink,
    required this.languageCode,
    required this.expanded,
    required this.favourite,
    required this.locked,
    required this.onToggleExpanded,
    required this.onToggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: const Color(0xFF3A1B0F),
              child: InkWell(
                onTap: onToggleExpanded,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      _DrinkIcon(drink: drink),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drink.name,
                              style: const TextStyle(
                                color: Color(0xFFFFE2B8),
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              locked 
                                  ? 'Premium Recipe' 
                                  : '${drink.category} • ${drink.tasteProfile}',
                              maxLines: expanded ? 3 : 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: locked ? const Color(0xFFFFCC7A) : const Color(0xFFE8CBAA),
                                height: 1.25,
                                fontWeight: locked ? FontWeight.w900 : FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (locked)
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.lock, color: Color(0xFFFFCC7A), size: 22),
                        ),
                      IconButton(
                        onPressed: onToggleFavourite,
                        icon: Icon(
                          favourite ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: const Color(0xFFFFCC7A),
                        tooltip: favourite
                            ? AppText.get(
                                languageCode,
                                'remove_from_favourites',
                              )
                            : AppText.get(
                                languageCode,
                                'add_to_favourites',
                              ),
                      ),
                      Icon(
                        expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color(0xFFFFCC7A),
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (expanded)
              if (locked)
                _LockedPremiumContent(languageCode: languageCode)
              else
                _ExpandedRecipeContent(
                  drink: drink,
                  languageCode: languageCode,
                ),
          ],
        ),
      ),
    );
  }
}

class _LockedPremiumContent extends StatelessWidget {
  final String languageCode;

  const _LockedPremiumContent({
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      color: const Color(0xFFFFCC7A).withValues(alpha: 0.15),
      child: Column(
        children: [
          const Icon(
            Icons.lock_outline,
            size: 48,
            color: Color(0xFF8A4A21),
          ),
          const SizedBox(height: 16),
          Text(
            AppText.get(languageCode, 'premium_drink'),
            style: const TextStyle(
              color: Color(0xFF3A1B0F),
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppText.get(languageCode, 'unlock_premium_recipe'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF8A4A21),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF8A4A21),
              foregroundColor: const Color(0xFFFFE2B8),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PremiumScreen(),
                ),
              );
            },
            icon: const Icon(Icons.workspace_premium),
            label: Text(
              AppText.get(languageCode, 'unlock_premium'),
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}


class _ExpandedRecipeContent extends StatelessWidget {
  final Drink drink;
  final String languageCode;

  const _ExpandedRecipeContent({
    required this.drink,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LargeDrinkImagePlaceholder(
            drink: drink,
            languageCode: languageCode,
          ),
          const SizedBox(height: 16),
          Text(
            drink.shortDescription,
            style: const TextStyle(
              color: Color(0xFF3A1B0F),
              fontSize: 15,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Pill(drink.baseSpirit),
              _Pill(drink.difficulty),
              _Pill(
                drink.isAlcoholic
                    ? AppText.get(languageCode, 'alcoholic')
                    : AppText.get(languageCode, 'mocktail'),
              ),
              _Pill(drink.origin),
            ],
          ),
          const SizedBox(height: 18),
          _Facts(
            drink: drink,
            languageCode: languageCode,
          ),
          const SizedBox(height: 18),
          _Block(
            title: AppText.get(languageCode, 'ingredients'),
            icon: Icons.format_list_bulleted,
            items: drink.ingredients,
          ),
          const SizedBox(height: 14),
          _Block(
            title: AppText.get(languageCode, 'recipe_steps'),
            icon: Icons.checklist,
            items: drink.recipeSteps,
            numbered: true,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCC7A).withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber_outlined,
                  color: Color(0xFF8A4A21),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${AppText.get(languageCode, 'allergy_notes')}: ${drink.allergens.join(' ')}',
                    style: const TextStyle(
                      color: Color(0xFF3A1B0F),
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrinkIcon extends StatelessWidget {
  final Drink drink;

  const _DrinkIcon({
    required this.drink,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Center(
        child: Text(
          drink.imageEmoji,
          style: const TextStyle(fontSize: 38),
        ),
      ),
    );
  }
}

class _LargeDrinkImagePlaceholder extends StatelessWidget {
  final Drink drink;
  final String languageCode;

  const _LargeDrinkImagePlaceholder({
    required this.drink,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        color: const Color(0xFF3A1B0F).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF8A4A21).withValues(alpha: 0.18),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: const Color(0xFF8A4A21).withValues(alpha: 0.35),
              size: 54,
            ),
          ),
          Positioned(
            left: 16,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1D9).withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                drink.name,
                style: const TextStyle(
                  color: Color(0xFF3A1B0F),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 14,
            child: Text(
              AppText.get(languageCode, 'image_placeholder'),
              style: const TextStyle(
                color: Color(0xFF8A4A21),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Facts extends StatelessWidget {
  final Drink drink;
  final String languageCode;

  const _Facts({
    required this.drink,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final facts = [
      (AppText.get(languageCode, 'glass'), drink.glassType, Icons.local_bar),
      (AppText.get(languageCode, 'ice'), drink.ice, Icons.ac_unit),
      (AppText.get(languageCode, 'method'), drink.method, Icons.sync_alt),
      (AppText.get(languageCode, 'garnish'), drink.garnish, Icons.spa),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.45,
      children: facts.map((fact) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF3A1B0F).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                fact.$3,
                size: 20,
                color: const Color(0xFF8A4A21),
              ),
              const SizedBox(height: 8),
              Text(
                fact.$1,
                style: const TextStyle(
                  color: Color(0xFF8A4A21),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Expanded(
                child: Text(
                  fact.$2,
                  style: const TextStyle(
                    color: Color(0xFF3A1B0F),
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _Block extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final bool numbered;

  const _Block({
    required this.title,
    required this.icon,
    required this.items,
    this.numbered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF8A4A21),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF3A1B0F),
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int index = 0; index < items.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    numbered ? '${index + 1}.' : '•',
                    style: const TextStyle(
                      color: Color(0xFF8A4A21),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        color: Color(0xFF3A1B0F),
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;

  const _Pill(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF3A1B0F).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF3A1B0F),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String languageCode;

  const _EmptyState({
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: potioPaper,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_off,
            color: potioEmerald,
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppText.get(languageCode, 'no_drinks_match_filters'),
              style: const TextStyle(
                color: potioInk,
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}