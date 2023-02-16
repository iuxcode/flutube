import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/flu_widgets.dart';
import 'package:flutter/material.dart';

import '../configs/settings.dart';
import '../data/videos.dart';

class Shorts extends StatelessWidget {
  const Shorts({this.title, super.key});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);
    final itemHeight = Flu.screenHeight * .25, itemWidth = Flu.screenWidth * .4;

    return Column(
      children: [
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
              Text(title ?? 'Shorts',
                  style: Flu.getTextThemeOf(context).headlineSmall),
            ],
          ),
        ),
        30.ph,
        SizedBox(
          height: itemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: settings.pagePadding,
            itemCount: shorts.length,
            itemBuilder: (context, index) {
              final short = shorts[index];

              return Container(
                  height: itemHeight,
                  width: itemWidth,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 15),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(children: [
                    FluImage(
                      short.thumbnail,
                      height: double.infinity,
                      width: double.infinity,
                      overlayOpacity: .45,
                    ),
                    Positioned.fill(
                        top: null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: '${short.publisher} - ',
                                      style: TextStyle(
                                          color: colorScheme.primary)),
                                  TextSpan(text: short.title),
                                ]),
                                style: Flu.getTextThemeOf(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                              5.ph,
                              Text(
                                '${Flu.numberToCompactFormat(short.views)} views',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ))
                  ]));
            },
          ),
        ),
      ],
    );
  }
}
