import 'package:flutter/material.dart';

import '../data/app_text.dart';
import '../services/audio_service.dart';
import '../services/language_service.dart';
import '../services/progress_storage_service.dart';
import 'campaign_screen.dart';
import 'encyclopedia_screen.dart';
import 'home_screen.dart';
import 'play_screen.dart';
import 'profile_screen.dart';
import 'splash_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final ProgressStorageService _storage = ProgressStorageService();

  int selectedIndex = 0;
  bool isLoading = true;

  final screens = const [
    HomeScreen(),
    PlayScreen(),
    EncyclopediaScreen(),
    PotioCampaignScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _showSplashBriefly();
  }

  Future<void> _loadLanguage() async {
    final progress = await _storage.loadProgress();
    LanguageService.instance.setLanguage(progress.selectedLanguageCode);
  }

  Future<void> _showSplashBriefly() async {
    await Future.delayed(const Duration(milliseconds: 1600));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  Future<void> onTabSelected(int index) async {
    await PotioAudioService.instance.playTap();

    if (!mounted) return;

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SplashScreen();
    }

    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.instance.languageCode,
      builder: (context, languageCode, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF1E120C),
          body: screens[selectedIndex],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3DF),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.28),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onTabSelected,
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorColor: const Color(0xFF1F6F5B).withValues(alpha: 0.16),
              labelTextStyle: WidgetStateProperty.all(
                const TextStyle(
                  color: Color(0xFF2A160E),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
              destinations: [
                NavigationDestination(
                  icon: const Icon(
                    Icons.local_bar_outlined,
                    color: Color(0xFF2A160E),
                  ),
                  selectedIcon: const Icon(
                    Icons.local_bar,
                    color: Color(0xFF1F6F5B),
                  ),
                  label: AppText.get(languageCode, 'nav_home'),
                ),
                NavigationDestination(
                  icon: const Icon(
                    Icons.extension_outlined,
                    color: Color(0xFF2A160E),
                  ),
                  selectedIcon: const Icon(
                    Icons.extension,
                    color: Color(0xFF1F6F5B),
                  ),
                  label: AppText.get(languageCode, 'nav_play'),
                ),
                NavigationDestination(
                  icon: const Icon(
                    Icons.menu_book_outlined,
                    color: Color(0xFF2A160E),
                  ),
                  selectedIcon: const Icon(
                    Icons.menu_book,
                    color: Color(0xFF1F6F5B),
                  ),
                  label: AppText.get(languageCode, 'nav_drinks'),
                ),
                NavigationDestination(
                  icon: const Icon(
                    Icons.route_outlined,
                    color: Color(0xFF2A160E),
                  ),
                  selectedIcon: const Icon(
                    Icons.route,
                    color: Color(0xFF1F6F5B),
                  ),
                  label: AppText.get(languageCode, 'nav_academy'),
                ),
                NavigationDestination(
                  icon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF2A160E),
                  ),
                  selectedIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF1F6F5B),
                  ),
                  label: AppText.get(languageCode, 'nav_profile'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}