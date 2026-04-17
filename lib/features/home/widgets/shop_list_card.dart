import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/shop_model.dart';

/// A compact card for displaying shops in a list view.
class ShopListCard extends StatelessWidget {
  final Shop shop;
  final VoidCallback onTap;
  final bool showImage;

  const ShopListCard({
    super.key,
    required this.shop,
    required this.onTap,
    this.showImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showImage)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  shop.imageUrls.isNotEmpty
                      ? shop.imageUrls.first
                      : 'https://via.placeholder.com/640x360',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.surfaceVariant,
                      child: const Center(
                        child: Icon(
                          Icons.storefront_outlined,
                          color: AppTheme.onSurfaceVariant,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    shop.description,
                    style: tt.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          shop.priceRange,
                          style: tt.labelLarge?.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppTheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 3),
                            Flexible(
                              child: Text(
                                shop.location,
                                style: tt.bodySmall?.copyWith(
                                  color: AppTheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          ),
      ),
    );
  }
}
