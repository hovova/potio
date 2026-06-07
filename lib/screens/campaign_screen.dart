import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';
import 'premium_screen.dart';
import 'quiz_screen.dart';

class PotioCampaignScreen extends StatelessWidget {
  const PotioCampaignScreen({super.key});

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
              eyebrow: 'Academy paths',
              title: 'Campaign',
              subtitle:
                  'Potio uses bartender academy paths instead of Stella’s sky map.',
              icon: Icons.route,
            ),
            const SizedBox(height: 18),
            PotioCard(
              badge: 'Free',
              icon: Icons.local_bar_outlined,
              title: 'Basic Bar Academy',
              subtitle: '20 levels • 50 popular drinks • all quiz modes available.',
              onTap: () => _openScreen(context, const QuizScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Premium',
              icon: Icons.workspace_premium_outlined,
              title: 'Master Mixologist Academy',
              subtitle:
                  '100+ total drinks • advanced recipes • bartender guide • offline • no ads.',
              onTap: () => _openScreen(context, const PremiumScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Exam style',
              icon: Icons.school_outlined,
              title: 'Bartender Trials',
              subtitle:
                  'Future challenge levels covering glassware, methods, allergens, and service knowledge.',
              onTap: () => _openScreen(context, const QuizScreen()),
            ),
          ],
        ),
      ),
    );
  }
}