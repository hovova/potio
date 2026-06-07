import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Recipe Guess', subtitle: 'Guess drinks from ingredients, method, glassware, garnish, and taste profile.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.quiz_outlined, title: 'Recipe Guess', subtitle: 'Guess drinks from ingredients, method, glassware, garnish, and taste profile.'),
          ],
        ),
      ),
    );
  }
}
