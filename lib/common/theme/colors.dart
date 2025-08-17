import 'package:flutter/material.dart';

class AppColors {
  // App theme colors
  static const Color primary = Color(0xFF0362de);
  static const Color secondary = Color(0xF031C9E);
  static const Color accent = Color(0xFF83E3F9);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color darkgrey = Color(0xFF64748B);
  static const Color textWhite = Colors.white;
  static const Color textDarkBlue = Color(0xFF112D4E);

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color xlight = Color(0xE9DDDD);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFD32F2F);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  static const Color sbuttomColor = Color(0xff112D4E); //
  static const Color sprimary = Color(0xFF0362DE);
  static const Color ssecondery = Color(0xFF031C9E);
  static const Color saccent = Color(0xFF83E3F9);

  // Almost white

  // Gradient Colors
  static const Color gradientStart = Color(0xFF4baefa); // Darker blue
  static const Color middleColor = Color(0xFF8eccfc); // Lighter blue
  static const Color gradientend = Color.fromARGB(255, 251, 251, 251);
}
