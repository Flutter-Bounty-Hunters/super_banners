<p align="center">
  <img src="https://github.com/Flutter-Bounty-Hunters/super_banners/assets/7259036/3e215e59-103e-4ed3-8925-97da4141c172" alt="Super Banners - Display angled banners in a corner of your choice">
</p>

<p align="center">
  <a href="https://flutterbountyhunters.com" target="_blank">
    <img src="https://github.com/Flutter-Bounty-Hunters/flutter_test_robots/assets/7259036/1b19720d-3dad-4ade-ac76-74313b67a898" alt="Built by the Flutter Bounty Hunters">
  </a>
</p>

---

Banners are useful for product-wide messages, such as announcing that your product
is in the "alpha" or "beta" stage. Display a banner in any corner with a `CornerBanner` widget.

`CornerBanner` orients itself based on the desired corner position, and the banner shrinks or expands to fit the content that you provide.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7259036/168518730-7acef56c-4a43-48c0-82a3-f7c892d75d16.png" alt="CornerBanner example"><br>
</p>

```dart
CornerBanner(
  bannerPosition: CornerBannerPosition.topLeft,
  bannerColor: Colors.blue,
  child: Text("Hello, World!"),
);
```

# Built with Flutter
You can also announce to the world that your product was built with Flutter by using
the `BuiltWithFlutterCornerBanner` widget.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7259036/168518398-e70f0c73-5b62-4232-9132-e5ff7715ea25.png" alt="Built with Flutter"><br>
</p>

```dart
BuiltWithFlutterCornerBanner(
  bannerPosition: CornerBannerPosition.topLeft,
  bannerColor: const Color(0xFF222222),
  shadowColor: Colors.black.withOpacity(0.8),
  elevation: 5,
);
```
