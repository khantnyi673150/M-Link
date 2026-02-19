import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../merchant_dashboard/merchant_dashboard_screen.dart';
import 'widgets/auth_text_field.dart';

class MerchantLoginScreen extends StatefulWidget {
  const MerchantLoginScreen({super.key});

  @override
  State<MerchantLoginScreen> createState() => _MerchantLoginScreenState();
}

class _MerchantLoginScreenState extends State<MerchantLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool _isLoginMode = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _switchMode(bool toLogin) {
    if (_isLoginMode == toLogin) return;
    setState(() {
      _isLoginMode = toLogin;
      _formKey.currentState?.reset();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: Replace with real auth service call
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isLoading = false);
    if (!mounted) return;

    // Navigate to MerchantDashboardScreen
    // Pass null for new merchants (no shop yet) or a Shop object for existing merchants
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MerchantDashboardScreen(initialShop: null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final horizontalPadding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: Responsive.verticalPadding(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              // ── Header ───────────────────────────────────────────
              _PortalHeader(tt: tt),
              const SizedBox(height: 28),

              // ── Login / Register toggle ──────────────────────────
              _ModeToggle(
                isLoginMode: _isLoginMode,
                onSwitch: _switchMode,
              ),
              const SizedBox(height: 24),

              // ── Form card ────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  border: Border.all(color: AppTheme.outline),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email
                      AuthTextField(
                        label: 'Email',
                        hint: 'merchant@example.com',
                        prefixIcon: Icons.mail_outline_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passwordFocusNode),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password
                      AuthTextField(
                        label: 'Password',
                        hint: '••••••••',
                        prefixIcon: Icons.lock_outline_rounded,
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        isPassword: true,
                        textInputAction: _isLoginMode
                            ? TextInputAction.done
                            : TextInputAction.next,
                        onEditingComplete: _isLoginMode ? _submit : null,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Password is required';
                          if (v.length < 6) return 'Minimum 6 characters';
                          return null;
                        },
                      ),

                      // Confirm Password (Register only)
                      if (!_isLoginMode) ...[
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: 'Confirm Password',
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline_rounded,
                          controller: _confirmPasswordController,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _submit,
                          validator: (v) {
                            if (v != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Submit button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: AppTheme.merchantButtonStyle,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(_isLoginMode ? 'Login' : 'Register'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Demo info banner ─────────────────────────────────
              _DemoBanner(isLoginMode: _isLoginMode, tt: tt),
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
      scrolledUnderElevation: 0,
      leading: TextButton.icon(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
        label: const Text('Back'),
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.onBackground,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      leadingWidth: 90,
      actions: [
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
                child: const Icon(Icons.link_rounded, color: Colors.white, size: 18),
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

// ── Header: icon + title + subtitle ──────────────────────────────
class _PortalHeader extends StatelessWidget {
  final TextTheme tt;
  const _PortalHeader({required this.tt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: AppTheme.iconCircleGreen,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.storefront_rounded,
            color: AppTheme.secondary,
            size: 36,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Merchant Portal',
          style: tt.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppTheme.onBackground,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Manage your shop profile',
          style: tt.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

// ── Login / Register segmented toggle ────────────────────────────
class _ModeToggle extends StatelessWidget {
  final bool isLoginMode;
  final void Function(bool) onSwitch;

  const _ModeToggle({required this.isLoginMode, required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: AppTheme.outline),
      ),
      child: Row(
        children: [
          Expanded(child: _ToggleTab(label: 'Login', active: isLoginMode, onTap: () => onSwitch(true))),
          Expanded(child: _ToggleTab(label: 'Register', active: !isLoginMode, onTap: () => onSwitch(false))),
        ],
      ),
    );
  }
}

class _ToggleTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _ToggleTab({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: active ? AppTheme.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.borderRadius - 1),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

// ── Demo info banner ──────────────────────────────────────────────
class _DemoBanner extends StatelessWidget {
  final bool isLoginMode;
  final TextTheme tt;

  const _DemoBanner({required this.isLoginMode, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.iconCircleGreen,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: RichText(
        text: TextSpan(
          style: tt.bodySmall?.copyWith(color: AppTheme.secondaryDark),
          children: [
            const TextSpan(
              text: 'Demo: ',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: isLoginMode
                  ? 'Use any registered email and password to log in.'
                  : 'Register with any email and password to create a merchant account.',
            ),
          ],
        ),
      ),
    );
  }
}
