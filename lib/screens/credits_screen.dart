import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Credits', subtitle: 'Review drink data, image, icon, and audio credits.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.info_outline, title: 'Credits', subtitle: 'Review drink data, image, icon, and audio credits.'),
          ],
        ),
      ),
    );
  }
}
