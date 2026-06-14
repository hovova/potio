import 'package:flutter/material.dart';

import '../data/app_text.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../widgets/potio_card.dart';
import 'premium_screen.dart';
import 'quiz_screen.dart';

class PotioCampaignScreen extends StatelessWidget {
  const PotioCampaignScreen({super.key});

  Future<void> _openScreen(BuildContext context, Widget screen) async {
    await PotioAudioService.instance.playTap();

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
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
                  eyebrow: AppText.get(languageCode, 'academy_paths'),
                  title: AppText.get(languageCode, 'campaign'),
                  subtitle: AppText.get(languageCode, 'campaign_subtitle'),
                  icon: Icons.route,
                ),
                const SizedBox(height: 18),
                PotioCard(
                  badge: AppText.get(languageCode, 'free_label'),
                  icon: Icons.local_bar_outlined,
                  title: AppText.get(languageCode, 'basic_bar_academy'),
                  subtitle: AppText.get(languageCode, 'basic_bar_subtitle'),
                  onTap: () => _openScreen(context, const QuizScreen()),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'premium_label'),
                  icon: Icons.workspace_premium_outlined,
                  title: AppText.get(
                    languageCode,
                    'master_mixologist_academy',
                  ),
                  subtitle: AppText.get(
                    languageCode,
                    'master_mixologist_academy_subtitle',
                  ),
                  onTap: () => _openScreen(context, const PremiumScreen()),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'exam_style'),
                  icon: Icons.school_outlined,
                  title: AppText.get(languageCode, 'bartender_trials'),
                  subtitle: AppText.get(
                    languageCode,
                    'bartender_trials_subtitle',
                  ),
                  onTap: () => _openScreen(context, const QuizScreen()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}