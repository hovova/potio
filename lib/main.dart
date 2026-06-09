import 'package:flutter/material.dart';

import 'screens/root_screen.dart';
import 'services/audio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PotioApp());

  Future.delayed(const Duration(milliseconds: 800), () {
    PotioAudioService.instance.startBackgroundMusic();
  });
}

class PotioApp extends StatelessWidget {
  const PotioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1E120C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F6F5B),
          brightness: Brightness.dark,
        ),
      ),
      home: const RootScreen(),
    );
  }
}