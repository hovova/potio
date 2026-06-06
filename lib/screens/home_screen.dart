import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            SizedBox(height: 24),
            Text(
              'POTIO',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFDCA8),
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Master drinks, recipes, ingredients, and bartender knowledge.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 28),
            PotioCard(
              icon: Icons.map_outlined,
              title: 'Basic Bar Academy',
              subtitle: 'Free 20-level campaign with 50 popular drinks.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.menu_book_outlined,
              title: 'Drinks Encyclopedia',
              subtitle: 'Browse drinks by base spirit, flavour, ice, glass type, and favourites.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.calendar_month_outlined,
              title: 'Daily Mixology',
              subtitle: 'A free daily challenge for everyone.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.construction_outlined,
              title: 'Build the Drink',
              subtitle: 'Fill missing steps: glass, ice, method, garnish, and technique.',
            ),
          ],
        ),
      ),
    );
  }
}