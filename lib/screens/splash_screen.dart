import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: potioEspresso,
      body: PotioScaffold(
        child: DefaultTextStyle(
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      color: potioPaper,
                      borderRadius: BorderRadius.circular(34),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 28,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.local_bar,
                      color: potioEmerald,
                      size: 54,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'POTIO',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: potioPaper,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'by Mriya Interactive',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: potioCopperLight,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 34),
                  const SizedBox(
                    width: 34,
                    height: 34,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: potioCopperLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}