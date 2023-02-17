import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/flu_widgets.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

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
                      style: Flu.getTextThemeOf(context).titleLarge,
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
            TabBar(
              controller: tabController,
              padding: settings.pagePadding.copyWith(top: 20, bottom: 25),
              labelPadding: const EdgeInsets.symmetric(horizontal: 15),
              indicator: RectangularIndicator(
                  color: colorScheme.primary, cornerRadius: 999),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: colorScheme.onPrimary,
              unselectedLabelColor: colorScheme.onBackground.withOpacity(.65),
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              dividerColor: Colors.transparent,
              tabs: videoCategories
                  .map((category) => Tab(
                        text: category.label,
                      ))
                  .toList(),
            ),
            Video(videos[0]),
            const _Divider(),
            Shorts(shorts),
            const _Divider(padding: EdgeInsets.only(top: 30)),
            _Videos(colorScheme),
          ],
        ),
      ),
    );
  }
}

class _Videos extends StatelessWidget {
  const _Videos(this.colorScheme, {super.key});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 30),
      shrinkWrap: true,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index != 0)
              const _Divider(padding: EdgeInsets.symmetric(vertical: 30)),
            Video(videos[index]),
          ],
        );
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    super.key,
    this.padding,
  });

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 25, bottom: 15),
      child: Divider(
        indent: settings.pagePadding.left + 5,
        endIndent: settings.pagePadding.right + 5,
        color: Flu.getColorSchemeOf(context).outlineVariant.withOpacity(.25),
      ),
    );
  }
}
