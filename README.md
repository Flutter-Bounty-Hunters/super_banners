<p align="center">
  <img src="https://user-images.githubusercontent.com/7259036/170845387-f2919d93-0478-4737-9dd9-59887071a96f.png" width="300" alt="Super Banners"><br>
  <span><b>Displays angled banners in a corner of your choice.</b></span><br><br>
</p>


> This project is a Flutter Bounty Hunters [proof-of-concept](http://policies.flutterbountyhunters.com/about/proof-of-concept). Want more banners? [Fund a milestone](http://policies.flutterbountyhunters.com/about/fund-a-milestone) today!

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
