import 'package:flukit/screens/base.dart';
import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/flu_widgets.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutube/configs/settings.dart';
import 'package:flutube/configs/themes.dart';
import 'package:flutube/widgets/recommended_channels.dart';

import '../../data/categories.dart';
import '../../data/videos.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/shorts.dart';
import '../../widgets/video.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: videoCategories.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return FluScreen(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, bottom: Flu.screenHeight * .065),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: settings.pagePadding,
                child: Row(
                  children: [
                    Text(settings.appName,
                        style: Flu.getTextThemeOf(context)
                            .headlineSmall
                            ?.copyWith(
                                color: settings.defaultTheme.colorSchemeSeed)),
                    const Spacer(),
                    FluButton.icon(
                      FluIcons.notification,
                      onPressed: () {},
                      size: 42,
                      iconSize: 20,
                      iconStrokeWidth: 1.8,
                      backgroundColor: colorScheme.surfaceVariant,
                      foregroundColor: colorScheme.onSurfaceVariant,
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    FluBadge(
                      position: BadgePosition.topRight,
                      offset: const Offset(5, 2),
                      boxShadow: [
                        BoxShadow(color: colorScheme.primary, blurRadius: 10)
                      ],
                      child: FluAvatar(
                        size: 40,
                        outlined: true,
                        outlineThickness: 2.5,
                        outlineColor:
                            colorScheme.surfaceVariant.withOpacity(.5),
                      ),
                    ),
                  ],
                ),
              ),
              20.ph,
              Container(
                height: settings.buttonSizeMd + 5,
                margin: settings.pagePadding,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(999)),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.center,
                  style: Flu.getTextThemeOf(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: FluIcon(
                      FluIcons.search,
                      size: 20,
                      color: colorScheme.onSurfaceVariant.withOpacity(.5),
                      margin: const EdgeInsets.only(right: 5),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 15),
                  ),
                ),
              ),
              20.ph,
              TabBar(
                controller: tabController,
                padding: settings.pagePadding,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                indicator: RectangularIndicator(
                    color: colorScheme.primary, cornerRadius: 999),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: colorScheme.onPrimary,
                unselectedLabelColor: colorScheme.onBackground,
                splashFactory: NoSplash.splashFactory,
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabs: videoCategories
                    .map((category) => Tab(
                          text: category.label,
                        ))
                    .toList(),
              ),
              30.ph,
              Video(videos[0]),
              30.ph,
              _divider(),
              15.ph,
              const Shorts(),
              30.ph,
              _divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 30),
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index != 0) ...[
                        15.ph,
                        Divider(
                          indent: settings.pagePadding.left,
                          endIndent: settings.pagePadding.right,
                          color: colorScheme.outlineVariant.withOpacity(.5),
                        ),
                        15.ph,
                      ],
                      Video(videos[index]),
                      if (index == 2) ...[
                        15.ph,
                        _divider(),
                        20.ph,
                        const Shorts(
                          title: 'Dance',
                        ),
                      ]
                      /* if (index == 1) ...[
                        15.ph,
                        _divider(),
                        15.ph,
                        const RecommendedChannels(),
                      ] */
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(items: [
        FluIcons.home2,
        FluIcons.sliderVertical1,
        FluIcons.addSquare,
        FluIcons.people,
        FluIcons.musicLibrary2,
      ]),
    );
  }

  Widget _divider() => Divider(
      color: Flu.getColorSchemeOf(context).outlineVariant.withOpacity(.25));
}
