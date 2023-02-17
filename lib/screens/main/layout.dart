import 'package:flukit/screens/base.dart';
import 'package:flukit/screens/flu_screens.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutube/configs/settings.dart';

import '../../data/categories.dart';
import 'pages/home.dart';
import 'pages/short.dart';
import 'pages/subscriptions.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _onMainButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    return FluScreenWithBottomNav(
      pages: [
        FluScreenPage(
          icon: FluIcons.home2,
          label: 'home',
          content: const HomeScreen(),
        ),
        FluScreenPage(
          icon: FluIcons.sliderVertical1,
          label: 'shorts',
          content: const ShortsScreen(),
        ),
        FluScreenPage(
          icon: FluIcons.addSquare,
          label: 'Start',
          onNavigateTo: _onMainButtonPressed,
        ),
        FluScreenPage(
          icon: FluIcons.people,
          label: 'subscription\'s',
          content: const SubscriptionsScreen(),
        ),
        FluScreenPage(
          icon: FluIcons.musicLibrary2,
          label: 'library',
          content: const SafeArea(child: Text('hhq')),
        ),
      ],
      bottomNavPadding:
          EdgeInsets.symmetric(horizontal: settings.pagePadding.left * .25),
      bottomNavHeight: settings.bottomNavigationBarHeight,
    );
  }
}
