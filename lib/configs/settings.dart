// import 'package:emojis/emojis.dart';
import 'package:flukit/utils/flu_utils.dart';
import 'package:flutter/rendering.dart';

import 'themes.dart';

/// [AppSettings] instance that will be used in
/// the whole app.
AppSettings get settings => AppSettings._();

/// This class contains all app settings.
class AppSettings {
  AppSettings._();

  /// App information's
  String get appName => 'Youtube.';
  String get appVersion => '1.0.0';

  /// Default theme
  Themes get defaultTheme => Themes.blue;

  /// Default pages horizontal padding value
  EdgeInsets get pagePadding =>
      EdgeInsets.symmetric(horizontal: Flu.screenWidth * .065);

  /// Default button size
  double get buttonSize => 70;
  double get buttonCornerRadius => 26;

  /// medium button size
  double get buttonSizeMd => 52;
  double get buttonMdCornerRadius => 20;

  /// Bottom navigation bar dimensions
  double get bottomNavigationBarHeight => Flu.screenHeight * .085;
}
