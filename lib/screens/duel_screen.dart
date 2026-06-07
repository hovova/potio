import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class DuelScreen extends StatelessWidget {
  const DuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Quick Practice', subtitle: 'Fast mixology questions for recipe, trivia, and picture-match practice.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.sports_esports_outlined, title: 'Quick Practice', subtitle: 'Fast mixology questions for recipe, trivia, and picture-match practice.'),
          ],
        ),
      ),
    );
  }
}
