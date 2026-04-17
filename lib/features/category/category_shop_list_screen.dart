import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../models/shop_model.dart';
import '../../services/shop_service.dart';
import '../home/widgets/shop_list_card.dart';
import '../shop/shop_detail_screen.dart';

class CategoryShopListScreen extends StatelessWidget {
  final String categoryName;

  const CategoryShopListScreen({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final horizontalPadding = Responsive.horizontalPadding(context);

    return StreamBuilder<List<Shop>>(
      stream: ShopService.streamShopsByCategory(categoryName),
      builder: (context, snapshot) {
        final shops = snapshot.data ?? const <Shop>[];
        return Scaffold(
          backgroundColor: AppTheme.background,
          appBar: _buildAppBar(context, shops.length),
          body: ResponsiveCenter(
            child: snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : shops.isEmpty
                    ? _EmptyState(categoryName: categoryName, tt: tt)
                    : ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          12,
                          horizontalPadding,
                          12,
                        ),
                        itemCount: shops.length,
                        itemBuilder: (context, index) {
                          final shop = shops[index];
                          return ShopListCard(
                            shop: shop,
                            showImage: false,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShopDetailScreen(shop: shop),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, int shopCount) {
    final tt = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: AppTheme.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppTheme.outline,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, size: 24),
        onPressed: () => Navigator.of(context).pop(),
        color: AppTheme.onBackground,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryName,
            style: tt.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.onBackground,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            shopCount == 1 ? '1 shop available' : '$shopCount shops available',
            style: tt.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state when no shops in category ─────────────────────────
class _EmptyState extends StatelessWidget {
  final String categoryName;
  final TextTheme tt;

  const _EmptyState({required this.categoryName, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.store_mall_directory_outlined,
              size: 64,
              color: AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No shops yet in $categoryName',
              style: tt.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for new listings',
              style: tt.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
