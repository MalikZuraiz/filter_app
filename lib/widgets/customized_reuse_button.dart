import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:filterapp/config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double borderWidth; // Parameter for border width
  final Color? backgroundColor; // Optional parameter for background color
  final double width; // Parameter for button width with a default value

  // Default width set to 200 (or whatever your default width was before)
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderWidth = 0.0, // Default border width
    this.backgroundColor, // Default is null, meaning no custom background color
    this.width = 500.0, // Default width value
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60, // Fixed height
        width: width, // Use provided width or default value
        padding:
            const EdgeInsets.symmetric(horizontal: 40), // Horizontal padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ??
                    AppColors.WHITE_COLOR
                        .withOpacity(0.3), // Use custom color if provided
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.WHITE_COLOR.withOpacity(0.8),
                  width: borderWidth, // Set the border width here
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.WHITE_COLOR,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
