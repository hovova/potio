import 'package:flutter/material.dart';

import 'screens/root_screen.dart';

void main() {
  runApp(const PotioApp());
}

class PotioApp extends StatelessWidget {
  const PotioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF130B08),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE9A84C),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const RootScreen(),
    );
  }
}