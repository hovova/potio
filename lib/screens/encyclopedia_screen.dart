import 'package:flutter/material.dart';

import '../data/drink_data.dart';
import '../models/drink.dart';
import '../widgets/potio_card.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});
  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  String selectedFilter = 'All';
  final filters = const ['All', 'Rum', 'Gin', 'Whiskey', 'Tequila', 'Vodka', 'Iced', 'Citrus', 'Sweet', 'Strong'];

  List<Drink> get filteredDrinks {
    if (selectedFilter == 'All') return basicDrinks;
    final selected = selectedFilter.toLowerCase();
    return basicDrinks.where((drink) => drink.baseSpirit.toLowerCase() == selected || drink.tags.contains(selected)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const PotioSectionTitle(title: 'Encyclopedia', subtitle: 'Full recipe cards with ingredients, method, glassware, ice, garnish, taste profile, and allergy notes.'),
            const SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((filter) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedFilter = filter),
                    child: PotioChip(label: filter, selected: selectedFilter == filter),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 20),
            for (final drink in filteredDrinks) ...[
              DrinkRecipeCard(drink: drink),
              const SizedBox(height: 18),
            ],
          ],
        ),
      ),
    );
  }
}

class DrinkRecipeCard extends StatelessWidget {
  final Drink drink;
  const DrinkRecipeCard({super.key, required this.drink});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.28), blurRadius: 24, offset: const Offset(0, 14))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(color: Color(0xFF3A1B0F), borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Row(
              children: [
                Text(drink.imageEmoji, style: const TextStyle(fontSize: 42)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(drink.name, style: const TextStyle(color: Color(0xFFFFE2B8), fontSize: 24, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text('${drink.category} • ${drink.tasteProfile}', style: const TextStyle(color: Color(0xFFE8CBAA), height: 1.25)),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border), color: const Color(0xFFFFCC7A)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(drink.shortDescription, style: const TextStyle(color: Color(0xFF3A1B0F), fontSize: 15, height: 1.45, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _Pill(drink.baseSpirit), _Pill(drink.difficulty), _Pill(drink.isAlcoholic ? 'Alcoholic' : 'Mocktail'), _Pill(drink.origin),
                ]),
                const SizedBox(height: 18),
                _Facts(drink: drink),
                const SizedBox(height: 18),
                _Block(title: 'Ingredients', icon: Icons.format_list_bulleted, items: drink.ingredients),
                const SizedBox(height: 14),
                _Block(title: 'Recipe Steps', icon: Icons.checklist, items: drink.recipeSteps, numbered: true),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: const Color(0xFFFFCC7A).withValues(alpha: 0.22), borderRadius: BorderRadius.circular(20)),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Icon(Icons.warning_amber_outlined, color: Color(0xFF8A4A21)),
                    const SizedBox(width: 10),
                    Expanded(child: Text('Allergy notes: ${drink.allergens.join(' ')}', style: const TextStyle(color: Color(0xFF3A1B0F), height: 1.35, fontWeight: FontWeight.w700))),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Facts extends StatelessWidget {
  final Drink drink;
  const _Facts({required this.drink});

  @override
  Widget build(BuildContext context) {
    final facts = [
      ('Glass', drink.glassType, Icons.local_bar),
      ('Ice', drink.ice, Icons.ac_unit),
      ('Method', drink.method, Icons.sync_alt),
      ('Garnish', drink.garnish, Icons.spa),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.45,
      children: facts.map((fact) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFF3A1B0F).withValues(alpha: 0.08), borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(fact.$3, size: 20, color: const Color(0xFF8A4A21)),
          const SizedBox(height: 8),
          Text(fact.$1, style: const TextStyle(color: Color(0xFF8A4A21), fontSize: 12, fontWeight: FontWeight.w900)),
          const SizedBox(height: 3),
          Expanded(child: Text(fact.$2, style: const TextStyle(color: Color(0xFF3A1B0F), fontWeight: FontWeight.w700, height: 1.25))),
        ]),
      )).toList(),
    );
  }
}

class _Block extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final bool numbered;
  const _Block({required this.title, required this.icon, required this.items, this.numbered = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.55), borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, color: const Color(0xFF8A4A21)), const SizedBox(width: 8), Text(title, style: const TextStyle(color: Color(0xFF3A1B0F), fontSize: 17, fontWeight: FontWeight.w900))]),
        const SizedBox(height: 12),
        for (int index = 0; index < items.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(numbered ? '${index + 1}.' : '•', style: const TextStyle(color: Color(0xFF8A4A21), fontWeight: FontWeight.w900)),
              const SizedBox(width: 8),
              Expanded(child: Text(items[index], style: const TextStyle(color: Color(0xFF3A1B0F), height: 1.35, fontWeight: FontWeight.w600))),
            ]),
          ),
      ]),
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
      decoration: BoxDecoration(color: const Color(0xFF3A1B0F).withValues(alpha: 0.08), borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: const TextStyle(color: Color(0xFF3A1B0F), fontWeight: FontWeight.w800, fontSize: 12)),
    );
  }
}
