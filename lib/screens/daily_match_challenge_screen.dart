import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class DailyMixologyChallengeScreen extends StatelessWidget {
  const DailyMixologyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Daily Mixology', subtitle: 'A free daily challenge for everyone. XP once per day, replay for practice.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.calendar_month_outlined, title: 'Daily Mixology', subtitle: 'A free daily challenge for everyone. XP once per day, replay for practice.'),
          ],
        ),
      ),
    );
  }
}
