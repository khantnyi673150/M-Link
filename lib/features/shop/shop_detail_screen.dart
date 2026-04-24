import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../models/shop_model.dart';
import '../../models/menu_item.dart';
import '../../services/shop_service.dart';
import 'widgets/shop_image_carousel.dart';
import 'widgets/shop_info_section.dart';

class ShopDetailScreen extends StatelessWidget {
  final Shop shop;

  const ShopDetailScreen({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Back button at the top
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.9),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  color: AppTheme.onBackground,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),

          // Fixed image carousel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ShopImageCarousel(
              imageUrls: shop.imageUrls,
              height: 260,
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          // Scrollable content below
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),

                  // Shop info card
                  ShopInfoSection(
                    name: shop.name,
                    category: shop.category,
                    rating: shop.rating,
                    description: shop.description,
                  ),
                  const SizedBox(height: 16),

                  // Price Range card
                  _PriceRangeCard(shop: shop),
                  const SizedBox(height: 16),

                  // Menu section
                  _MenuSection(shopId: shop.id),
                  const SizedBox(height: 16),

                  // Contact & Order section
                  _ContactSection(shop: shop),
                  const SizedBox(height: 20),

                  // Get Directions button
                  ElevatedButton.icon(
                    onPressed: () => _openDirections(context, shop),
                    icon: const Icon(Icons.navigation_rounded, size: 20),
                    label: const Text('Get Directions'),
                  ),
                  const SizedBox(height: 16),

                  // Disclaimer
                  _DisclaimerText(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _openDirections(BuildContext context, Shop shop) async {
  final messenger = ScaffoldMessenger.of(context);
  final candidates = <Uri>[];

  final directMapsUrl = shop.googleMapsUrl.trim();
  if (directMapsUrl.isNotEmpty) {
    final parsedDirectUrl = Uri.tryParse(directMapsUrl);
    if (_isDirectUrl(parsedDirectUrl)) {
      candidates.add(parsedDirectUrl!);
    }
  }

  final trimmedLocation = shop.location.trim();
  if (trimmedLocation.isEmpty) {
    messenger.showSnackBar(
      const SnackBar(content: Text('No location provided for this shop.')),
    );
    return;
  }

  final parsedLocationUrl = Uri.tryParse(trimmedLocation);
  if (_isDirectUrl(parsedLocationUrl)) {
    candidates.add(parsedLocationUrl!);
  } else {
    final encodedLocation = Uri.encodeComponent(trimmedLocation);
    candidates.add(
      Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$encodedLocation',
      ),
    );
    candidates.add(
      Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encodedLocation',
      ),
    );
  }

  for (final uri in candidates) {
    try {
      if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        return;
      }
    } catch (_) {
      // Try the next candidate or fallback mode.
    }
  }

  for (final uri in candidates) {
    try {
      if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {
        return;
      }
    } catch (_) {
      // Try the next candidate.
    }
  }

  if (!context.mounted) return;
  messenger.showSnackBar(
    const SnackBar(content: Text('Unable to open Google Maps.')),
  );
}

bool _isDirectUrl(Uri? uri) {
  if (uri == null || !uri.hasScheme) return false;
  return uri.scheme == 'http' || uri.scheme == 'https';
}

// ── Price Range card ──────────────────────────────────────────────
class _PriceRangeCard extends StatelessWidget {
  final Shop shop;
  const _PriceRangeCard({required this.shop});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price Range', style: tt.titleMedium),
          const SizedBox(height: 8),
          Text(
            shop.priceRange,
            style: tt.headlineSmall?.copyWith(
              color: AppTheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Student-friendly pricing',
            style: tt.bodySmall?.copyWith(color: AppTheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// ── Menu section ──────────────────────────────────────────────────
class _MenuSection extends StatelessWidget {
  final String shopId;

  const _MenuSection({required this.shopId});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Menu', style: tt.titleMedium),
          const SizedBox(height: 12),
          StreamBuilder<List<MenuItem>>(
            stream: ShopService.streamMenuItems(shopId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final items = snapshot.data ?? const <MenuItem>[];
              if (items.isEmpty) {
                return Text(
                  'No menu items added yet.',
                  style: tt.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                );
              }

              return Column(
                children: items
                    .map((item) => _MenuItemRow(item: item))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MenuItemRow extends StatelessWidget {
  final MenuItem item;
  const _MenuItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: tt.titleSmall),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  style: tt.bodySmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: tt.labelLarge?.copyWith(
              color: AppTheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Contact & Order section ───────────────────────────────────────
class _ContactSection extends StatelessWidget {
  final Shop shop;
  const _ContactSection({required this.shop});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact & Order', style: tt.titleMedium),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.phone_rounded,
            iconColor: AppTheme.primary,
            label: 'Phone',
            value: shop.phone,
            onTap: () {
              Clipboard.setData(ClipboardData(text: shop.phone));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Phone number copied')),
              );
            },
          ),
          _ContactRow(
            icon: Icons.facebook_rounded,
            iconColor: const Color(0xFF1877F2),
            label: 'Facebook',
            value: 'Visit our page',
            onTap: () => debugPrint('Open Facebook'),
          ),
          _ContactRow(
            icon: Icons.chat_rounded,
            iconColor: const Color(0xFF00B900),
            label: 'Line',
            value: 'Message us',
            onTap: () => debugPrint('Open Line'),
          ),
          _ContactRow(
            icon: Icons.camera_alt_rounded,
            iconColor: const Color(0xFFE4405F),
            label: 'Instagram',
            value: 'Follow us',
            onTap: () => debugPrint('Open Instagram'),
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool isLast;

  const _ContactRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: tt.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  Text(value, style: tt.titleSmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Disclaimer text ───────────────────────────────────────────────
class _DisclaimerText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Text(
      'This information is provided by the merchant. Please verify details before visiting.',
      style: tt.bodySmall?.copyWith(
        color: AppTheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    );
  }
}
