import 'dart:math' as math;
import 'package:flukit/utils/flu_utils.dart';
import 'package:flukit/widgets/button.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../configs/settings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.items, this.onItemTap});

  final List<FluIcons> items;
  final void Function(int)? onItemTap;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey _itemKey = GlobalKey();

  double _itemWidth = 0;

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    // getItemWidth();
    super.didUpdateWidget(oldWidget);
  }

  void getItemWidth() => setState(() => _itemWidth =
      (_itemKey.currentContext?.findRenderObject() as RenderBox).size.width);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return Container(
      height: settings.bottomNavigationBarHeight,
      padding:
          EdgeInsets.symmetric(horizontal: settings.pagePadding.left * .65),
      decoration: BoxDecoration(
        color: colorScheme.background,
        boxShadow: [
          BoxShadow(color: colorScheme.shadow.withOpacity(.085), blurRadius: 30)
        ],
        border: Border(
            top: BorderSide(width: .5, color: colorScheme.outlineVariant)),
      ),
      child: Stack(
        children: [
          Row(
              children: widget.items
                  .map((item) => _BottomNavItem(
                      key: widget.items.indexOf(item) == 0 ? _itemKey : null,
                      item))
                  .toList()),
          _BottomNavIndicator(itemWidth: _itemWidth)
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem(this.item, {super.key});

  final FluIcons item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);

    return Expanded(
      child: FluButton.icon(
        item,
        size: double.infinity,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onBackground,
        iconStrokeWidth: 1.8,
        iconSize: 22,
      ),
    );
  }
}

class _BottomNavIndicator extends StatelessWidget {
  const _BottomNavIndicator({
    super.key,
    required this.itemWidth,
  });

  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: 0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: 3,
        width: itemWidth,
        alignment: Alignment.center,
        child: Container(
          height: double.infinity,
          width: 15,
          decoration: BoxDecoration(
            color: Flu.getColorSchemeOf(context).primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
