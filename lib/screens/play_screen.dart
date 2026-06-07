import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';
import 'daily_match_challenge_screen.dart';
import 'duel_screen.dart';
import 'match_challenge_screen.dart';
import 'mythology_quiz_screen.dart';
import 'quiz_screen.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

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
              eyebrow: 'Practice bar',
              title: 'Play',
              subtitle:
                  'All game modes are free. Free users practise with the 50 basic drinks.',
              icon: Icons.extension,
            ),
            const SizedBox(height: 18),
            PotioCard(
              badge: 'Mode 1',
              icon: Icons.quiz_outlined,
              title: 'Recipe Guess',
              subtitle: 'See ingredients and choose the correct drink.',
              onTap: () => _openScreen(context, const QuizScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Mode 2',
              icon: Icons.image_outlined,
              title: 'Picture Match',
              subtitle: 'Match the drink image to the correct name.',
              onTap: () => _openScreen(context, const MatchChallengeScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Mode 3',
              icon: Icons.construction_outlined,
              title: 'Build the Drink',
              subtitle: 'Fill missing facts: glass, ice, method, garnish, or step.',
              onTap: () => _openScreen(context, const MythologyQuizScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Mode 4',
              icon: Icons.school_outlined,
              title: 'Mixology Trivia',
              subtitle:
                  'Answer questions about allergens, ingredients, techniques, and bar knowledge.',
              onTap: () => _openScreen(context, const MythologyQuizScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Daily',
              icon: Icons.calendar_month_outlined,
              title: 'Daily Mixology',
              subtitle: 'A free daily challenge for everyone.',
              onTap: () => _openScreen(context, const DailyMixologyChallengeScreen()),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Future online',
              icon: Icons.sports_esports_outlined,
              title: 'Duels',
              subtitle:
                  'Placeholder for future drink-knowledge duels and multiplayer logic.',
              onTap: () => _openScreen(context, const DuelScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
