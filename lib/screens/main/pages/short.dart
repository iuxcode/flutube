import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/avatar.dart';
import 'package:flukit/widgets/badge.dart';
import 'package:flukit/widgets/button.dart';
import 'package:flukit/widgets/divider.dart';
import 'package:flukit/widgets/glass.dart';
import 'package:flukit/widgets/image.dart';
import 'package:flukit/widgets/tabs.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flukit_icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutube/configs/themes.dart';

import '../../../configs/settings.dart';
import '../../../data/videos.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> barAnimation;
  late final PageController pageController;
  late final TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    pageController = PageController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    barAnimation = Tween<double>(begin: 0, end: Flu.screenWidth)
        .animate(animationController);
    animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.decelerate);
        }
      })
      ..forward();
    super.initState();
  }

  Widget _actionArea(List<Widget> children) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return Container(
      width: 52,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: themeManager.lightTheme.colorScheme.surfaceVariant,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _icon(FluIcons icon, String text, {Color? color}) => Column(
        children: [
          FluIcon(
            icon,
            style: FluIconStyles.bulk,
            color:
                color ?? themeManager.lightTheme.colorScheme.onSurfaceVariant,
            margin: const EdgeInsets.only(bottom: 3),
          ),
          Text(
            text,
            style: Flu.getTextThemeOf(context).bodySmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color ??
                    themeManager.lightTheme.colorScheme.onSurfaceVariant),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return AnnotatedRegion(
      value: Flu.getDefaultSystemUiOverlayStyle(context).copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              animationController
                ..reset()
                ..forward();
            },
            itemCount: shorts.length,
            itemBuilder: (context, index) {
              final short = shorts[index];

              return Stack(
                children: [
                  FluImage(
                    short.thumbnail,
                    expand: true,
                    overlayOpacity: .85,
                    gradientOverlay: true,
                    gradientOverlayBegin: Alignment.topLeft,
                    gradientOverlayEnd: Alignment.bottomRight,
                  ),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: settings.pagePadding.copyWith(bottom: 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const FluAvatar(
                                          size: 35,
                                          cornerRadius: 10,
                                          margin: EdgeInsets.only(right: 8),
                                          defaultAvatarType:
                                              FluAvatarTypes.memojis,
                                        ),
                                        Text(
                                          short.publisher,
                                          style: Flu.getTextThemeOf(context)
                                              .titleLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    5.ph,
                                    const Text(
                                      'Vitae et inventore laboriosam quis a et quia. Optio est dignissimos et rerum possimus quia fuga.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _actionArea([
                                    _icon(
                                      FluIcons.like1,
                                      '150',
                                      color: themeManager
                                          .lightTheme.colorScheme.primary,
                                    ),
                                    FluLine(
                                      height: 1,
                                      width: 15,
                                      color: colorScheme.onSurfaceVariant,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                    ),
                                    _icon(FluIcons.dislike, '2'),
                                  ]),
                                  _actionArea(
                                      [_icon(FluIcons.messages2, '12k')]),
                                  _actionArea([_icon(FluIcons.send2, 'share')]),
                                  _actionArea(
                                      [_icon(FluIcons.refresh, 'remix')]),
                                  FluButton.icon(
                                    FluIcons.music,
                                    size: 55,
                                    cornerRadius: 999,
                                    backgroundColor: themeManager
                                        .lightTheme.colorScheme.primary,
                                    foregroundColor: themeManager
                                        .lightTheme.colorScheme.onPrimary,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: settings.pagePadding.copyWith(top: 20),
              child: Row(
                children: [
                  FluButton.icon(
                    FluIcons.searchStatus,
                    size: 45,
                    iconSize: 18,
                    iconStrokeWidth: 1.8,
                    backgroundColor:
                        themeManager.lightTheme.colorScheme.surfaceVariant,
                    foregroundColor:
                        themeManager.lightTheme.colorScheme.onSurfaceVariant,
                    margin: const EdgeInsets.only(right: 8),
                  ),
                  Expanded(
                    child: TabBar(
                      controller: tabController,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                      indicator: RectangularIndicator(
                          color: themeManager.lightTheme.colorScheme.primary,
                          cornerRadius: 999),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: themeManager.lightTheme.colorScheme.onPrimary,
                      unselectedLabelColor: Colors.white,
                      splashFactory: NoSplash.splashFactory,
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'For you'),
                        Tab(text: 'Subscriptions'),
                      ],
                    ),
                  ),
                  FluBadge(
                    position: BadgePosition.topRight,
                    child: FluAvatar(
                      size: 40,
                      outlined: true,
                      outlineColor: colorScheme.primaryContainer,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: null,
            bottom: 0,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 2,
                  color: colorScheme.primaryContainer,
                ),
                AnimatedBuilder(
                  animation: barAnimation,
                  builder: (context, child) {
                    return Container(
                      height: 2,
                      width: barAnimation.value,
                      color: colorScheme.primary,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
