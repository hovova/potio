import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';
import 'achievements_screen.dart';
import 'avatar_selection_screen.dart';
import 'credits_screen.dart';
import 'leaderboard_screen.dart';
import 'premium_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const PotioPageHeader(
              eyebrow: 'Bartender profile',
              title: 'Profile',
              subtitle:
                  'Track XP, favourites, achievements, unit settings, premium status, and credits.',
              icon: Icons.person,
            ),
            const SizedBox(height: 18),
            const Row(
              children: [
                Expanded(
                  child: PotioStatPill(
                    icon: Icons.bolt_outlined,
                    value: '0',
                    label: 'XP',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: PotioStatPill(
                    icon: Icons.favorite_border,
                    value: '0',
                    label: 'Favourites',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            PotioCard(
              badge: 'Progress',
              icon: Icons.emoji_events_outlined,
              title: 'Achievements',
              subtitle: 'View unlocked Potio achievements and future rewards.',
              onTap: () => _openScreen(context, const AchievementsScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Profile',
              icon: Icons.face_outlined,
              title: 'Avatar Selection',
              subtitle: 'Choose your bartender avatar and future frames.',
              onTap: () => _openScreen(context, const AvatarSelectionScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Ranking',
              icon: Icons.leaderboard_outlined,
              title: 'Leaderboard',
              subtitle: 'Compare progress by XP, levels, and achievements.',
              onTap: () => _openScreen(context, const LeaderboardScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Settings',
              icon: Icons.straighten_outlined,
              title: 'Measurement Units',
              subtitle: 'Choose ml, oz, or cl for recipes. Coming next.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Unit settings will be connected next.'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Premium',
              icon: Icons.workspace_premium_outlined,
              title: 'Potio Premium',
              subtitle:
                  'Unlock 100+ drinks, Master Academy, bartender guide, offline access, and no ads.',
              onTap: () => _openScreen(context, const PremiumScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'About',
              icon: Icons.info_outline,
              title: 'Credits',
              subtitle: 'View Potio asset, recipe, and app credits.',
              onTap: () => _openScreen(context, const CreditsScreen()),
            ),
          ],
        ),
      ),
    );
  }
}