import 'package:flutter/material.dart';

class AppColors {
  // Gradients for backgrounds
  static const Color green50 = Color(0xFFE8F5E9); // Light green
  static const Color teal50 = Color(0xFFE0F2F7); // Light teal
  static const Color blueGrey50 = Color(0xFFECEFF1); // Light blue-grey

  // Primary/Accent Colors (Green/Teal theme)
  static const Color green600 = Color(0xFF43A047); // Primary green
  static const Color green800 = Color(0xFF2E7D32); // Darker green
  static const Color teal600 = Color(0xFF00897B); // Primary teal
  static const Color teal800 = Color(0xFF00695C); // Darker teal
  static const Color blue600 = Color(0xFF1E88E5); // Complementary blue
  static const Color purple600 = Color(0xFF8E24AA); // Complementary purple

  // Success/Error Colors
  static const Color red50 = Color(0xFFFDE8E8);
  static const Color red100 = Color(0xFFF8BBD0);
  static const Color red200 = Color(0xFFEF9A9A);
  static const Color red500 = Color(0xFFF44336);
  static const Color red600 = Color(0xFFE53935);
  static const Color red700 = Color(0xFFD32F2F);
  static const Color red800 = Color(0xFFC62828);

  // Neutral/Text Colors
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);

  // Specific UI colors (for gradients, etc.)
  static const Color backgroundGradientStart =
      Color(0xFFE8F5E9); // Light green for background start
  static const Color backgroundGradientEnd =
      Color(0xFFE0F2F7); // Light teal for background end
  static const Color green100 = Color(0xFFC8E6C9); // Lighter green
  static const Color blue100 = Color(0xFFBBDEFB); // Lighter blue
  static const Color purple100 = Color(0xFFE1BEE7); // Lighter purple
  static const Color blue200 = Color(0xFF90CAF9); // Medium blue

  // FIX: Added missing blueGrey800 color
  static const Color blueGrey800 = Color(0xFF37474F);
}
