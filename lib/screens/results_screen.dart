import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Results', subtitle: 'Review score, XP, recipe mistakes, and bartender tips.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.analytics_outlined, title: 'Results', subtitle: 'Review score, XP, recipe mistakes, and bartender tips.'),
          ],
        ),
      ),
    );
  }
}
