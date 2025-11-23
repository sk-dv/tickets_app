import 'package:flutter/material.dart';
import 'package:tickets_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'SF Pro',
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryPastel,
        secondary: AppColors.primaryLight,
        surface: AppColors.white,
      ),
    );
  }

  static TextStyle get mono => const TextStyle(fontFamily: 'SF Mono');
}