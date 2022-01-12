import 'package:flutter/material.dart' hide Banner;
import 'package:super_banners/super_banners.dart';

class BuiltWithFlutterBanner extends StatelessWidget {
  const BuiltWithFlutterBanner.positioned({
    Key? key,
    required this.bannerPosition,
    required this.bannerColor,
    this.elevation = 0,
    this.shadowColor = const Color(0xCC000000),
  })  : isPositioned = true,
        super(key: key);

  const BuiltWithFlutterBanner({
    Key? key,
    required this.bannerPosition,
    required this.bannerColor,
    this.elevation = 0,
    this.shadowColor = const Color(0xCC000000),
  })  : isPositioned = false,
        super(key: key);

  final bool isPositioned;
  final BannerPosition bannerPosition;
  final Color bannerColor;
  final double elevation;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    if (isPositioned) {
      return PositionedBanner(
        bannerPosition: bannerPosition,
        bannerColor: bannerColor,
        elevation: elevation,
        shadowColor: shadowColor,
        child: _buildBannerContent(),
      );
    } else {
      return Banner(
        bannerPosition: bannerPosition,
        bannerColor: const Color(0xFF17191c),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.8),
        child: _buildBannerContent(),
      );
    }
  }

  Widget _buildBannerContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        // Material prevents ugly text display when there is no
        // Scaffold above this banner.
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'BUILT\nWITH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            const FlutterLogo(
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}
