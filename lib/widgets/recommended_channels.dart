import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/avatar.dart';
import 'package:flukit/widgets/image.dart';
import 'package:flutter/material.dart';

import '../configs/settings.dart';
import '../data/videos.dart';

class RecommendedChannels extends StatelessWidget {
  const RecommendedChannels({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);
    final itemSize = Flu.screenWidth * .15;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: settings.pagePadding,
          child: Row(
            children: [
              const FluImage.svg(
                'assets/logo.svg',
                height: 35,
                width: 35,
              ),
              5.pw,
              Text('Top channels',
                  style: Flu.getTextThemeOf(context).headlineSmall),
            ],
          ),
        ),
        20.ph,
        SizedBox(
          height: itemSize + 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: settings.pagePadding,
            itemCount: 15,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(left: index == 0 ? 0 : 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FluAvatar(
                    size: itemSize,
                    outlined: true,
                    outlineColor: colorScheme.primaryContainer.withOpacity(.5),
                    margin: EdgeInsets.only(bottom: 5),
                    defaultAvatarType: FluAvatarTypes.memojis,
                  ),
                  Text('John doe')
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
