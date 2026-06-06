import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class EncyclopediaScreen extends StatelessWidget {
  const EncyclopediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              'Encyclopedia',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFDCA8),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Browse drinks, recipes, ingredients, allergens, glassware, and favourites.',
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 24),
            PotioCard(
              icon: Icons.filter_alt_outlined,
              title: 'Free Filters',
              subtitle: 'Vodka, whiskey, rum, gin, tequila, mocktail, iced, sour, sweet, bitter.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.favorite_border,
              title: 'Favourites',
              subtitle: 'Save drinks you want to remember or practise later.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.warning_amber_outlined,
              title: 'Allergy Notes',
              subtitle: 'Learn common allergens and ingredient warnings for drinks.',
            ),
          ],
        ),
      ),
    );
  }
}