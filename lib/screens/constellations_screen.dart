import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class DrinksScreen extends StatelessWidget {
  const DrinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Drinks', subtitle: 'Browse the drink encyclopedia with filters and favourites.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.local_bar_outlined, title: 'Drinks', subtitle: 'Browse the drink encyclopedia with filters and favourites.'),
          ],
        ),
      ),
    );
  }
}
