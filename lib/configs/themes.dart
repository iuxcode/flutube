import 'package:flukit/utils/flu_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'settings.dart';

/// [ThemeManager] instance that will be used in
/// the whole app.
const ThemeManager themeManager = ThemeManager._();

/// Manage theming operations across the app
class ThemeManager {
  const ThemeManager._();

  void changeThemeMode() => Flu.changeThemeMode();

  /* void changeTheme(Themes theme) =>
      Flu.changeTheme(Get.isDarkMode ? lightTheme : theme.light); */

  ThemeData get lightTheme {
    return _buildTheme(
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.defaultTheme.colorSchemeSeed,
          brightness: Brightness.light,
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return _buildTheme(
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.defaultTheme.colorSchemeSeed,
          brightness: Brightness.dark,
        ),
      ),
    );
  }

  /// Build a theme with common styles
  ThemeData _buildTheme(ThemeData themeData) {
    return themeData.copyWith(
      textTheme:
          GoogleFonts.spaceGroteskTextTheme(themeData.textTheme).copyWith(
        headlineLarge:
            _basicHeadlineTextStyle(themeData.textTheme.headlineLarge),
        headlineMedium:
            _basicHeadlineTextStyle(themeData.textTheme.headlineMedium),
        headlineSmall:
            _basicHeadlineTextStyle(themeData.textTheme.headlineSmall),
        titleLarge: _basicTextStyle(themeData.textTheme.titleLarge),
        titleMedium: _basicTextStyle(themeData.textTheme.titleMedium),
        titleSmall: _basicTextStyle(themeData.textTheme.titleSmall),
      ),
    );
  }

  /// Define the [TextStyle] of headlines.
  /// [textStyle] define the style to merge with.
  TextStyle _basicHeadlineTextStyle(TextStyle? textStyle) =>
      GoogleFonts.lexend(textStyle: textStyle, fontWeight: FontWeight.bold);

  /// Define the [TextStyle] of headlines.
  /// [textStyle] define the style to merge with.
  TextStyle _basicTextStyle(TextStyle? textStyle) => GoogleFonts.spaceGrotesk(
      textStyle: textStyle, fontWeight: FontWeight.w600);
}

/// App themes
enum Themes { blue }

extension E on Themes {
  /// Define the seed color for a theme [ColorScheme]
  Color get colorSchemeSeed {
    switch (this) {
      case Themes.blue:
        return const Color(0xFFFF0000);
    }
  }
}
