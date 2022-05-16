import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Displays a banner with the given [child] content in a given
/// [bannerPosition] corner.
///
/// The banner makes itself as thick as needed to fit the given [child].
/// The banner also offsets itself from the corner far enough to fit
/// all of the [child] on screen.
class CornerBanner extends SingleChildRenderObjectWidget {
  const CornerBanner({
    Key? key,
    this.bannerPosition = CornerBannerPosition.topLeft,
    required this.bannerColor,
    this.elevation = 0,
    this.shadowColor = const Color(0x44000000),
    required Widget child,
  }) : super(key: key, child: child);

  /// The position where the banner is displayed.
  final CornerBannerPosition bannerPosition;

  /// The color of the banner, which appears behind the [child] content.
  final Color bannerColor;

  /// The elevation of the banner, which impacts the size of the shadow.
  final double elevation;

  /// The color of the shadow beneath the banner.
  final Color shadowColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBanner(
      bannerPosition: bannerPosition,
      bannerColor: bannerColor,
      elevation: elevation,
      shadowColor: shadowColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _RenderBanner)
      ..bannerPosition = bannerPosition
      ..bannerColor = bannerColor
      ..elevation = elevation
      ..shadowColor = shadowColor;
  }
}

class _RenderBanner extends RenderBox with RenderObjectWithChildMixin {
  _RenderBanner({
    required CornerBannerPosition bannerPosition,
    required Color bannerColor,
    required double elevation,
    required Color shadowColor,
  })  : _bannerPosition = bannerPosition,
        _bannerColor = bannerColor,
        _elevation = elevation,
        _shadowColor = shadowColor;

  CornerBannerPosition _bannerPosition;
  set bannerPosition(CornerBannerPosition newPosition) {
    if (newPosition != _bannerPosition) {
      _bannerPosition = newPosition;
      markNeedsPaint();
    }
  }

  Color _bannerColor;
  set bannerColor(Color newColor) {
    if (newColor != _bannerColor) {
      _bannerColor = newColor;
      markNeedsPaint();
    }
  }

  double _elevation;
  set elevation(double newElevation) {
    if (newElevation != _elevation) {
      _elevation = newElevation;
      markNeedsPaint();
    }
  }

  Color _shadowColor;
  set shadowColor(Color newColor) {
    if (newColor != _shadowColor) {
      _shadowColor = newColor;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
      return;
    }

    child!.layout(constraints, parentUsesSize: true);

    final childSize = (child as RenderBox).size;
    final dimension = _bannerPosition.calculateDistanceToFarBannerEdge(childSize);
    size = Size.square(dimension);
  }

  @override
  void paint(PaintingContext paintingContext, Offset offset) {
    if (child == null) {
      return;
    }

    final childSize = (child as RenderBox).size;

    // Paint the banner.
    final bannerPath = _bannerPosition.createBannerPath(
      bannerBoundingBoxTopLeft: offset,
      contentSize: childSize,
    );

    paintingContext.canvas
      ..drawShadow(
        bannerPath,
        _shadowColor,
        _elevation,
        false,
      )
      ..drawPath(
        bannerPath,
        Paint()
          ..color = _bannerColor
          ..style = PaintingStyle.fill,
      );

    // Orient the canvas to paint the child.
    paintingContext.canvas.save();
    _bannerPosition.positionCanvasToDrawContent(paintingContext.canvas, offset, childSize);

    // Paint the child.
    child!.paint(paintingContext, Offset.zero);
    paintingContext.canvas.restore();
  }
}

class CornerBannerPosition {
  static const CornerBannerPosition topLeft = CornerBannerPosition._(Corner.topLeft);
  static const CornerBannerPosition topRight = CornerBannerPosition._(Corner.topRight);
  static const CornerBannerPosition bottomLeft = CornerBannerPosition._(Corner.bottomLeft);
  static const CornerBannerPosition bottomRight = CornerBannerPosition._(Corner.bottomRight);

  const CornerBannerPosition._(Corner corner) : _corner = corner;

  final Corner _corner;

  /// Creates the path for a banner that fits into the corner of
  /// this [CornerBannerPosition].
  ///
  /// [bannerBoundingBoxTopLeft] is the global screen-space offset for the top
  /// left corner of the banner's bounding box.
  Path createBannerPath({
    required Offset bannerBoundingBoxTopLeft,
    required Size contentSize,
  }) {
    final distanceToNearEdge = calculateDistanceToNearBannerEdge(contentSize);
    final distanceToFarEdge = calculateDistanceToFarBannerEdge(contentSize);

    late Path relativePath;
    switch (_corner) {
      case Corner.topLeft:
        relativePath = Path()
          ..moveTo(0, distanceToNearEdge)
          ..lineTo(distanceToNearEdge, 0)
          ..lineTo(distanceToFarEdge, 0)
          ..lineTo(0, distanceToFarEdge)
          ..close();
        break;
      case Corner.topRight:
        relativePath = Path()
          ..moveTo(0, 0)
          ..lineTo(distanceToFarEdge - distanceToNearEdge, 0)
          ..lineTo(distanceToFarEdge, distanceToNearEdge)
          ..lineTo(distanceToFarEdge, distanceToFarEdge)
          ..close();
        break;
      case Corner.bottomLeft:
        relativePath = Path()
          ..moveTo(0, 0)
          ..lineTo(distanceToFarEdge, distanceToFarEdge)
          ..lineTo(distanceToNearEdge, distanceToFarEdge)
          ..lineTo(0, distanceToFarEdge - distanceToNearEdge)
          ..close();
        break;
      case Corner.bottomRight:
        relativePath = Path()
          ..moveTo(0, distanceToFarEdge)
          ..lineTo(distanceToFarEdge, 0)
          ..lineTo(distanceToFarEdge, distanceToFarEdge - distanceToNearEdge)
          ..lineTo(distanceToFarEdge - distanceToNearEdge, distanceToFarEdge)
          ..close();
        break;
    }

    return relativePath.shift(bannerBoundingBoxTopLeft);
  }

  /// Translates and rotates the canvas such that the top-left corner of
  /// the content is drawn at the desired location on the screen, and
  /// that content is angled 45 degrees in the appropriate direction
  /// for this banner position.
  void positionCanvasToDrawContent(Canvas canvas, Offset paintingOffset, Size contentSize) {
    final contentOrigin = _calculateContentOrigin(paintingOffset, contentSize);
    switch (_corner) {
      case Corner.topLeft:
        canvas
          ..translate(contentOrigin.dx, contentOrigin.dy)
          ..rotate(-pi / 4);
        break;
      case Corner.topRight:
        canvas
          ..translate(contentOrigin.dx, contentOrigin.dy)
          ..rotate(pi / 4);
        break;
      case Corner.bottomLeft:
        canvas
          ..translate(contentOrigin.dx, contentOrigin.dy)
          ..rotate(pi / 4);
        break;
      case Corner.bottomRight:
        canvas
          ..translate(contentOrigin.dx, contentOrigin.dy)
          ..rotate(-pi / 4);
        break;
    }
  }

  /// Calculates the global translation that should be applied before
  /// drawing the content such that (0,0) in the content space corresponds
  /// to the top-left corner of the content in the global screen space.
  Offset _calculateContentOrigin(Offset paintingOffset, Size contentSize) {
    late Offset relativeOrigin;
    switch (_corner) {
      case Corner.topLeft:
        relativeOrigin = Offset(0, calculateDistanceToNearBannerEdge(contentSize));
        break;
      case Corner.topRight:
        relativeOrigin = Offset(
          (calculateDistanceToFarBannerEdge(contentSize) - calculateDistanceToNearBannerEdge(contentSize)),
          0,
        );
        break;
      case Corner.bottomLeft:
        final leftBottomBannerCorner =
            Offset(0, calculateDistanceToFarBannerEdge(contentSize) - calculateDistanceToNearBannerEdge(contentSize));
        relativeOrigin =
            leftBottomBannerCorner + Offset(contentSize.height * sin(pi / 4), -contentSize.height * sin(pi / 4));
        break;
      case Corner.bottomRight:
        final distanceToNearEdge = calculateDistanceToNearBannerEdge(contentSize);
        final distanceToFarEdge = calculateDistanceToFarBannerEdge(contentSize);
        final bottomRightBannerCorner = Offset(distanceToFarEdge - distanceToNearEdge, distanceToFarEdge);
        relativeOrigin =
            bottomRightBannerCorner + Offset(-contentSize.height * sin(pi / 4), -contentSize.height * sin(pi / 4));
        break;
    }

    return relativeOrigin + paintingOffset;
  }

  /// Distance from the corner to the nearest edge of the banner along
  /// the vertical or horizontal axis (the two distances are equal because
  /// the angle is 45 degrees).
  double calculateDistanceToNearBannerEdge(Size contentSize) {
    return (contentSize.width * sin(-pi / 4)).abs();
  }

  /// Distance from the corner to the furthest edge of the banner along
  /// the vertical or horizontal axis (the two distances are equal because
  /// the angle is 45 degrees).
  double calculateDistanceToFarBannerEdge(Size contentSize) {
    return calculateDistanceToNearBannerEdge(contentSize) + (contentSize.height / sin(-pi / 4)).abs();
  }
}

enum Corner {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
