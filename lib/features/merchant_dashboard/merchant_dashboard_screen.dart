import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../models/shop_model.dart';
import '../../services/auth_service.dart';
import '../../services/shop_service.dart';
import '../shop_management/shop_profile_management_screen.dart';

class MerchantDashboardScreen extends StatefulWidget {
  const MerchantDashboardScreen({super.key});

  @override
  State<MerchantDashboardScreen> createState() =>
      _MerchantDashboardScreenState();
}

class _MerchantDashboardScreenState extends State<MerchantDashboardScreen> {
  Shop? _currentShop;
  bool _isLoading = true;
  bool _isDeletingAccount = false;

  @override
  void initState() {
    super.initState();
    _loadShop();
  }

  Future<void> _loadShop() async {
    final user = AuthService.currentUser;
    if (user == null) {
      if (mounted) {
        _goToRoleSelector();
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      final shop = await ShopService.getMerchantShop(user.uid);
      if (!mounted) return;
      setState(() {
        _currentShop = shop;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to load your shop right now.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _logout() async {
    await AuthService.signOut();
    if (!mounted) return;
    _goToRoleSelector();
  }

  Future<void> _deleteAccount() async {
    final user = AuthService.currentUser;
    if (user == null) {
      _goToRoleSelector();
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Merchant Account?'),
        content: const Text(
          'This will permanently remove your account, shop profile, and menu items. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final email = user.email;
    if (email == null || email.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Missing account email. Please log in again.'),
        ),
      );
      return;
    }

    final password = await _askPasswordForDeletion();
    if (password == null || password.isEmpty) return;

    if (!mounted) return;
    setState(() => _isDeletingAccount = true);
    try {
      await AuthService.reauthenticateCurrentUser(
        email: email,
        password: password,
      );
      await ShopService.deleteMerchantData(user.uid);
      await AuthService.deleteCurrentUser();

      if (!mounted) return;
      _goToRoleSelector();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_mapDeleteAccountError(e))),
      );
    } finally {
      if (mounted) {
        setState(() => _isDeletingAccount = false);
      }
    }
  }

  Future<String?> _askPasswordForDeletion() async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var obscure = true;

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocalState) => AlertDialog(
          title: const Text('Confirm Password'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              obscureText: obscure,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setLocalState(() => obscure = !obscure),
                  icon: Icon(
                    obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState?.validate() != true) return;
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );

    controller.dispose();
    return result;
  }

  String _mapDeleteAccountError(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('wrong-password') ||
        message.contains('invalid-credential')) {
      return 'Incorrect password. Please try again.';
    }
    if (message.contains('requires-recent-login')) {
      return 'Please log in again and retry deletion.';
    }
    return 'Unable to delete account right now. Please try again.';
  }

  void _goToRoleSelector() {
    if (!mounted) return;
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  Future<void> _createOrEditShop() async {
    final user = AuthService.currentUser;
    if (user == null) {
      _goToRoleSelector();
      return;
    }

    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ShopProfileManagementScreen(
          merchantId: user.uid,
          existingShop: _currentShop,
        ),
      ),
    );

    if (changed == true) {
      await _loadShop();
    }
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _currentShop == null
                            ? _NoShopState(onCreateShop: _createOrEditShop)
                            : _ShopProfileCard(
                                shop: _currentShop!,
                                onEditShop: _createOrEditShop,
                              ),
                        const SizedBox(height: 20),
                        const _TipsForSuccessSection(),
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
          onPressed: _isDeletingAccount ? null : _deleteAccount,
          icon: _isDeletingAccount
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.delete_forever_rounded, size: 18),
          label: Text(_isDeletingAccount ? 'Deleting...' : 'Delete Account'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
        ),
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
          Text(
            'No Shop Profile Yet',
            style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your shop profile to start reaching students',
            style: tt.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
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
              Text(
                shop.name,
                style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
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
              _InfoRow(label: 'Category', value: shop.category, tt: tt),
              const SizedBox(height: 8),
              _InfoRow(label: 'Price Range', value: shop.priceRange, tt: tt),
              const SizedBox(height: 8),
              _InfoRow(label: 'Location', value: shop.location, tt: tt),
              const SizedBox(height: 8),
              _InfoRow(label: 'Phone', value: shop.phone, tt: tt),
            ],
          ),
        ),
        const SizedBox(height: 16),
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
        ElevatedButton.icon(
          onPressed: onEditShop,
          style: AppTheme.merchantButtonStyle,
          icon: const Icon(Icons.edit_rounded, size: 20),
          label: const Text('Edit Shop Profile & Menu'),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 96,
          child: Text(
            '$label:',
            style: tt.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _TipsForSuccessSection extends StatelessWidget {
  const _TipsForSuccessSection();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tips for Success',
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _TipRow(text: 'Keep your shop description clear and specific.'),
          _TipRow(text: 'Use a real phone number students can contact.'),
          _TipRow(text: 'Add menu items with accurate prices.'),
          _TipRow(text: 'Update details quickly when things change.'),
        ],
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final String text;

  const _TipRow({required this.text});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.check_circle_rounded, size: 16, color: AppTheme.secondary),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: tt.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
