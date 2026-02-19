import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../home/home_screen.dart';
import 'merchant_login_screen.dart';

class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF), // very light blue tint
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Logo & Brand ────────────────────────────────────
                _MLinkLogo(),
                const SizedBox(height: 48),

                // ── Student Card ────────────────────────────────────
                _RoleCard(
                  title: "I'm a Student",
                  subtitle: 'Browse local services and shops',
                  icon: Icons.school_rounded,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.iconCircleBlue,
                  onTap: () {
                    debugPrint('Student selected');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // ── Merchant Card ───────────────────────────────────
                _RoleCard(
                  title: "I'm a Merchant",
                  subtitle: 'Manage your shop profile',
                  icon: Icons.storefront_rounded,
                  iconColor: AppTheme.secondary,
                  iconBgColor: AppTheme.iconCircleGreen,
                  onTap: () {
                    debugPrint('Merchant selected');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MerchantLoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── M-Link logo block ─────────────────────────────────────────────
class _MLinkLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon + wordmark row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Blue rounded-square icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.link_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'M-Link',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: AppTheme.primary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Tagline
        Text(
          'Connecting Campus Communities',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.onSurfaceVariant,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

// ── Role selection card ───────────────────────────────────────────
class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusLG),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLG),
        splashColor: iconBgColor,
        highlightColor: iconBgColor.withValues(alpha: 0.4),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusLG),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Icon circle
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 32),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                title,
                style: tt.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onBackground,
                ),
              ),
              const SizedBox(height: 6),

              // Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: tt.bodyMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
