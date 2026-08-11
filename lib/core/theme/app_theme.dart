import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom Material 3 theme for Eats Vancouver.
/// Uses a vibrant, foodie-inspired palette with playful typography.
class AppTheme {
  AppTheme._();

  // ── Palette ──────────────────────────────────────────────────────────────
  static const Color coral = Color(0xFFFF6B6B);
  static const Color coralLight = Color(0xFFFF9E9E);
  static const Color coralDark = Color(0xFFCC4242);

  static const Color sunny = Color(0xFFFFD93D);
  static const Color sunnyLight = Color(0xFFFFEA7F);
  static const Color sunnyDark = Color(0xFFCCAA00);

  static const Color teal = Color(0xFF4ECDC4);
  static const Color tealLight = Color(0xFF80E8E2);
  static const Color tealDark = Color(0xFF2A9D93);

  static const Color cream = Color(0xFFFFF8F0);
  static const Color charcoal = Color(0xFF2D2D2D);
  static const Color softGrey = Color(0xFFF5F0EB);
  static const Color mutedText = Color(0xFF8C7B6E);

  // ── Typography ───────────────────────────────────────────────────────────
  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.light ? charcoal : cream;
    return GoogleFonts.nunitoTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w800,
          color: base,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          color: base,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: base,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: base,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: base,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: base,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: base,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: base,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: base,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: base),
        bodyMedium: TextStyle(fontSize: 14, color: base),
        bodySmall: TextStyle(fontSize: 12, color: mutedText),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: base,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: mutedText,
        ),
      ),
    );
  }

  // ── Color Scheme ─────────────────────────────────────────────────────────
  static ColorScheme get _lightColorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: coral,
    onPrimary: Colors.white,
    primaryContainer: coralLight,
    onPrimaryContainer: coralDark,
    secondary: teal,
    onSecondary: Colors.white,
    secondaryContainer: tealLight,
    onSecondaryContainer: tealDark,
    tertiary: sunny,
    onTertiary: charcoal,
    tertiaryContainer: sunnyLight,
    onTertiaryContainer: sunnyDark,
    error: const Color(0xFFB00020),
    onError: Colors.white,
    errorContainer: const Color(0xFFFFDAD4),
    onErrorContainer: const Color(0xFF410002),
    surface: cream,
    onSurface: charcoal,
    surfaceContainerHighest: softGrey,
    onSurfaceVariant: mutedText,
    outline: const Color(0xFFD4C9BC),
    outlineVariant: const Color(0xFFEDE5DC),
    shadow: const Color(0x33000000),
    scrim: const Color(0x52000000),
    inverseSurface: charcoal,
    onInverseSurface: cream,
    inversePrimary: coralLight,
  );

  // ── Shape ─────────────────────────────────────────────────────────────────
  static final _roundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );
  static final _pillShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50),
  );

  // ── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get light {
    final cs = _lightColorScheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      textTheme: _buildTextTheme(Brightness.light),
      scaffoldBackgroundColor: cream,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: cream,
        foregroundColor: charcoal,
        elevation: 0,
        scrolledUnderElevation: 2,
        shadowColor: cs.shadow,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: charcoal,
        ),
        centerTitle: false,
      ),

      // Cards
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: _roundedShape,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),

      // Chips
      chipTheme: ChipThemeData(
        shape: _pillShape,
        side: BorderSide.none,
        backgroundColor: softGrey,
        selectedColor: coral,
        labelStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: coral,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: _pillShape,
          textStyle: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // FilledButton
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: coral,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: _pillShape,
          textStyle: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Tab Bar
      tabBarTheme: TabBarThemeData(
        labelColor: coral,
        unselectedLabelColor: mutedText,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: coralLight.withAlpha(80),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: softGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: coral, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}

/// Decorative card shadow used on restaurant cards.
List<BoxShadow> get cardShadow => [
  BoxShadow(
    color: const Color(0xFF000000).withAlpha(18),
    blurRadius: 20,
    spreadRadius: 0,
    offset: const Offset(0, 6),
  ),
  BoxShadow(
    color: const Color(0xFF000000).withAlpha(8),
    blurRadius: 6,
    spreadRadius: 0,
    offset: const Offset(0, 2),
  ),
];
