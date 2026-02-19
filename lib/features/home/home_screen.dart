import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/mock_shops.dart';
import '../category/category_shop_list_screen.dart';
import '../home/widgets/category_card.dart';

// ── Category data model ───────────────────────────────────────────
class _Category {
  final String name;
  final String subtitle;
  final IconData icon;

  const _Category({
    required this.name,
    required this.subtitle,
    required this.icon,
  });
}

// ── All categories ────────────────────────────────────────────────
const List<_Category> _categories = [
  _Category(
    name: 'Food',
    subtitle: 'Restaurants, cafes, and food delivery',
    icon: Icons.restaurant_outlined,
  ),
  _Category(
    name: 'Rentals',
    subtitle: 'Student housing and room rentals',
    icon: Icons.home_outlined,
  ),
  _Category(
    name: 'Optical Shops',
    subtitle: 'Eyewear and vision care',
    icon: Icons.remove_red_eye_outlined,
  ),
  _Category(
    name: 'Repairs',
    subtitle: 'Electronics and gadget repairs',
    icon: Icons.build_outlined,
  ),
  _Category(
    name: 'Fashion',
    subtitle: 'Clothing, accessories, and more',
    icon: Icons.checkroom_outlined,
  ),
  _Category(
    name: 'Stationery',
    subtitle: 'Books, supplies, and printing',
    icon: Icons.menu_book_outlined,
  ),
  _Category(
    name: 'Health',
    subtitle: 'Pharmacy and wellness services',
    icon: Icons.local_pharmacy_outlined,
  ),
  _Category(
    name: 'Transport',
    subtitle: 'Bikes, rides, and delivery',
    icon: Icons.directions_bike_outlined,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Category> get _filteredCategories {
    if (_searchQuery.isEmpty) return _categories;
    final q = _searchQuery.toLowerCase();
    return _categories
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.subtitle.toLowerCase().contains(q))
        .toList();
  }

  int _shopCountFor(String category) =>
      mockShops.where((s) => s.category == category).length;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final filtered = _filteredCategories;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Search Bar ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              style: tt.bodyMedium?.copyWith(color: AppTheme.onBackground),
              decoration: InputDecoration(
                hintText: 'Search for services...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // ── Section Heading ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Browse Categories', style: tt.headlineSmall),
          ),

          // ── Category Grid ───────────────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? _EmptySearchState(query: _searchQuery)
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final cat = filtered[index];
                      final count = _shopCountFor(cat.name);
                      return CategoryCard(
                        icon: cat.icon,
                        title: cat.name,
                        badge: count > 0 ? '$count' : null,
                        iconBackgroundColor: AppTheme.iconCircleBlue,
                        iconColor: AppTheme.primary,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategoryShopListScreen(
                                categoryName: cat.name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppTheme.outline,
      leading: TextButton.icon(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
        label: const Text('Back'),
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.onBackground,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      leadingWidth: 90,
      actions: [
        // M-Link logo badge
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.link_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'M-Link',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Empty search state ────────────────────────────────────────────
class _EmptySearchState extends StatelessWidget {
  final String query;
  const _EmptySearchState({required this.query});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 56, color: AppTheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              'No results for "$query"',
              style: tt.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Try a different keyword',
              style: tt.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
