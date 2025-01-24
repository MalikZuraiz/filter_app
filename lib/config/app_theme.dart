import 'package:flutter/material.dart';
import 'package:filterapp/config/app_colors.dart';
import 'package:filterapp/config/text_theme.dart';

/// Font family string
const String fontFamily = 'ProductSans'; // Updated to ProductSans

/// Styles class holding app theming information
class AppThemes {
  /// Dark theme data of the app
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.darkTextTheme,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.DARK_LOGO_COLOR,
      ),
      scaffoldBackgroundColor: AppColors.DARK_LOGO_COLOR,
      primaryColor: AppColors.DARK_PRIMARY_COLOR,
      colorScheme: const ColorScheme.dark(
          primary: AppColors.DARK_PRIMARY_COLOR,
          onPrimary: AppColors.DARK_WHITE_COLOR,
          secondary: AppColors.DARK_BLUE_COLOR,
          onSecondary: AppColors.DARK_LIGHTEST_BLUE_COLOR,
          surface: AppColors.DARK_GREY,
          onSurface: AppColors.DARK_WHITE_COLOR,
          onSecondaryFixed: AppColors.DARK_BLUE_COLOR,
          inverseSurface: AppColors.WHITE_COLOR,
          tertiaryFixedDim: AppColors.LIGHT_BLACK_COLOR,
          error: AppColors.LIGHT_WHITE_COLOR),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.DARK_PRIMARY_COLOR,
        foregroundColor: AppColors.DARK_WHITE_COLOR,
      ),

      iconTheme: const IconThemeData(
        color: AppColors.DARK_WHITE_COLOR,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.DARK_BLUE_COLOR,
        textTheme: ButtonTextTheme.primary,
      ),
      // Configure Switch Theme for Dark Mode

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.DARK_BLUE_COLOR,
        selectionColor: AppColors.DARK_BLUE_COLOR,
        selectionHandleColor: AppColors.DARK_BLUE_COLOR,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(
            allowEnterRouteSnapshotting: false,
          ),
        },
      ),
    );
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: fontFamily,
      primaryColor: AppColors.LIGHT_PRIMARY_COLOR,
      scaffoldBackgroundColor: AppColors.WHITE_COLOR,
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColors.WHITE_COLOR,
        foregroundColor: AppColors.BLACK_COLOR,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.WHITE_COLOR,
      ),
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.lightTextTheme,
      colorScheme: const ColorScheme.light(
          primary: AppColors.WHITE_COLOR,
          onPrimary: AppColors.BLACK_COLOR,
          secondary: AppColors.BLUE_COLOR,
          onSecondary: AppColors.LIGHTEST_BLUE_COLOR,
          surface: AppColors.WHITE_COLOR, //switch one
          onSurface: AppColors.BLACK_COLOR,
          inverseSurface: AppColors.GREY_COLOR,
          onSecondaryFixed: AppColors.DARK_BLUE_COLOR,
          tertiaryFixedDim: AppColors.LIGHT_WHITE_COLOR,
          error: AppColors.LIGHT_WHITE_COLOR),
      iconTheme: const IconThemeData(
        color: AppColors.BLACK_COLOR,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.BLUE_COLOR,
        textTheme: ButtonTextTheme.primary,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.DARK_BLUE_COLOR,
        selectionColor: AppColors.DARK_BLUE_COLOR,
        selectionHandleColor: AppColors.DARK_BLUE_COLOR,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(
            allowEnterRouteSnapshotting: false,
          ),
        },
      ),
    );
  }
}
