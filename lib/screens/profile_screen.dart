import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFDCA8),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Track XP, favourites, achievements, premium status, and settings.',
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 24),
            PotioCard(
              icon: Icons.bolt_outlined,
              title: '0 XP',
              subtitle: 'Progress tracking will be added next.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.straighten_outlined,
              title: 'Measurement Units',
              subtitle: 'Choose ml, oz, or cl for recipes.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.workspace_premium_outlined,
              title: 'Premium',
              subtitle: 'Unlock 100+ drinks, Master Mixologist Academy, offline access, no ads, and the full bartender guide.',
            ),
          ],
        ),
      ),
    );
  }
}