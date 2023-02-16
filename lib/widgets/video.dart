import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/avatar.dart';
import 'package:flukit/widgets/button.dart';
import 'package:flukit/widgets/divider.dart';
import 'package:flukit/widgets/image.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutube/configs/settings.dart';

import '../models/video.dart';

class Video extends StatelessWidget {
  const Video(this.video, {this.margin, super.key});

  final VideoModel video;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return Container(
      margin: margin ?? settings.pagePadding,
      child: Column(
        children: [
          FluImage(
            video.thumbnail,
            height: Flu.screenHeight * .25,
            width: double.infinity,
            overlayOpacity:
                Flu.getThemeOf(context).brightness == Brightness.dark ? .1 : .2,
            cornerRadius: 35,
          ),
          15.ph,
          Row(
            children: [
              FluAvatar(
                size: 45,
                outlined: true,
                outlineColor: colorScheme.surfaceVariant,
                margin: const EdgeInsets.only(right: 10),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: Flu.getTextThemeOf(context)
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  3.ph,
                  Row(
                    children: [
                      Text(video.publisher,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary)),
                      _dotDivider(),
                      Text('${Flu.numberToCompactFormat(video.views)} views',
                          style: Flu.getTextThemeOf(context).bodySmall),
                      _dotDivider(),
                      Text(Flu.timeago(video.publishedAt),
                          style: Flu.getTextThemeOf(context).bodySmall),
                    ],
                  ),
                ],
              )),
              FluButton(
                onPressed: () {},
                margin: const EdgeInsets.only(left: 5),
                backgroundColor: Colors.transparent,
                alignment: Alignment.centerRight,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: FluIcon(
                    FluIcons.more,
                    color: colorScheme.onBackground,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _dotDivider() => FluLine(
        height: 3,
        width: 3,
        radius: 99,
        margin: EdgeInsets.symmetric(horizontal: 5),
      );
}
