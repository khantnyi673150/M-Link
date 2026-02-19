import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  /// Optional badge text shown at the bottom (e.g. "3 shops").
  final String? badge;

  /// Background color of the icon circle.
  /// Defaults to theme primaryContainer (blue tint).
  final Color? iconBackgroundColor;

  /// Icon color. Defaults to theme primary.
  final Color? iconColor;

  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.badge,
    this.iconBackgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final resolvedIconBg = iconBackgroundColor ?? cs.primaryContainer;
    final resolvedIconColor = iconColor ?? cs.primary;

    return Card(
      // Card theme provides 12px radius, white bg, and 1px border
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Icon Circle ──────────────────────────────────
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: resolvedIconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: resolvedIconColor),
              ),
              const SizedBox(height: 8),

              // ── Title ────────────────────────────────────────
              Text(
                title,
                style: tt.titleSmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // ── Shop count badge (optional) ───────────────────
              if (badge != null) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: resolvedIconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge!,
                    style: tt.labelSmall?.copyWith(
                      color: resolvedIconColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
