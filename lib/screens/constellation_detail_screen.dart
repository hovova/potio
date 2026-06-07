import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class DrinkDetailScreen extends StatelessWidget {
  const DrinkDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Drink Detail', subtitle: 'A full drink recipe card will appear here.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.menu_book_outlined, title: 'Drink Detail', subtitle: 'A full drink recipe card will appear here.'),
          ],
        ),
      ),
    );
  }
}
