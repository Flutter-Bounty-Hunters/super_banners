import 'package:flutter/widgets.dart' hide Banner;

import 'banner.dart';

/// A banner displayed in the desired corner of a `Stack`.
///
/// A [PositionedCornerBanner] must be the child of a `Stack`.
///
/// If you'd like to display a banner within some other widget,
/// consider using a [CornerBanner] widget, which can have any parent.
class PositionedCornerBanner extends StatelessWidget {
  const PositionedCornerBanner({
    Key? key,
    required this.bannerPosition,
    required this.bannerColor,
    this.elevation = 0,
    this.shadowColor = const Color(0x44000000),
    required this.child,
  }) : super(key: key);

  final CornerBannerPosition bannerPosition;
  final Color bannerColor;
  final double elevation;
  final Color shadowColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    late double? left, right, top, bottom;
    if (bannerPosition == CornerBannerPosition.topLeft) {
      left = 0;
      top = 0;
      right = null;
      bottom = null;
    } else if (bannerPosition == CornerBannerPosition.topRight) {
      left = null;
      top = 0;
      right = 0;
      bottom = null;
    } else if (bannerPosition == CornerBannerPosition.bottomRight) {
      left = null;
      top = null;
      right = 0;
      bottom = 0;
    } else if (bannerPosition == CornerBannerPosition.bottomLeft) {
      left = 0;
      top = null;
      right = null;
      bottom = 0;
    }

    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: CornerBanner(
        bannerPosition: bannerPosition,
        bannerColor: bannerColor,
        shadowColor: shadowColor,
        elevation: elevation,
        child: child,
      ),
    );
  }
}
