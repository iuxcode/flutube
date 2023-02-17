import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutube/models/category.dart';

import '../../../configs/settings.dart';
import '../../../data/categories.dart';
import '../../../data/videos.dart';
import '../../../widgets/shorts.dart';
import '../../../widgets/video.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
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
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 15, bottom: 30),
        child: Column(
          children: [
            Padding(
              padding: settings.pagePadding.copyWith(bottom: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      settings.appName,
                      style: Flu.getTextThemeOf(context).headlineSmall,
                    ),
                  ),
                  FluButton.icon(
                    Get.isDarkMode ? FluIcons.sun : FluIcons.moon,
                    onPressed: () => Flu.changeThemeMode(),
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
            Container(
              height: settings.buttonSizeMd + 5,
              margin: settings.pagePadding,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(99)),
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
            CategoriesTab(
              tabController: tabController,
              categories: videoCategories,
            ),
            Video(videos[0]),
            const KDivider(),
            Shorts(shorts),
            const KDivider(padding: EdgeInsets.only(top: 30)),
            Videos(videos, colorScheme),
          ],
        ),
      ),
    );
  }
}

class CategoriesTab extends StatelessWidget {
  const CategoriesTab(
      {super.key, required this.tabController, required this.categories});

  final TabController tabController;
  final List<VideoCategory> categories;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return TabBar(
      controller: tabController,
      padding: settings.pagePadding.copyWith(top: 20, bottom: 25),
      labelPadding: const EdgeInsets.symmetric(horizontal: 15),
      indicator:
          RectangularIndicator(color: colorScheme.primary, cornerRadius: 999),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: colorScheme.onPrimary,
      unselectedLabelColor: colorScheme.onBackground.withOpacity(.65),
      splashFactory: NoSplash.splashFactory,
      isScrollable: true,
      dividerColor: Colors.transparent,
      tabs: categories
          .map((category) => Tab(
                text: category.label,
              ))
          .toList(),
    );
  }
}
