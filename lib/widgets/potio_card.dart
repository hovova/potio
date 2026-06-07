import 'package:flutter/material.dart';

const potioEspresso = Color(0xFF1E120C);
const potioDarkCoffee = Color(0xFF2B1A12);
const potioPaper = Color(0xFFFFF3DF);
const potioPaperDeep = Color(0xFFF4D8B4);
const potioCopper = Color(0xFFC9833D);
const potioCopperLight = Color(0xFFE8B36A);
const potioEmerald = Color(0xFF1F6F5B);
const potioSage = Color(0xFF9DBF9E);
const potioInk = Color(0xFF2A160E);
const potioMutedInk = Color(0xFF765A45);

class PotioScaffold extends StatelessWidget {
  final Widget child;

  const PotioScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: potioEspresso,
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: potioEmerald.withValues(alpha: 0.22),
              ),
            ),
          ),
          Positioned(
            bottom: -140,
            left: -90,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: potioCopper.withValues(alpha: 0.18),
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class PotioPageHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final IconData icon;

  const PotioPageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        color: potioPaper,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: potioEmerald,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: potioPaper,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow.toUpperCase(),
                  style: const TextStyle(
                    color: potioCopper,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    color: potioInk,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: potioMutedInk,
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PotioSectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const PotioSectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return PotioPageHeader(
      eyebrow: 'Potio',
      title: title,
      subtitle: subtitle,
      icon: Icons.local_bar,
    );
  }
}

class PotioCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final Widget? trailing;
  final VoidCallback? onTap;

  const PotioCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: potioDarkCoffee.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: potioCopperLight.withValues(alpha: 0.22),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: potioPaper.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Icon(
                icon,
                color: potioCopperLight,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (badge != null) ...[
                    Text(
                      badge!.toUpperCase(),
                      style: const TextStyle(
                        color: potioSage,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    title,
                    style: const TextStyle(
                      color: potioPaper,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: potioPaperDeep,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 10),
              trailing!,
            ] else
              const Icon(
                Icons.chevron_right,
                color: potioCopperLight,
              ),
          ],
        ),
      ),
    );
  }
}

class PotioChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const PotioChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onTap,
      label: Text(label),
      backgroundColor: selected ? potioEmerald : potioDarkCoffee,
      labelStyle: TextStyle(
        color: selected ? potioPaper : potioPaperDeep,
        fontWeight: FontWeight.w800,
      ),
      side: BorderSide(
        color: selected
            ? potioEmerald
            : potioCopperLight.withValues(alpha: 0.28),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class PotioStatPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const PotioStatPill({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: potioPaper.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: potioCopperLight.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: potioCopperLight,
            size: 20,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: potioPaper,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: potioPaperDeep,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}