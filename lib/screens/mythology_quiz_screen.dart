import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class MythologyQuizScreen extends StatelessWidget {
  const MythologyQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Bartender Guide Quiz', subtitle: 'Premium-style guide questions about techniques, ingredients, and bar knowledge.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.school_outlined, title: 'Bartender Guide Quiz', subtitle: 'Premium-style guide questions about techniques, ingredients, and bar knowledge.'),
          ],
        ),
      ),
    );
  }
}
