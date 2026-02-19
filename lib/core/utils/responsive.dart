import 'package:flutter/material.dart';

/// Responsive utility for adaptive layouts across different screen sizes
class Responsive {
  /// Screen breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  /// Check if screen is mobile size
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  /// Check if screen is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Check if screen is desktop size
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  /// Get screen width
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Get screen height
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Get responsive value based on screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    return mobile;
  }

  /// Get grid crossAxisCount based on screen width
  static int gridCrossAxisCount(
    BuildContext context, {
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    return value(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get max content width for better readability on large screens
  static double maxContentWidth(BuildContext context) {
    return value(
      context,
      mobile: double.infinity,
      tablet: 800,
      desktop: 1200,
    );
  }

  /// Get horizontal padding based on screen size
  static double horizontalPadding(BuildContext context) {
    return value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
  }

  /// Get vertical padding based on screen size
  static double verticalPadding(BuildContext context) {
    return value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
  }

  /// Scale font size based on screen width
  static double scaledFontSize(BuildContext context, double size) {
    final screenWidth = width(context);
    if (screenWidth > tabletBreakpoint) {
      return size * 1.1; // Slightly larger on desktop
    }
    return size;
  }

  /// Get child aspect ratio for grid items
  static double gridChildAspectRatio(BuildContext context) {
    return value(
      context,
      mobile: 1.4,
      tablet: 1.2,
      desktop: 1.3,
    );
  }
}

/// Widget wrapper for responsive content with max width constraint
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? Responsive.maxContentWidth(context),
        ),
        child: child,
      ),
    );
  }
}

/// Responsive padding widget
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobile;
  final EdgeInsets? tablet;
  final EdgeInsets? desktop;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.value(
      context,
      mobile: mobile ?? const EdgeInsets.all(16),
      tablet: tablet ?? const EdgeInsets.all(24),
      desktop: desktop ?? const EdgeInsets.all(32),
    );

    return Padding(
      padding: padding,
      child: child,
    );
  }
}
