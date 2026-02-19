import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../models/shop_model.dart';

class MerchantDashboardScreen extends StatefulWidget {
  /// Optional shop profile. If null, shows "No Shop Profile Yet" state.
  final Shop? initialShop;

  const MerchantDashboardScreen({
    super.key,
    this.initialShop,
  });

  @override
  State<MerchantDashboardScreen> createState() =>
      _MerchantDashboardScreenState();
}

class _MerchantDashboardScreenState extends State<MerchantDashboardScreen> {
  Shop? _currentShop;

  @override
  void initState() {
    super.initState();
    _currentShop = widget.initialShop;
  }

  void _logout() {
    // TODO: Clear auth state and navigate back to RoleSelectorScreen
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _createOrEditShop() {
    // TODO: Navigate to ShopProfileManagementScreen
    debugPrint(
      _currentShop == null ? 'Create shop profile' : 'Edit shop profile',
    );

    // DEMO: Toggle between states for testing
    setState(() {
      if (_currentShop == null) {
        _currentShop = Shop(
          id: 'demo_shop',
          name: 'CocoCafe',
          category: 'food',
          description: 'Coffee Shop',
          rating: 4.5,
          imageUrls: [],
          priceRange: '23',
          location: 'uni',
          phone: '12324',
        );
      } else {
        _currentShop = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.horizontalPadding(context);
    final verticalPadding = Responsive.verticalPadding(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Main content card
                  _currentShop == null
                      ? _NoShopState(onCreateShop: _createOrEditShop)
                      : _ShopProfileCard(
                          shop: _currentShop!,
                          onEditShop: _createOrEditShop,
                        ),
                  const SizedBox(height: 20),

                  // Tips for success section
                  _TipsForSuccessSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.surface,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.link_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Text(
            'M-Link',
            style: TextStyle(
              color: AppTheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: _logout,
          icon: const Icon(Icons.logout_rounded, size: 18),
          label: const Text('Logout'),
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.onBackground,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

// ── No shop profile state ─────────────────────────────────────────
class _NoShopState extends StatelessWidget {
  final VoidCallback onCreateShop;

  const _NoShopState({required this.onCreateShop});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Column(
        children: [
          // Empty state icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.storefront_outlined,
              size: 40,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            'No Shop Profile Yet',
            style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Create your shop profile to start reaching students',
            style: tt.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Create button
          ElevatedButton.icon(
            onPressed: onCreateShop,
            style: AppTheme.merchantButtonStyle,
            icon: const Icon(Icons.add_business_rounded, size: 20),
            label: const Text('Create Shop Profile'),
          ),
        ],
      ),
    );
  }
}

// ── Shop profile card (when shop exists) ──────────────────────────
class _ShopProfileCard extends StatelessWidget {
  final Shop shop;
  final VoidCallback onEditShop;

  const _ShopProfileCard({required this.shop, required this.onEditShop});

  String _formatDate() {
    final now = DateTime.now();
    return '${now.month}/${now.day}/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Shop info card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            border: Border.all(color: AppTheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop name
              Text(
                shop.name,
                style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),

              // Last updated
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: AppTheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Last updated: ${_formatDate()}',
                    style: tt.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category
              _InfoRow(label: 'Category', value: shop.category, tt: tt),
              const SizedBox(height: 8),

              // Price Range
              _InfoRow(label: 'Price Range', value: shop.priceRange, tt: tt),
              const SizedBox(height: 8),

              // Location
              _InfoRow(label: 'Location', value: shop.location, tt: tt),
              const SizedBox(height: 8),

              // Phone
              _InfoRow(label: 'Phone', value: shop.phone, tt: tt),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Description section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            border: Border.all(color: AppTheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description', style: tt.titleMedium),
              const SizedBox(height: 8),
              Text(
                shop.description,
                style: tt.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Edit button
        ElevatedButton.icon(
          onPressed: onEditShop,
          style: AppTheme.merchantButtonStyle,
          icon: const Icon(Icons.edit_rounded, size: 20),
          label: const Text('Edit Shop Profile'),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextTheme tt;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: tt.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppTheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tips for Success section ──────────────────────────────────────
class _TipsForSuccessSection extends StatelessWidget {
  final List<String> tips = const [
    'Keep your shop information up-to-date',
    'Use clear, high-quality images',
    'Provide accurate pricing information',
    'Include your exact location and directions',
  ];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.iconCircleGreen,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tips for Success',
            style: tt.titleMedium?.copyWith(
              color: AppTheme.secondaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...tips.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: tt.bodyMedium?.copyWith(
                        color: AppTheme.secondaryDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        tip,
                        style: tt.bodyMedium?.copyWith(
                          color: AppTheme.secondaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
