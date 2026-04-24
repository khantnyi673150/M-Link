import 'package:flutter/material.dart';

class ShopInfoSection extends StatelessWidget {
  final String name;
  final String category;
  final double rating;
  final String description;

  const ShopInfoSection({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;
    final cs = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Name ──────────────────────────────────────────────
          Text(name, style: tt.headlineMedium),
          const SizedBox(height: 12),

          // ── Category & Rating row ─────────────────────────────
          Row(
            children: [
              _CategoryChip(category: category, theme: theme),
              const Spacer(),
              _RatingBadge(rating: rating, theme: theme),
            ],
          ),
          const SizedBox(height: 12),

          // ── Description ───────────────────────────────────────
          Text(description, style: tt.bodyMedium),
        ],
      ),
    );
  }
}

// ── Category chip ─────────────────────────────────────────────────
class _CategoryChip extends StatelessWidget {
  final String category;
  final ThemeData theme;

  const _CategoryChip({required this.category, required this.theme});

  @override
  Widget build(BuildContext context) {
    final cs = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.storefront_outlined, size: 14, color: cs.primary),
          const SizedBox(width: 4),
          Text(
            category,
            style: theme.textTheme.labelMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Star rating badge ─────────────────────────────────────────────
class _RatingBadge extends StatelessWidget {
  final double rating;
  final ThemeData theme;

  const _RatingBadge({required this.rating, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 18, color: Color(0xFFF59E0B)),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
