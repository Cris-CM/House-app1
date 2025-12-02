import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'palette.dart';

class AppTheme {
  static ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: Palette.primary,
    brightness: Brightness.light,
    surface: Colors.white,
    onSurface: Colors.black,
    secondary: Palette.secondary,
    primary: Palette.primary,
  );

  static final TextTheme _textTheme = GoogleFonts.interTextTheme();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightScheme,
      textTheme: _textTheme,
      scaffoldBackgroundColor: lightScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: lightScheme.primary,
        foregroundColor: lightScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: lightScheme.surface,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      iconTheme: IconThemeData(color: lightScheme.onSurface),
    );
  }
}
