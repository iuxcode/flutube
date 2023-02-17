import 'package:flukit/screens/base.dart';
import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/image.dart';
import 'package:flukit/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutube/configs/routes.dart';
import 'package:flutube/configs/themes.dart';

import '../configs/settings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 6),
        () => router.replace(Routes.main,
            clearHistory: true)); // Delayed to six seconds to simulate loading.
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);
    final backgroundColor = colorScheme.primary;
    final foregroundColor = colorScheme.onPrimary;

    return FluScreen(
      overlayStyle: Flu.getDefaultSystemUiOverlayStyle(context).copyWith(
          statusBarColor: backgroundColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: backgroundColor,
          systemNavigationBarIconBrightness: Brightness.light),
      background: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: FluImage.svg('assets/logo.svg',
                  height: Flu.screenHeight * .15,
                  width: Flu.screenHeight * .15),
            )),
            FluLoader(
                color: foregroundColor,
                margin: EdgeInsets.only(bottom: Flu.screenHeight * .075)),
            Text(
              settings.appName.toUpperCase(),
              style: Flu.getTextThemeOf(context).titleMedium?.copyWith(
                  color: foregroundColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: Flu.screenHeight * .15),
          ],
        ),
      ),
    );
  }
}
