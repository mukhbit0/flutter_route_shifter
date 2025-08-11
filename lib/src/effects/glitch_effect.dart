// lib/src/effects/glitch_effect.dart
import 'package:flutter/material.dart';
import 'base_effect.dart';
import 'dart:math' as math;
import 'dart:async';

/// Creates a stylistic, digital "glitch" effect.
///
/// Rapidly jitters position, shear, and color channels to create a
/// modern, cyberpunk-style transition.
class GlitchEffect extends RouteEffect {
  final double intensity;

  const GlitchEffect({
    this.intensity = 5.0,
    super.duration = const Duration(milliseconds: 400),
    super.curve,
    super.start,
    super.end,
  });

  @override
  Widget build(Animation<double> parentAnimation, Widget child) {
    return _GlitchEffectWrapper(
      animation: parentAnimation,
      intensity: intensity,
      child: child,
    );
  }

  @override
  Widget buildTransition(Animation<double> animation, Widget child) => child;

  @override
  RouteEffect copyWith({
    double? intensity,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return GlitchEffect(
      intensity: intensity ?? this.intensity,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}

class _GlitchEffectWrapper extends StatefulWidget {
  final Animation<double> animation;
  final double intensity;
  final Widget child;

  const _GlitchEffectWrapper({
    required this.animation,
    required this.intensity,
    required this.child,
  });

  @override
  _GlitchEffectWrapperState createState() => _GlitchEffectWrapperState();
}

class _GlitchEffectWrapperState extends State<_GlitchEffectWrapper> {
  final _random = math.Random();
  Timer? _glitchTimer;
  Offset _translate = Offset.zero;
  Offset _shear = Offset.zero;
  Color _colorFilter = Colors.transparent;

  @override
  void initState() {
    super.initState();
    widget.animation.addListener(_onAnimationUpdate);
  }

  void _onAnimationUpdate() {
    if (widget.animation.status == AnimationStatus.forward) {
      // Performance optimization: Skip glitch if intensity is too low
      if (widget.intensity < 0.1) {
        return;
      }
      
      _glitchTimer ??=
          Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (!mounted || widget.animation.value > 0.8) {
          timer.cancel();
          _glitchTimer = null;
          if (mounted) {
            setState(() {
              _translate = Offset.zero;
              _shear = Offset.zero;
              _colorFilter = Colors.transparent;
            });
          }
          return;
        }
        if (mounted) {
          setState(() {
            final intensity = widget.intensity * (1 - widget.animation.value);
            _translate = Offset(_random.nextDouble() * intensity - intensity / 2,
                _random.nextDouble() * intensity - intensity / 2);
            _shear = Offset(_random.nextDouble() * 0.1 - 0.05, 0);
            _colorFilter = [
              Colors.red,
              Colors.green,
              Colors.blue
            ][_random.nextInt(3)]
                .withValues(alpha: 0.2);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    widget.animation.removeListener(_onAnimationUpdate);
    _glitchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _translate,
      child: Transform(
        transform: Matrix4.identity()..setEntry(0, 1, _shear.dx),
        alignment: Alignment.center,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(_colorFilter, BlendMode.srcOver),
          child: widget.child,
        ),
      ),
    );
  }
}
