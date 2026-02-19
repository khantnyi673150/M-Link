import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  /// Optional icon shown above the value.
  final IconData? icon;

  /// Optional accent color for the value text and icon.
  /// Defaults to theme primary.
  final Color? accentColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final resolvedAccent = accentColor ?? cs.primary;

    return Card(
      // Card theme provides 12px radius, white bg, 1px outline border
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon (optional) ──────────────────────────────
            if (icon != null) ...[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: resolvedAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: resolvedAccent),
              ),
              const SizedBox(height: 12),
            ],

            // ── Value ─────────────────────────────────────────
            Text(
              value,
              style: tt.headlineSmall?.copyWith(
                color: resolvedAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),

            // ── Title ─────────────────────────────────────────
            Text(
              title,
              style: tt.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
