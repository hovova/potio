import 'package:flutter/material.dart';

import '../data/app_text.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../widgets/potio_card.dart';
import 'daily_match_challenge_screen.dart';
import 'mythology_quiz_screen.dart';
import 'recipe_guess_screen.dart';
import 'picture_match_screen.dart';
import 'mixology_trivia_screen.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  Future<void> _openScreen(BuildContext context, Widget screen) async {
    await PotioAudioService.instance.playTap();

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Future<void> _showDuelsComingSoon(
    BuildContext context,
    String languageCode,
  ) async {
    await PotioAudioService.instance.playTap();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppText.get(languageCode, 'duels_locked_message'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.languageCode,
      builder: (context, languageCode, _) {
        return PotioScaffold(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                PotioPageHeader(
                  eyebrow: AppText.get(languageCode, 'practice_bar'),
                  title: AppText.get(languageCode, 'play'),
                  subtitle: AppText.get(languageCode, 'play_subtitle'),
                  icon: Icons.extension,
                ),
                const SizedBox(height: 18),
                PotioCard(
                  badge: AppText.get(languageCode, 'mode_1'),
                  icon: Icons.quiz_outlined,
                  title: AppText.get(languageCode, 'recipe_guess'),
                  subtitle: AppText.get(
                    languageCode,
                    'recipe_guess_subtitle',
                  ),
                  // 2. LINK THE BUTTON TO THE NEW GAME HERE
                  onTap: () => _openScreen(context, const RecipeGuessScreen()), 
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'mode_2'),
                  icon: Icons.image_outlined,
                  title: AppText.get(languageCode, 'picture_match'),
                  subtitle: AppText.get(
                    languageCode,
                    'picture_match_subtitle',
                  ),
                  onTap: () => _openScreen(
                    context,
                    const PictureMatchScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'mode_3'),
                  icon: Icons.construction_outlined,
                  title: AppText.get(languageCode, 'build_the_drink'),
                  subtitle: AppText.get(
                    languageCode,
                    'build_the_drink_subtitle',
                  ),
                  onTap: () => _openScreen(
                    context,
                    const MythologyQuizScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'mode_4'),
                  icon: Icons.school_outlined,
                  title: AppText.get(languageCode, 'mixology_trivia'),
                  subtitle: AppText.get(
                    languageCode,
                    'mixology_trivia_subtitle',
                  ),
                  onTap: () => _openScreen(
                    context,
                    const MixologyTriviaScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'daily'),
                  icon: Icons.calendar_month_outlined,
                  title: AppText.get(languageCode, 'daily_mixology'),
                  subtitle: AppText.get(
                    languageCode,
                    'daily_mixology_play_subtitle',
                  ),
                  onTap: () => _openScreen(
                    context,
                    const DailyMixologyChallengeScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'future_online'),
                  icon: Icons.lock_outline,
                  title: AppText.get(languageCode, 'duels'),
                  subtitle: AppText.get(languageCode, 'duels_subtitle'),
                  onTap: () => _showDuelsComingSoon(
                    context,
                    languageCode,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}