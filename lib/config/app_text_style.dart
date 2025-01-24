import 'package:flutter/material.dart';

class AppTextStyles {
  // 13pt Regular ProductSans
  static const TextStyle labelSmallRegular = TextStyle(
    fontSize: 13,
    fontFamily: 'ProductSans',
    fontWeight: FontWeight.w400, // Regular
  );

  static const TextStyle labelSmallMedium = TextStyle(
    fontSize: 13,
    fontFamily: 'ProductSans',
    fontWeight: FontWeight.w500, // Medium
  );

  // 15pt Regular ProductSans
  static const TextStyle labelMediumRegular = TextStyle(
    fontSize: 15,
    fontFamily: 'ProductSans',
    fontWeight: FontWeight.w400, // Regular
  );

  // 18pt Medium ProductSans
  static const TextStyle labelLargeMedium = TextStyle(
    fontSize: 18,
    fontFamily: 'ProductSans',
    fontWeight: FontWeight.w500, // Medium
  );

  // Medium text with DINNextLTPro font
  static const TextStyle dinNextMedium = TextStyle(
    fontSize: 12,
    fontFamily: 'DINNextLTPro',
    fontWeight: FontWeight.w500, // Medium
  );

  // Extra Large Title with Altoysitalicpersonalonly font
  static const TextStyle extraTitleLarge = TextStyle(
    fontSize: 45,
    fontFamily: 'Altoysitalicpersonalonly',
    fontStyle: FontStyle.italic, // Italic
  );

  // 10pt Light ProductSans
  static const TextStyle labelExtraSmallLight = TextStyle(
    fontSize: 11,
    fontFamily: 'ProductSans',
    fontWeight: FontWeight.w300, // Light
    color: Color(0xFF858585), // Light gray color for subtle text
  );
}
