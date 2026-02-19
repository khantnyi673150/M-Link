import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ── Brand Colors ──────────────────────────────────────────────
  // Primary: Blue (student-facing — logo, prices, nav, CTA)
  static const Color primary = Color(0xFF2563EB);         // Blue 600
  static const Color primaryLight = Color(0xFF3B82F6);    // Blue 500
  static const Color primaryDark = Color(0xFF1D4ED8);     // Blue 700
  static const Color primaryContainer = Color(0xFFDBEAFE); // Blue 100
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary: Green (merchant-facing — merchant buttons, merchant portal)
  static const Color secondary = Color(0xFF16A34A);       // Green 600
  static const Color secondaryLight = Color(0xFF22C55E);  // Green 500
  static const Color secondaryDark = Color(0xFF15803D);   // Green 700
  static const Color secondaryContainer = Color(0xFFDCFCE7); // Green 100
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Semantic
  static const Color error = Color(0xFFDC2626);           // Red 600
  static const Color onError = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFF59E0B);         // Amber 500
  static const Color success = Color(0xFF16A34A);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF8FAFC);      // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);  // Slate 100
  static const Color onBackground = Color(0xFF0F172A);    // Slate 900
  static const Color onSurface = Color(0xFF0F172A);       // Slate 900
  static const Color onSurfaceVariant = Color(0xFF64748B); // Slate 500
  static const Color outline = Color(0xFFE2E8F0);         // Slate 200

  // Icon circle tints (used in category cards, role cards)
  static const Color iconCircleBlue = Color(0xFFDBEAFE);  // Blue 100
  static const Color iconCircleGreen = Color(0xFFDCFCE7); // Green 100

  // ── Spacing (16px base philosophy) ────────────────────────────
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  // ── Shape (12px border radius) ─────────────────────────────────
  static const double borderRadius = 12.0;
  static const double borderRadiusLG = 20.0;   // role-selector / main cards
  static const double borderRadiusSM = 8.0;    // chips, small elements
  static const BorderRadius cardBorderRadius =
      BorderRadius.all(Radius.circular(borderRadius));
  static const BorderRadius buttonBorderRadius =
      BorderRadius.all(Radius.circular(borderRadius));
  static const BorderRadius largeBorderRadius =
      BorderRadius.all(Radius.circular(borderRadiusLG));

  // ── Light Theme ────────────────────────────────────────────────
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: primaryDark,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: secondaryDark,
      error: error,
      onError: onError,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      outline: outline,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,

      // ── Typography ──────────────────────────────────────────────
      // Clean sans-serif: dark navy headings, grey subtitles
      textTheme: const TextTheme(
        // Display
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: onBackground,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: onBackground,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: onBackground,
          letterSpacing: 0,
          height: 1.22,
        ),
        // Headline — bold navy (Browse Categories, Campus Cafe, etc.)
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: onBackground,
          letterSpacing: -0.5,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: onBackground,
          letterSpacing: -0.25,
          height: 1.29,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: onBackground,
          letterSpacing: 0,
          height: 1.33,
        ),
        // Title
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: onBackground,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: onBackground,
          letterSpacing: 0,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: onBackground,
          letterSpacing: 0,
          height: 1.43,
        ),
        // Body
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant,
          letterSpacing: 0.1,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        // Label
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: onBackground,
          letterSpacing: 0,
          height: 1.43,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onSurfaceVariant,
          letterSpacing: 0.25,
          height: 1.33,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: onSurfaceVariant,
          letterSpacing: 0.25,
          height: 1.45,
        ),
      ),

      // ── AppBar ──────────────────────────────────────────────────
      // White bar with blue brand text / logo (as in screenshots)
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: primary,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(color: onBackground),
        titleTextStyle: TextStyle(
          color: primary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),

      // ── Cards ──────────────────────────────────────────────────
      // White cards, subtle shadow, 12px radius
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shadowColor: Color(0x1A0F172A),
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: spaceSM,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: cardBorderRadius,
          side: BorderSide(color: outline, width: 1),
        ),
      ),

      // ── ElevatedButton ─────────────────────────────────────────
      // Blue filled pill button (Get Directions, etc.)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLG,
            vertical: spaceMD,
          ),
          shape: const RoundedRectangleBorder(borderRadius: buttonBorderRadius),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // ── OutlinedButton ─────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLG,
            vertical: spaceMD,
          ),
          side: const BorderSide(color: primary, width: 1.5),
          shape: const RoundedRectangleBorder(borderRadius: buttonBorderRadius),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // ── TextButton ─────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceMD,
            vertical: spaceSM,
          ),
          shape: const RoundedRectangleBorder(borderRadius: buttonBorderRadius),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),

      // ── InputDecoration ────────────────────────────────────────
      // Light grey filled fields, rounded, blue focus border
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMD,
          vertical: spaceMD,
        ),
        border: OutlineInputBorder(
          borderRadius: cardBorderRadius,
          borderSide: const BorderSide(color: outline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: cardBorderRadius,
          borderSide: const BorderSide(color: outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: cardBorderRadius,
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: cardBorderRadius,
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: cardBorderRadius,
          borderSide: const BorderSide(color: error, width: 2),
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant,
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurfaceVariant,
        ),
        prefixIconColor: onSurfaceVariant,
      ),

      // ── Chip ───────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: primaryContainer,
        selectedColor: primary,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: primaryDark,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceSM,
          vertical: spaceXS,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusSM)),
        ),
      ),

      // ── Divider ────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: outline,
        thickness: 1,
        space: spaceMD,
      ),

      // ── ListTile ───────────────────────────────────────────────
      // Used in Contact & Order section rows
      listTileTheme: const ListTileThemeData(
        tileColor: surfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
        contentPadding: EdgeInsets.symmetric(
          horizontal: spaceMD,
          vertical: spaceXS,
        ),
        titleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: onBackground,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant,
        ),
        iconColor: primary,
      ),

      // ── SnackBar ───────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: onBackground,
        contentTextStyle: const TextStyle(
          color: surface,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        shape: const RoundedRectangleBorder(borderRadius: cardBorderRadius),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
    );
  }

  // ── Merchant Green Button Style ────────────────────────────────
  // Used explicitly on merchant screens (Create/Edit Shop Profile, Login)
  static ButtonStyle get merchantButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: onSecondary,
        minimumSize: const Size.fromHeight(52),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceLG,
          vertical: spaceMD,
        ),
        shape: const RoundedRectangleBorder(borderRadius: buttonBorderRadius),
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      );
}
