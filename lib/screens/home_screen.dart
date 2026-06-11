import 'package:flutter/material.dart';

import '../services/audio_service.dart';
import '../widgets/potio_card.dart';
import '../widgets/sound_toggle_button.dart';
import 'campaign_screen.dart';
import 'daily_match_challenge_screen.dart';
import 'encyclopedia_screen.dart';
import 'play_screen.dart';
import 'premium_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _LanguageSheet(),
    );
  }

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _openPremium(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.92,
        child: PremiumScreen(),
      ),
    );
  }

  Future<void> _tapAndOpen(BuildContext context, Widget screen) async {
    await PotioAudioService.instance.playTap();

    if (!context.mounted) return;

    _openScreen(context, screen);
  }

  Future<void> _tapAndOpenLanguage(BuildContext context) async {
    await PotioAudioService.instance.playTap();

    if (!context.mounted) return;

    _openLanguageSelector(context);
  }

  Future<void> _tapAndOpenPremium(BuildContext context) async {
    await PotioAudioService.instance.playTap();

    if (!context.mounted) return;

    _openPremium(context);
  }

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              children: [
                _TopRoundButton(
                  icon: Icons.language,
                  label: 'EN',
                  onTap: () => _tapAndOpenLanguage(context),
                ),
                const SizedBox(width: 10),
                const SoundToggleButton(),
                const Spacer(),
                _PremiumCornerButton(
                  onTap: () => _tapAndOpenPremium(context),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const PotioPageHeader(
              eyebrow: 'Mixology academy',
              title: 'Potio',
              subtitle:
                  'Learn drinks through recipes, ingredients, technique, glassware, and bartender-style quizzes.',
              icon: Icons.local_bar,
            ),
            const SizedBox(height: 12),
            const _StudioLabel(),
            const SizedBox(height: 18),
            PotioCard(
              badge: 'Free campaign',
              icon: Icons.route_outlined,
              title: 'Basic Bar Academy',
              subtitle: '20 levels built around 50 popular drinks.',
              onTap: () => _tapAndOpen(
                context,
                const PotioCampaignScreen(),
              ),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Encyclopedia',
              icon: Icons.receipt_long_outlined,
              title: 'Full Recipe Cards',
              subtitle:
                  'Glass, ice, method, garnish, taste profile, allergens, ingredients, and steps.',
              onTap: () => _tapAndOpen(
                context,
                const EncyclopediaScreen(),
              ),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'Free daily',
              icon: Icons.calendar_month_outlined,
              title: 'Daily Mixology',
              subtitle: 'One XP reward per day, replayable for practice.',
              onTap: () => _tapAndOpen(
                context,
                const DailyMixologyChallengeScreen(),
              ),
            ),
            const SizedBox(height: 12),
            PotioCard(
              badge: 'All modes',
              icon: Icons.extension_outlined,
              title: 'Practice Bar',
              subtitle:
                  'Recipe Guess, Picture Match, Build the Drink, Mixology Trivia, and more.',
              onTap: () => _tapAndOpen(
                context,
                const PlayScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudioLabel extends StatelessWidget {
  const _StudioLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.auto_awesome,
          color: potioCopperLight.withValues(alpha: 0.9),
          size: 18,
        ),
        const SizedBox(width: 7),
        const Text(
          'Created by Mriya Interactive',
          style: TextStyle(
            color: potioPaperDeep,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _TopRoundButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TopRoundButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: potioPaper,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: potioEmerald, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: potioInk,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumCornerButton extends StatelessWidget {
  final VoidCallback onTap;

  const _PremiumCornerButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: potioEmerald,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium, color: potioPaper, size: 18),
              SizedBox(width: 6),
              Text(
                'Premium',
                style: TextStyle(
                  color: potioPaper,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      decoration: const BoxDecoration(
        color: potioPaper,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 5,
            decoration: BoxDecoration(
              color: potioMutedInk.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Choose Language',
            style: TextStyle(
              color: potioInk,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          _LanguageOption(
            flag: '🇬🇧',
            title: 'English',
            subtitle: 'Current language',
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          _LanguageOption(
            flag: '🇺🇦',
            title: 'Українська',
            subtitle: 'Coming soon',
            selected: false,
            onTap: () => Navigator.pop(context),
          ),
          _LanguageOption(
            flag: '🇷🇺',
            title: 'Русский',
            subtitle: 'Coming soon',
            selected: false,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await PotioAudioService.instance.playTap();
        onTap();
      },
      leading: Text(
        flag,
        style: const TextStyle(fontSize: 26),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: potioInk,
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: potioMutedInk,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle, color: potioEmerald)
          : const Icon(Icons.circle_outlined, color: potioMutedInk),
    );
  }
}