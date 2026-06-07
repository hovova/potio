import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Leaderboard', subtitle: 'Compare mixology XP, campaign level, and gold awards.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.leaderboard_outlined, title: 'Leaderboard', subtitle: 'Compare mixology XP, campaign level, and gold awards.'),
          ],
        ),
      ),
    );
  }
}
