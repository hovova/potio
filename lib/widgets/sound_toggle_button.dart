import 'package:flutter/material.dart';

class SoundToggleButton extends StatelessWidget {
  final bool? enabled;
  final bool? soundEnabled;
  final VoidCallback onTap;
  final String label;

  const SoundToggleButton({
    super.key,
    this.enabled,
    this.soundEnabled,
    required this.onTap,
    this.label = 'Sound',
  });

  bool get isEnabled => enabled ?? soundEnabled ?? true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: label,
      onPressed: onTap,
      icon: Icon(
        isEnabled ? Icons.volume_up : Icons.volume_off,
        color: const Color(0xFFFFCC7A),
      ),
    );
  }
}
