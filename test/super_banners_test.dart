import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:super_banners/super_banners.dart';

void main() {
  _bannerGoldenTest(
    "top left corner",
    'top-left',
    const PositionedBanner(
      bannerPosition: BannerPosition.topLeft,
      bannerColor: Colors.blue,
      child: Text("Hello, World!"),
    ),
  );

  _bannerGoldenTest(
    "top right corner",
    'top-right',
    const PositionedBanner(
      bannerPosition: BannerPosition.topRight,
      bannerColor: Colors.blue,
      child: Text("Hello, World!"),
    ),
  );

  _bannerGoldenTest(
    "bottom right corner",
    'bottom-right',
    const PositionedBanner(
      bannerPosition: BannerPosition.bottomRight,
      bannerColor: Colors.blue,
      child: Text("Hello, World!"),
    ),
  );

  _bannerGoldenTest(
    "bottom left corner",
    'bottom-left',
    const PositionedBanner(
      bannerPosition: BannerPosition.bottomLeft,
      bannerColor: Colors.blue,
      child: Text("Hello, World!"),
    ),
  );

  _bannerGoldenTest(
    "built with Flutter",
    'built-with-flutter',
    const BuiltWithFlutterBanner.positioned(
      bannerPosition: BannerPosition.bottomLeft,
    ),
  );
}

void _bannerGoldenTest(String description, String goldenName, Widget banner) {
  testGoldens(description, (tester) async {
    tester.binding.window
      ..physicalSizeTestValue = const Size(200, 200)
      ..devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      _buildBannerDemo(
        child: banner,
      ),
    );

    await screenMatchesGolden(tester, goldenName);

    tester.binding.window.clearAllTestValues();
  });
}

Widget _buildBannerDemo({
  required Widget child,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Stack(
        children: [
          child,
        ],
      ),
    ),
    debugShowCheckedModeBanner: false,
  );
}
