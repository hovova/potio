import 'package:flutter/material.dart';

import '../services/audio_service.dart';
import 'potio_card.dart';

class SoundToggleButton extends StatelessWidget {
  final String label;

  const SoundToggleButton({
    super.key,
    this.label = 'Sound',
  });

  void _openSoundMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _SoundMenuSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: PotioAudioService.instance.soundEnabled,
      builder: (context, soundEnabled, _) {
        return Material(
          color: potioPaper,
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: () {
              PotioAudioService.instance.playTap();
              _openSoundMenu(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    soundEnabled ? Icons.volume_up : Icons.volume_off,
                    color: potioEmerald,
                    size: 18,
                  ),
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
      },
    );
  }
}

class _SoundMenuSheet extends StatelessWidget {
  const _SoundMenuSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      decoration: const BoxDecoration(
        color: potioPaper,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        top: false,
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
            const Icon(
              Icons.volume_up,
              color: potioEmerald,
              size: 38,
            ),
            const SizedBox(height: 8),
            const Text(
              'Audio Settings',
              style: TextStyle(
                color: potioInk,
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 18),
            ValueListenableBuilder<bool>(
              valueListenable: PotioAudioService.instance.soundEnabled,
              builder: (context, enabled, _) {
                return _AudioSettingTile(
                  icon: enabled ? Icons.volume_up : Icons.volume_off,
                  title: 'Sound Effects',
                  subtitle: 'Button taps, correct/wrong answers, achievements',
                  value: enabled,
                  onChanged: (_) async {
                    await PotioAudioService.instance.toggleSound();
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<bool>(
              valueListenable: PotioAudioService.instance.musicEnabled,
              builder: (context, enabled, _) {
                return _AudioSettingTile(
                  icon: enabled ? Icons.music_note : Icons.music_off,
                  title: 'Background Music',
                  subtitle: 'Potio background loop',
                  value: enabled,
                  onChanged: (_) async {
                    await PotioAudioService.instance.toggleMusic();
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: potioEmerald,
                  foregroundColor: potioPaper,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Done',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AudioSettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => onChanged(!value),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: potioMutedInk.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: potioEmerald,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: potioInk,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: potioMutedInk,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                activeThumbColor: potioEmerald,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}