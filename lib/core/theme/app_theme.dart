import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ---- Current Active Theme Variables (Used universally by components) ----
  static Color background = const Color(0xFFFFFFFF);
  static Color foreground = const Color(0xFF030712);
  static Color card = const Color(0xFFFFFFFF);
  static Color cardForeground = const Color(0xFF030712);
  static Color popover = const Color(0xFFFFFFFF);
  static Color popoverForeground = const Color(0xFF030712);
  static Color primary = const Color(0xFF7C3AED);
  static Color primaryForeground = const Color(0xFFFAFAFA);
  static Color secondary = const Color(0xFFF1F5F9);
  static Color secondaryForeground = const Color(0xFF0F172A);
  static Color muted = const Color(0xFFF1F5F9);
  static Color mutedForeground = const Color(0xFF64748B);
  static Color accent = const Color(0xFFF1F5F9);
  static Color accentForeground = const Color(0xFF0F172A);
  static Color destructive = const Color(0xFFEF4444);
  static Color destructiveForeground = const Color(0xFFFAFAFA);
  static Color border = const Color(0xFFE2E8F0);
  static Color input = const Color(0xFFE2E8F0);
  static Color ring = const Color(0xFF7C3AED);

  static const double borderRadius = 24.0;

  // ---- Light Theme Constants ----
  static const Color lightBackground = Color(0xFFF4F7FB);
  static const Color lightForeground = Color(0xFF030712);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardForeground = Color(0xFF030712);
  static const Color lightPrimary = Color(0xFF7C3AED);
  static const Color lightPrimaryForeground = Color(0xFFFAFAFA);
  static const Color lightSecondary = Color(0xFFF1F5F9);
  static const Color lightSecondaryForeground = Color(0xFF0F172A);
  static const Color lightMuted = Color(0xFFF1F5F9);
  static const Color lightMutedForeground = Color(0xFF64748B);
  static const Color lightDestructive = Color(0xFFEF4444);
  static const Color lightDestructiveForeground = Color(0xFFFAFAFA);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightRing = Color(0xFF7C3AED);

  // ---- Dark Theme Constants ----
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkForeground = Color(0xFFFAFAFA);
  static const Color darkCard = Color(0xFF030712);
  static const Color darkPrimary = Color(0xFF7C3AED);
  static const Color darkPrimaryForeground = Color(0xFFFAFAFA);
  static const Color darkSecondary = Color(0xFF1E293B);
  static const Color darkSecondaryForeground = Color(0xFFF8FAFC);
  static const Color darkMuted = Color(0xFF1E293B);
  static const Color darkMutedForeground = Color(0xFF94A3B8);
  static const Color darkDestructive = Color(0xFF991B1B);
  static const Color darkDestructiveForeground = Color(0xFFFAFAFA);
  static const Color darkBorder = Color(0xFF1E293B);
  static const Color darkRing = Color(0xFF7C3AED);

  // Switch Theme Action
  static void applyTheme(ThemeMode mode) {
    bool isDark = mode == ThemeMode.dark;
    background = isDark ? darkBackground : lightBackground;
    foreground = isDark ? darkForeground : lightForeground;
    card = isDark ? darkCard : lightCard;
    cardForeground = isDark ? darkForeground : lightCardForeground;
    popover = isDark ? darkBackground : lightBackground;
    popoverForeground = isDark ? darkForeground : lightForeground;
    primary = isDark ? darkPrimary : lightPrimary;
    primaryForeground = isDark ? darkPrimaryForeground : lightPrimaryForeground;
    secondary = isDark ? darkSecondary : lightSecondary;
    secondaryForeground = isDark ? darkSecondaryForeground : lightSecondaryForeground;
    muted = isDark ? darkMuted : lightMuted;
    mutedForeground = isDark ? darkMutedForeground : lightMutedForeground;
    accent = isDark ? darkSecondary : lightSecondary;
    accentForeground = isDark ? darkSecondaryForeground : lightSecondaryForeground;
    destructive = isDark ? darkDestructive : lightDestructive;
    destructiveForeground = isDark ? darkDestructiveForeground : lightDestructiveForeground;
    border = isDark ? darkBorder : lightBorder;
    input = isDark ? darkBorder : lightBorder;
    ring = isDark ? darkRing : lightRing;
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: lightPrimary,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        onPrimary: lightPrimaryForeground,
        secondary: lightSecondary,
        onSecondary: lightSecondaryForeground,
        error: lightDestructive,
        onError: lightDestructiveForeground,
        surface: lightBackground,
        onSurface: lightForeground,
      ),
      textTheme: _buildTextTheme(lightForeground, lightMutedForeground),
      appBarTheme: _buildAppBarTheme(lightBackground, lightForeground),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: darkPrimary,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        onPrimary: darkPrimaryForeground,
        secondary: darkSecondary,
        onSecondary: darkSecondaryForeground,
        error: darkDestructive,
        onError: darkDestructiveForeground,
        surface: darkBackground,
        onSurface: darkForeground,
      ),
      textTheme: _buildTextTheme(darkForeground, darkMutedForeground),
      appBarTheme: _buildAppBarTheme(darkBackground, darkForeground),
    );
  }

  static TextTheme _buildTextTheme(Color fg, Color mutedFg) {
    return GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(color: fg, fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -1.0),
      headlineMedium: GoogleFonts.inter(color: fg, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
      titleLarge: GoogleFonts.inter(color: fg, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.2),
      titleMedium: GoogleFonts.inter(color: fg, fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.inter(color: fg, fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.inter(color: mutedFg, fontSize: 14, fontWeight: FontWeight.w400),
      labelLarge: GoogleFonts.inter(color: fg, fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  static AppBarTheme _buildAppBarTheme(Color bg, Color fg) {
    return AppBarTheme(
      backgroundColor: bg,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: fg),
      titleTextStyle: GoogleFonts.inter(color: fg, fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
