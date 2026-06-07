import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Achievements', subtitle: 'Track badges for quizzes, gold awards, daily mixology, and recipe mastery.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.emoji_events_outlined, title: 'Achievements', subtitle: 'Track badges for quizzes, gold awards, daily mixology, and recipe mastery.'),
          ],
        ),
      ),
    );
  }
}
