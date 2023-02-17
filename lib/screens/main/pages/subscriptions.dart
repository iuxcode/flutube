import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/flu_widgets.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../../../configs/settings.dart';
import '../../../data/categories.dart';
import '../../../data/videos.dart';
import '../../../widgets/shorts.dart';
import '../../../widgets/video.dart';
import 'home.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen>
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

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: settings.pagePadding.copyWith(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Subscriptions',
                      style: Flu.getTextThemeOf(context).headlineSmall,
                    ),
                  ),
                  FluButton.icon(
                    FluIcons.searchStatus,
                    size: 45,
                    iconSize: 18,
                    iconStrokeWidth: 1.8,
                    backgroundColor: colorScheme.surfaceVariant,
                    foregroundColor: colorScheme.onSurfaceVariant,
                    margin: const EdgeInsets.only(right: 8),
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
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Divider(
                  color: colorScheme.outlineVariant.withOpacity(.25),
                ),
                FluLine(
                  height: 3,
                  width: Flu.screenWidth * .1,
                  color: colorScheme.primary,
                  margin: EdgeInsets.only(left: settings.pagePadding.left),
                )
              ],
            ),
            20.ph,
            const _Channels(),
            Padding(
              padding: settings.pagePadding.copyWith(top: 45, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FluLine(
                    height: 3,
                    width: Flu.screenWidth * .1,
                    color: colorScheme.surfaceVariant,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Text(
                    'Latest\nReleases.',
                    style: Flu.getTextThemeOf(context).headlineSmall,
                  ),
                ],
              ),
            ),
            CategoriesTab(
              tabController: tabController,
              categories: videoCategories,
            ),
            Videos(videos, colorScheme),
          ],
        ),
      ),
    );
  }
}

class _Channels extends StatelessWidget {
  const _Channels({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);
    final double itemSize = 65;

    return Container(
      height: itemSize + 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: settings.pagePadding,
        itemCount: 10,
        itemBuilder: (context, index) {
          return FluButton(
            onPressed: () {},
            margin: EdgeInsets.only(left: index == 0 ? 0 : 20),
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FluAvatar(
                  size: itemSize,
                  badge: index == 1 || index == 3,
                  badgePosition: BadgePosition.topRight,
                  outlined: true,
                  outlineColor: colorScheme.primaryContainer.withOpacity(.5),
                  margin: const EdgeInsets.only(bottom: 10),
                ),
                Text(
                  'Jogn Doe',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onBackground.withOpacity(.5)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
