import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/potio_card.dart';

final ValueNotifier<bool> potioPremiumActiveNotifier = ValueNotifier<bool>(false);

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  void _showPurchaseComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Premium purchase will be connected to Google Play Billing later.',
        ),
      ),
    );
  }

  void _toggleDeveloperPremium() {
    potioPremiumActiveNotifier.value = !potioPremiumActiveNotifier.value;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          potioPremiumActiveNotifier.value
              ? 'Developer mode: Premium unlocked.'
              : 'Developer mode: Premium disabled.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PotioScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const PotioPageHeader(
              eyebrow: 'Potio Premium',
              title: 'Upgrade',
              subtitle:
                  'Compare the free learning experience with the full Master Mixologist version.',
              icon: Icons.workspace_premium,
            ),
            const SizedBox(height: 18),
            ValueListenableBuilder<bool>(
              valueListenable: potioPremiumActiveNotifier,
              builder: (context, premiumActive, _) {
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: premiumActive
                        ? potioEmerald.withValues(alpha: 0.95)
                        : potioDarkCoffee.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: premiumActive
                          ? potioPaper.withValues(alpha: 0.28)
                          : potioCopperLight.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        premiumActive
                            ? Icons.verified
                            : Icons.workspace_premium_outlined,
                        color: premiumActive ? potioPaper : potioCopperLight,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          premiumActive
                              ? 'Premium Status: Active'
                              : 'Premium Status: Not active',
                          style: TextStyle(
                            color: premiumActive ? potioPaper : potioPaperDeep,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _PlanCard(
                    title: 'Free',
                    subtitle: 'Included',
                    features: [
                      PlanFeature('50 popular drinks'),
                      PlanFeature('20-level Basic Academy'),
                      PlanFeature('Daily Mixology'),
                      PlanFeature('All quiz modes'),
                      PlanFeature('Filters & favourites'),
                      PlanFeature('Ads included'),
                      PlanFeature('100+ drinks', included: false),
                      PlanFeature('Master Academy', included: false),
                      PlanFeature('Offline / no ads', included: false),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _PlanCard(
                    title: 'Premium',
                    subtitle: 'Full access',
                    highlighted: true,
                    features: [
                      PlanFeature('100+ total drinks'),
                      PlanFeature('Master Mixologist Academy'),
                      PlanFeature('Full bartender guide'),
                      PlanFeature('Offline access'),
                      PlanFeature('No ads'),
                      PlanFeature('Future premium packs'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: potioEmerald,
                foregroundColor: potioPaper,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: _showPurchaseComingSoon,
              icon: const Icon(Icons.workspace_premium),
              label: const Text(
                'Unlock Potio Premium',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            if (kDebugMode) ...[
              const SizedBox(height: 10),
              ValueListenableBuilder<bool>(
                valueListenable: potioPremiumActiveNotifier,
                builder: (context, premiumActive, _) {
                  return OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: potioCopperLight,
                      side: const BorderSide(color: potioCopperLight),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: _toggleDeveloperPremium,
                    icon: Icon(
                      premiumActive
                          ? Icons.lock_open
                          : Icons.developer_mode,
                    ),
                    label: Text(
                      premiumActive
                          ? 'Developer: Disable Premium'
                          : 'Developer: Unlock Premium',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              const Text(
                'Debug-only button. This will not appear in release builds.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: potioPaperDeep,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            const SizedBox(height: 12),
            const PotioCard(
              badge: 'Premium unlocks',
              icon: Icons.menu_book_outlined,
              title: 'Full Bartender Guide',
              subtitle:
                  'Learn techniques, glassware, allergens, service knowledge, and advanced recipe logic.',
            ),
            const SizedBox(height: 12),
            const PotioCard(
              badge: 'Premium campaign',
              icon: Icons.route_outlined,
              title: 'Master Mixologist Academy',
              subtitle:
                  'A more advanced campaign built around 100+ drinks and bartender-style challenges.',
            ),
            const SizedBox(height: 12),
            const PotioCard(
              badge: 'Comfort',
              icon: Icons.cloud_off_outlined,
              title: 'Offline + No Ads',
              subtitle:
                  'Use the full encyclopedia offline and remove ads from the Potio experience.',
            ),
          ],
        ),
      ),
    );
  }
}

class PlanFeature {
  final String text;
  final bool included;

  const PlanFeature(
    this.text, {
    this.included = true,
  });
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<PlanFeature> features;
  final bool highlighted;

  const _PlanCard({
    required this.title,
    required this.subtitle,
    required this.features,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final background = highlighted ? potioEmerald : Colors.white;
    final titleColor = highlighted ? potioPaper : potioInk;
    final subtitleColor = highlighted ? potioPaperDeep : potioMutedInk;
    final includedColor = highlighted ? potioPaper : potioEmerald;
    final excludedColor = highlighted
        ? potioPaperDeep.withValues(alpha: 0.65)
        : potioMutedInk.withValues(alpha: 0.62);

    return Container(
      constraints: const BoxConstraints(minHeight: 292),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: highlighted
              ? potioEmerald
              : potioMutedInk.withValues(alpha: 0.14),
        ),
        boxShadow: highlighted
            ? [
                BoxShadow(
                  color: potioEmerald.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: subtitleColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          for (final feature in features)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    feature.included ? Icons.check_circle : Icons.cancel,
                    color: feature.included ? includedColor : excludedColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      feature.text,
                      style: TextStyle(
                        color: feature.included
                            ? subtitleColor
                            : excludedColor,
                        fontSize: 12,
                        height: 1.22,
                        fontWeight: FontWeight.w800,
                        decoration: feature.included
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                        decorationColor: excludedColor,
                        decorationThickness: 1.8,
                      ),
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