import 'package:flutter/material.dart';

/// Asset path constants for easy reference throughout the app
/// 
/// Note: The app currently uses Material Icons (built-in) for all UI icons.
/// Material Icons are perfect for the app and require no additional assets.
/// 
/// For shop photos, the app uses network images (Unsplash URLs).
/// This approach means you don't need local image files.
/// 
/// If you want to add local assets:
/// - Place image files in assets/images/ folders
/// - Uncomment and use the constants below
/// - Restart the app after adding new images
class AssetPaths {
  // ── Logo & Branding (optional - currently using icon + text) ────
  // static const String logo = 'assets/images/logo.png';
  // static const String logoWhite = 'assets/images/logo_white.png';

  // ── Default/Placeholder Images (optional) ───────────────────────
  // static const String defaultShop = 'assets/images/default_shop.png';
  // static const String defaultAvatar = 'assets/images/default_avatar.png';
  // static const String noImage = 'assets/images/no_image.png';

  // ── Category Icons (optional - currently using Material Icons) ──
  // static const String categoryFood = 'assets/images/categories/food.png';
  // static const String categoryCoffee = 'assets/images/categories/coffee.png';
  // static const String categoryStationary = 'assets/images/categories/stationary.png';
  // static const String categoryServices = 'assets/images/categories/services.png';
  // static const String categoryFashion = 'assets/images/categories/fashion.png';
  // static const String categoryTech = 'assets/images/categories/tech.png';
  // static const String categoryHealth = 'assets/images/categories/health.png';
  // static const String categoryEntertainment = 'assets/images/categories/entertainment.png';
}

/// Helper widget for displaying images with loading and error states
/// Currently used for shop photos which are loaded from Unsplash URLs
class ImageHelper {
  /// Create a placeholder container for missing/loading images
  static Widget placeholder({
    double? width,
    double? height,
    IconData icon = Icons.image_outlined,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF5F7FA),
            const Color(0xFFE8ECF1),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: (width != null && height != null) 
              ? (width < height ? width : height) * 0.3 
              : 48,
          color: const Color(0xFFBDC3C7),
        ),
      ),
    );
  }

  /// Load network image with placeholder and error handling
  /// 
  /// Usage:
  /// ```dart
  /// ImageHelper.network('https://example.com/image.jpg')
  /// ```
  static Widget network(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: const Color(0xFFF5F5F5),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: const Color(0xFFE0E0E0),
          child: const Icon(Icons.broken_image, color: Color(0xFF9E9E9E)),
        );
      },
    );
  }
}
