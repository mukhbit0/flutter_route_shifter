import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'base_effect.dart';

/// Creates dramatic reveal transitions by animating a ClipPath.
///
/// This effect reveals the new screen through a growing shape, allowing for
/// visually stunning transitions like expanding circles, diagonal wipes, or custom paths.
class ClipPathEffect extends RouteEffect {
  /// The custom clipper that defines the reveal shape.
  final CustomClipper<Path>? clipper;

  /// Predefined clip path types for common reveal shapes.
  final ClipPathType type;

  /// The direction of the reveal for directional clips.
  final ClipDirection direction;

  /// Whether to reverse the clip (clip the revealed area instead of the hidden area).
  final bool reversed;

  const ClipPathEffect({
    this.clipper,
    this.type = ClipPathType.circle,
    this.direction = ClipDirection.center,
    this.reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return ClipPath(
      clipper: clipper ?? _createBuiltInClipper(type, direction, animation),
      child: child,
    );
  }

  @override
  RouteEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return ClipPathEffect(
      clipper: clipper,
      type: type,
      direction: direction,
      reversed: reversed,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates built-in clippers for common reveal shapes.
  CustomClipper<Path> _createBuiltInClipper(
    ClipPathType type,
    ClipDirection direction,
    Animation<double> animation,
  ) {
    switch (type) {
      case ClipPathType.circle:
        return _CircleRevealClipper(animation, direction, reversed);
      case ClipPathType.rectangle:
        return _RectangleRevealClipper(animation, direction, reversed);
      case ClipPathType.triangle:
        return _TriangleRevealClipper(animation, direction, reversed);
      case ClipPathType.diamond:
        return _DiamondRevealClipper(animation, direction, reversed);
      case ClipPathType.star:
        return _StarRevealClipper(animation, direction, reversed);
      case ClipPathType.wave:
        return _WaveRevealClipper(animation, direction, reversed);
    }
  }
}

/// Predefined clip path types for common reveal shapes.
enum ClipPathType {
  circle,
  rectangle,
  triangle,
  diamond,
  star,
  wave,
}

/// Direction of the reveal animation.
enum ClipDirection {
  center,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  top,
  bottom,
  left,
  right,
}

/// Circle reveal clipper that expands from a point.
class _CircleRevealClipper extends CustomClipper<Path> {
  final Animation<double> animation;
  final ClipDirection direction;
  final bool reversed;

  _CircleRevealClipper(this.animation, this.direction, this.reversed)
      : super(reclip: animation);

  @override
  Path getClip(Size size) {
    final path = Path();
    final progress = reversed ? 1.0 - animation.value : animation.value;

    // Calculate reveal center based on direction
    Offset center;
    switch (direction) {
      case ClipDirection.center:
        center = Offset(size.width / 2, size.height / 2);
        break;
      case ClipDirection.topLeft:
        center = Offset.zero;
        break;
      case ClipDirection.topRight:
        center = Offset(size.width, 0);
        break;
      case ClipDirection.bottomLeft:
        center = Offset(0, size.height);
        break;
      case ClipDirection.bottomRight:
        center = Offset(size.width, size.height);
        break;
      case ClipDirection.top:
        center = Offset(size.width / 2, 0);
        break;
      case ClipDirection.bottom:
        center = Offset(size.width / 2, size.height);
        break;
      case ClipDirection.left:
        center = Offset(0, size.height / 2);
        break;
      case ClipDirection.right:
        center = Offset(size.width, size.height / 2);
        break;
    }

    // Calculate maximum radius to ensure full reveal
    final maxRadius = _calculateMaxRadius(size, center);
    final currentRadius = maxRadius * progress;

    if (currentRadius > 0) {
      path.addOval(Rect.fromCircle(center: center, radius: currentRadius));
    }

    return path;
  }

  double _calculateMaxRadius(Size size, Offset center) {
    // Distance to farthest corner
    final distances = [
      (Offset.zero - center).distance,
      (Offset(size.width, 0) - center).distance,
      (Offset(0, size.height) - center).distance,
      (Offset(size.width, size.height) - center).distance,
    ];
    return distances.reduce((a, b) => a > b ? a : b);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Rectangle reveal clipper.
class _RectangleRevealClipper extends CustomClipper<Path> {
  final Animation<double> animation;
  final ClipDirection direction;
  final bool reversed;

  _RectangleRevealClipper(this.animation, this.direction, this.reversed)
      : super(reclip: animation);

  @override
  Path getClip(Size size) {
    final path = Path();
    final progress = reversed ? 1.0 - animation.value : animation.value;

    late Rect rect;
    switch (direction) {
      case ClipDirection.center:
        final centerX = size.width / 2;
        final centerY = size.height / 2;
        final halfWidth = size.width / 2 * progress;
        final halfHeight = size.height / 2 * progress;
        rect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: halfWidth * 2,
          height: halfHeight * 2,
        );
        break;
      case ClipDirection.left:
        rect = Rect.fromLTWH(0, 0, size.width * progress, size.height);
        break;
      case ClipDirection.right:
        final startX = size.width * (1 - progress);
        rect = Rect.fromLTWH(startX, 0, size.width * progress, size.height);
        break;
      case ClipDirection.top:
        rect = Rect.fromLTWH(0, 0, size.width, size.height * progress);
        break;
      case ClipDirection.bottom:
        final startY = size.height * (1 - progress);
        rect = Rect.fromLTWH(0, startY, size.width, size.height * progress);
        break;
      default:
        rect =
            Rect.fromLTWH(0, 0, size.width * progress, size.height * progress);
    }

    if (rect.width > 0 && rect.height > 0) {
      path.addRect(rect);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Triangle reveal clipper.
class _TriangleRevealClipper extends CustomClipper<Path> {
  final Animation<double> animation;
  final ClipDirection direction;
  final bool reversed;

  _TriangleRevealClipper(this.animation, this.direction, this.reversed)
      : super(reclip: animation);

  @override
  Path getClip(Size size) {
    final path = Path();
    final progress = reversed ? 1.0 - animation.value : animation.value;

    if (progress <= 0) return path;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final maxSize = size.longestSide;
    final currentSize = maxSize * progress;

    switch (direction) {
      case ClipDirection.top:
        path.moveTo(centerX, centerY - currentSize / 2);
        path.lineTo(centerX - currentSize / 2, centerY + currentSize / 2);
        path.lineTo(centerX + currentSize / 2, centerY + currentSize / 2);
        break;
      case ClipDirection.bottom:
        path.moveTo(centerX, centerY + currentSize / 2);
        path.lineTo(centerX - currentSize / 2, centerY - currentSize / 2);
        path.lineTo(centerX + currentSize / 2, centerY - currentSize / 2);
        break;
      case ClipDirection.left:
        path.moveTo(centerX - currentSize / 2, centerY);
        path.lineTo(centerX + currentSize / 2, centerY - currentSize / 2);
        path.lineTo(centerX + currentSize / 2, centerY + currentSize / 2);
        break;
      case ClipDirection.right:
        path.moveTo(centerX + currentSize / 2, centerY);
        path.lineTo(centerX - currentSize / 2, centerY - currentSize / 2);
        path.lineTo(centerX - currentSize / 2, centerY + currentSize / 2);
        break;
      default:
        // Center expanding triangle
        path.moveTo(centerX, centerY - currentSize / 3);
        path.lineTo(centerX - currentSize / 3, centerY + currentSize / 6);
        path.lineTo(centerX + currentSize / 3, centerY + currentSize / 6);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Diamond reveal clipper.
class _DiamondRevealClipper extends CustomClipper<Path> {
  final Animation<double> animation;
  final ClipDirection direction;
  final bool reversed;

  _DiamondRevealClipper(this.animation, this.direction, this.reversed)
      : super(reclip: animation);

  @override
  Path getClip(Size size) {
    final path = Path();
    final progress = reversed ? 1.0 - animation.value : animation.value;

    if (progress <= 0) return path;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final maxSize = size.longestSide;
    final currentSize = maxSize * progress;

    path.moveTo(centerX, centerY - currentSize / 2); // Top
    path.lineTo(centerX + currentSize / 2, centerY); // Right
    path.lineTo(centerX, centerY + currentSize / 2); // Bottom
    path.lineTo(centerX - currentSize / 2, centerY); // Left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Star reveal clipper.
class _StarRevealClipper extends CustomClipper<Path> {
  final Animation<double> animation;
  final ClipDirection direction;
  final bool reversed;

  _StarRevealClipper(this.animation, this.direction, this.reversed)
      : super(reclip: animation);

  @override
  Path getClip(Size size) {
    final path = Path();
    final progress = reversed ? 1.0 - animation.value : animation.value;

    if (progress <= 0) return path;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final maxSize = size.longestSide;
    final outerRadius = maxSize * progress / 2;
    final innerRadius = outerRadius * 0.4;

    const points = 5;
    const angle = 2 * 3.14159 / points;

    for (int i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final currentAngle = i * angle / 2 - 3.14159 / 2;
      final x = centerX + radius * math.cos(currentAngle);
      final y = centerY + radius * math.sin(currentAngle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Wave reveal clipper.
class _WaveRevealClipper extends CustomClipper<Path> {
  final Animation<double> animation;
  final ClipDirection direction;
  final bool reversed;

  _WaveRevealClipper(this.animation, this.direction, this.reversed)
      : super(reclip: animation);

  @override
  Path getClip(Size size) {
    final path = Path();
    final progress = reversed ? 1.0 - animation.value : animation.value;

    if (progress <= 0) return path;

    final waveHeight = size.height * 0.1;
    final currentWidth = size.width * progress;

    switch (direction) {
      case ClipDirection.left:
        path.moveTo(0, 0);
        // Create wave pattern
        for (double x = 0; x <= currentWidth; x += 10) {
          final waveY = waveHeight * math.sin(2 * math.pi * x / size.width * 4);
          path.lineTo(x, size.height / 2 + waveY);
        }
        path.lineTo(currentWidth, size.height);
        path.lineTo(0, size.height);
        break;
      case ClipDirection.right:
        final startX = size.width - currentWidth;
        path.moveTo(startX, 0);
        for (double x = startX; x <= size.width; x += 10) {
          final waveY = waveHeight * math.sin(2 * math.pi * x / size.width * 4);
          path.lineTo(x, size.height / 2 + waveY);
        }
        path.lineTo(size.width, size.height);
        path.lineTo(startX, size.height);
        break;
      default:
        // Default to left
        path.addRect(Rect.fromLTWH(0, 0, currentWidth, size.height));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

// TODO: Extension methods for easy integration with RouteShifterBuilder
// Once RouteShifterBuilder is implemented, these can be added:
//
// extension ClipPathEffectExtensions on RouteShifterBuilder {
//   /// Adds a clip path effect with a custom clipper.
//   RouteShifterBuilder clipPath({
//     CustomClipper<Path>? clipper,
//     ClipPathType type = ClipPathType.circle,
//     ClipDirection direction = ClipDirection.center,
//     bool reversed = false,
//     Duration? duration,
//     Curve curve = Curves.easeInOut,
//   }) {
//     // Implementation would go here
//     return this;
//   }
// }
