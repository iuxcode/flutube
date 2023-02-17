import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/flu_widgets.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../../../configs/settings.dart';
import '../../../data/categories.dart';
import '../../../data/videos.dart';
import '../../../models/video.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: settings.pagePadding.copyWith(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Library.',
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
            Padding(
              padding: settings.pagePadding.copyWith(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Watch history.',
                      style: Flu.getTextThemeOf(context)
                          .headlineSmall
                          ?.copyWith(
                              color: colorScheme.onBackground.withOpacity(.35)),
                    ),
                  ),
                  FluButton.text(
                    'Watch all',
                    suffixIcon: FluIcons.arrowRight,
                    padding: const EdgeInsets.all(15),
                    backgroundColor: colorScheme.surfaceVariant,
                    foregroundColor: colorScheme.onSurfaceVariant,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            20.ph,
            _History(videos),
            30.ph,
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Divider(
                  color: colorScheme.outlineVariant.withOpacity(.25),
                ),
                FluLine(
                  height: 3,
                  width: Flu.screenWidth * .05,
                  color: colorScheme.primary,
                  margin: EdgeInsets.only(left: settings.pagePadding.left),
                )
              ],
            ),
            Padding(
              padding: settings.pagePadding.copyWith(top: 20, bottom: 30),
              child: Text(
                'Playlists.',
                style: Flu.getTextThemeOf(context).headlineSmall?.copyWith(
                    color: colorScheme.onBackground.withOpacity(.35)),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: settings.pagePadding,
              children: [
                _ListTile(videos[0]),
                15.ph,
                _ListTile(videos[1]),
                15.ph,
                _ListTile(videos[2]),
                15.ph,
                _ListTile(videos[3]),
                15.ph,
                _ListTile(videos[4]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _History extends StatelessWidget {
  const _History(this.videos, {super.key});

  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: settings.pagePadding,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: videos.map((video) {
          final index = videos.indexOf(video);

          return Container(
            width: Flu.screenWidth * .45,
            margin: EdgeInsets.only(left: index == 0 ? 0 : 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FluImage(
                  video.thumbnail,
                  height: Flu.screenHeight * .15,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                ),
                Text(
                  video.title,
                  style: Flu.getTextThemeOf(context).headlineSmall?.copyWith(
                      fontSize:
                          Flu.getTextThemeOf(context).titleLarge?.fontSize),
                ),
                2.ph,
                Text(
                  video.publisher,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile(this.video, {super.key});

  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return Container(
      child: Row(
        children: [
          FluImage(
            video.thumbnail,
            height: Flu.screenHeight * .085,
            width: Flu.screenHeight * .085,
            margin: const EdgeInsets.only(right: 10),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.title,
                style: Flu.getTextThemeOf(context).headlineSmall?.copyWith(
                    fontSize: Flu.getTextThemeOf(context).titleLarge?.fontSize,
                    color: colorScheme.onBackground),
              ),
              const Text('40 videos'),
            ],
          )),
          FluIcon(
            FluIcons.arrowRight1,
            size: 16,
            color: colorScheme.onBackground.withOpacity(.35),
          ),
        ],
      ),
    );
  }
}
