import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              'Campaign',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFDCA8),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Progress through Potio’s drink academy and master recipes step by step.',
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 24),
            PotioCard(
              icon: Icons.local_bar_outlined,
              title: 'Basic Bar Academy',
              subtitle: 'Free campaign • 20 levels • 50 popular drinks',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.workspace_premium_outlined,
              title: 'Master Mixologist Academy',
              subtitle: 'Premium campaign • 100+ drinks • bartender guide • no ads',
            ),
          ],
        ),
      ),
    );
  }
}