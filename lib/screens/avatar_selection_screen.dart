import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class AvatarSelectionScreen extends StatelessWidget {
  const AvatarSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            PotioSectionTitle(title: 'Avatar', subtitle: 'Choose a bartender profile avatar and future premium frames.'),
            SizedBox(height: 24),
            PotioCard(icon: Icons.face_outlined, title: 'Avatar', subtitle: 'Choose a bartender profile avatar and future premium frames.'),
          ],
        ),
      ),
    );
  }
}
