import 'package:flutter/material.dart';
import 'package:super_banners/super_banners.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Super Banners Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 400,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFF444444),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: const Center(
                child: Text(
                  "SUPER BANNERS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            BuiltWithFlutterCornerBanner.positioned(
              bannerPosition: CornerBannerPosition.topLeft,
              bannerColor: const Color(0xFF222222),
              shadowColor: Colors.black.withOpacity(0.8),
              elevation: 5,
            ),
            BuiltWithFlutterCornerBanner.positioned(
              bannerPosition: CornerBannerPosition.topRight,
              bannerColor: const Color(0xFF222222),
              shadowColor: Colors.black.withOpacity(0.8),
              elevation: 5,
            ),
            BuiltWithFlutterCornerBanner.positioned(
              bannerPosition: CornerBannerPosition.bottomRight,
              bannerColor: const Color(0xFF222222),
              shadowColor: Colors.black.withOpacity(0.8),
              elevation: 5,
            ),
            BuiltWithFlutterCornerBanner.positioned(
              bannerPosition: CornerBannerPosition.bottomLeft,
              bannerColor: const Color(0xFF222222),
              shadowColor: Colors.black.withOpacity(0.8),
              elevation: 5,
            ),
          ],
        ),
      ),
    );
  }
}
