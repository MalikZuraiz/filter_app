import 'package:flutter/material.dart';
import 'app_text_style.dart';

class TextThemes {
  /// Main text theme
  static TextTheme get textTheme {
    return const TextTheme(
      labelLarge: AppTextStyles.labelLargeMedium, // 18pt Medium Poppins
      labelMedium: AppTextStyles.labelMediumRegular, // 15pt Regular Poppins
      labelSmall: AppTextStyles.labelSmallRegular, // 13pt Regular Poppins
      titleLarge: AppTextStyles.extraTitleLarge,
      titleMedium: AppTextStyles.dinNextMedium,
      bodySmall: AppTextStyles.labelExtraSmallLight,
      displaySmall: AppTextStyles.labelSmallMedium,
    );
  }

  /// Dark text theme
  static TextTheme get darkTextTheme {
    return const TextTheme(
      labelLarge: AppTextStyles.labelLargeMedium, // 18pt Medium Poppins
      labelMedium: AppTextStyles.labelMediumRegular, // 15pt Regular Poppins
      labelSmall: AppTextStyles.labelSmallRegular, // 13pt Regular Poppins
      titleLarge: AppTextStyles.extraTitleLarge,
      titleMedium: AppTextStyles.dinNextMedium,
      bodySmall: AppTextStyles.labelExtraSmallLight,
      displaySmall: AppTextStyles.labelSmallMedium,
    );
  }

  /// Light text theme
  static TextTheme get lightTextTheme {
    return const TextTheme(
      labelLarge: AppTextStyles.labelLargeMedium, // 18pt Medium Poppins
      labelMedium: AppTextStyles.labelMediumRegular, // 15pt Regular Poppins
      labelSmall: AppTextStyles.labelSmallRegular, // 13pt Regular Poppins
      titleLarge: AppTextStyles.extraTitleLarge,
      titleMedium: AppTextStyles.dinNextMedium,
      bodySmall: AppTextStyles.labelExtraSmallLight,
      displaySmall: AppTextStyles.labelSmallMedium,
    );
  }
}
