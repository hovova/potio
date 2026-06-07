import 'package:flutter/material.dart';

class PremiumBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const PremiumBanner({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFCC7A),
              Color(0xFFD98531),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.workspace_premium, color: Color(0xFF241109)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Premium: 100+ drinks, Master Mixologist Academy, full bartender guide, offline access, and no ads.',
                style: TextStyle(
                  color: Color(0xFF241109),
                  fontWeight: FontWeight.w900,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
