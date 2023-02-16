import 'package:flukit/screens/base.dart';
import 'package:flutter/material.dart';

import '../configs/settings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FluScreen(
        body: Column(
      children: [Text(settings.appName)],
    ));
  }
}
