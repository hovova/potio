import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              'Play',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFDCA8),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'All quiz modes are free. Free players practise with the 50 basic drinks.',
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 24),
            PotioCard(
              icon: Icons.quiz_outlined,
              title: 'Recipe Guess',
              subtitle: 'See ingredients and choose the correct drink.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.image_outlined,
              title: 'Picture Match',
              subtitle: 'Match the drink image to its name.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.construction_outlined,
              title: 'Build the Drink',
              subtitle: 'Fill missing parts: glass, ice, method, garnish, and technique.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.school_outlined,
              title: 'Mixology Trivia',
              subtitle: 'Answer questions about allergens, ingredients, techniques, and bar knowledge.',
            ),
            SizedBox(height: 14),
            PotioCard(
              icon: Icons.calendar_month_outlined,
              title: 'Daily Mixology',
              subtitle: 'Free daily challenge. XP once per day, replay for practice.',
            ),
          ],
        ),
      ),
    );
  }
}