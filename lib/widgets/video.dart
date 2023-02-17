import 'package:flukit/flukit.dart';
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
    const double avatarSize = 45, avatarCornerRadius = 18;

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
                size: avatarSize,
                outlined: true,
                outlineThickness: 1.5,
                outlineColor: colorScheme.primary.withOpacity(.5),
                margin: const EdgeInsets.only(right: 12),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title.capitalizeFirst!,
                    style: Flu.getTextThemeOf(context)
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
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
              FluButton.icon(
                FluIcons.more2,
                onPressed: () {},
                foregroundColor: colorScheme.onSurfaceVariant,
                margin: const EdgeInsets.only(left: 5),
                size: avatarSize,
                backgroundColor: colorScheme.surfaceVariant.withOpacity(.25),
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
