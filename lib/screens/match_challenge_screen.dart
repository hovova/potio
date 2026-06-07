import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class MatchChallengeScreen extends StatelessWidget {
  const MatchChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Picture Match', subtitle: 'Match drink pictures or icons with the correct drink names.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.image_outlined, title: 'Picture Match', subtitle: 'Match drink pictures or icons with the correct drink names.'),
          ],
        ),
      ),
    );
  }
}
