import 'package:flutter/material.dart';

import '../data/app_text.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../services/progress_storage_service.dart';
import '../widgets/potio_card.dart';
import '../widgets/sound_toggle_button.dart';
import 'campaign_screen.dart';
import 'daily_match_challenge_screen.dart';
import 'encyclopedia_screen.dart';
import 'play_screen.dart';
import 'premium_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProgressStorageService _storage = ProgressStorageService();

  PlayerProgress _progress = PlayerProgress.initial();

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final loaded = await _storage.loadProgress();

    LanguageService.instance.setLanguage(loaded.selectedLanguageCode);

    if (!mounted) return;

    setState(() {
      _progress = loaded;
    });
  }

  Future<void> _saveLanguage(String languageCode) async {
    final updatedProgress = _progress.setLanguage(languageCode);

    LanguageService.instance.setLanguage(languageCode);

    if (!mounted) return;

    setState(() {
      _progress = updatedProgress;
    });

    await _storage.saveProgress(updatedProgress);
  }

  void _openLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _LanguageSheet(
        selectedLanguageCode: _progress.selectedLanguageCode,
        onChanged: (languageCode) async {
          await _saveLanguage(languageCode);

          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
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

  String _languageButtonLabel(String code) {
    return switch (code) {
      'uk' => 'UA',
      'ru' => 'RU',
      _ => 'EN',
    };
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
                Row(
                  children: [
                    _TopRoundButton(
                      icon: Icons.language,
                      label: _languageButtonLabel(languageCode),
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
                PotioPageHeader(
                  eyebrow: AppText.get(languageCode, 'home_eyebrow'),
                  title: AppText.get(languageCode, 'app_name'),
                  subtitle: AppText.get(languageCode, 'home_subtitle'),
                  icon: Icons.local_bar,
                ),
                const SizedBox(height: 12),
                _StudioLabel(languageCode: languageCode),
                const SizedBox(height: 18),
                PotioCard(
                  badge: AppText.get(languageCode, 'free_campaign'),
                  icon: Icons.route_outlined,
                  title: AppText.get(languageCode, 'basic_bar_academy'),
                  subtitle: AppText.get(languageCode, 'basic_bar_subtitle'),
                  onTap: () => _tapAndOpen(
                    context,
                    const PotioCampaignScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'encyclopedia'),
                  icon: Icons.receipt_long_outlined,
                  title: AppText.get(languageCode, 'recipe_cards'),
                  subtitle: AppText.get(languageCode, 'recipe_cards_subtitle'),
                  onTap: () => _tapAndOpen(
                    context,
                    const EncyclopediaScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'free_daily'),
                  icon: Icons.calendar_month_outlined,
                  title: AppText.get(languageCode, 'daily_mixology'),
                  subtitle:
                      AppText.get(languageCode, 'daily_mixology_subtitle'),
                  onTap: () => _tapAndOpen(
                    context,
                    const DailyMixologyChallengeScreen(),
                  ),
                ),
                const SizedBox(height: 12),
                PotioCard(
                  badge: AppText.get(languageCode, 'all_modes'),
                  icon: Icons.extension_outlined,
                  title: AppText.get(languageCode, 'practice_bar'),
                  subtitle: AppText.get(languageCode, 'practice_bar_subtitle'),
                  onTap: () => _tapAndOpen(
                    context,
                    const PlayScreen(),
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

class _StudioLabel extends StatelessWidget {
  final String languageCode;

  const _StudioLabel({
    required this.languageCode,
  });

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
        Text(
          AppText.get(languageCode, 'created_by'),
          style: const TextStyle(
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
  final String selectedLanguageCode;
  final ValueChanged<String> onChanged;

  const _LanguageSheet({
    required this.selectedLanguageCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.languageCode,
      builder: (context, languageCode, _) {
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
              Text(
                AppText.get(languageCode, 'choose_language'),
                style: const TextStyle(
                  color: potioInk,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              _LanguageOption(
                flag: '🇬🇧',
                title: AppText.get(languageCode, 'english'),
                subtitle: selectedLanguageCode == 'en'
                    ? AppText.get(languageCode, 'current_language')
                    : '',
                selected: selectedLanguageCode == 'en',
                onTap: () async {
                  await PotioAudioService.instance.playTap();
                  onChanged('en');
                },
              ),
              _LanguageOption(
                flag: '🇺🇦',
                title: AppText.get(languageCode, 'ukrainian'),
                subtitle: selectedLanguageCode == 'uk'
                    ? AppText.get(languageCode, 'current_language')
                    : '',
                selected: selectedLanguageCode == 'uk',
                onTap: () async {
                  await PotioAudioService.instance.playTap();
                  onChanged('uk');
                },
              ),
              _LanguageOption(
                flag: '🇷🇺',
                title: AppText.get(languageCode, 'russian'),
                subtitle: selectedLanguageCode == 'ru'
                    ? AppText.get(languageCode, 'current_language')
                    : '',
                selected: selectedLanguageCode == 'ru',
                onTap: () async {
                  await PotioAudioService.instance.playTap();
                  onChanged('ru');
                },
              ),
            ],
          ),
        );
      },
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
      onTap: onTap,
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
      subtitle: subtitle.isEmpty
          ? null
          : Text(
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