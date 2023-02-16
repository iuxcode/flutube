import 'package:flukit/screens/base.dart';
import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/flu_widgets.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutube/configs/settings.dart';

import '../../data/categories.dart';
import '../../data/videos.dart';
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
                    Text('Youtube',
                        style: Flu.getTextThemeOf(context).headlineSmall),
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
              30.ph,
              Container(
                height: settings.buttonSize - 5,
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
              30.ph,
              TabBar(
                controller: tabController,
                padding: settings.pagePadding,
                indicator: const RectangularIndicator(),
                unselectedLabelColor: colorScheme.onBackground,
                splashFactory: NoSplash.splashFactory,
                isScrollable: true,
                tabs: videoCategories
                    .map((category) => Tab(
                          text: category.label,
                        ))
                    .toList(),
              ),
              30.ph,
              Video(videos[0]),
              30.ph,
              const Divider(),
              15.ph,
              Padding(
                padding: settings.pagePadding,
                child: Row(
                  children: [
                    const FluImage.svg(
                      'assets/shorts_logo.svg',
                      height: 35,
                      width: 35,
                    ),
                    5.pw,
                    Text('Shorts',
                        style: Flu.getTextThemeOf(context).headlineSmall),
                  ],
                ),
              ),
              30.ph,
              const Shorts(),
              30.ph,
              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: settings.pagePadding.copyWith(top: 30),
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Video(
                      videos[index],
                      margin: EdgeInsets.zero,
                    ),
                    15.ph,
                    const Divider(),
                    15.ph,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
