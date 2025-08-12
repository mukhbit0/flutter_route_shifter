# Flutter Route Shifter

A powerful, declarative route transition package with 34+ chainable animations, shared elements, and advanced effects for Flutter applications.

<div align="center">

[![pub package](https://img.shields.io/pub/v/flutter_route_shifter.svg)](https://pub.dev/packages/flutter_route_shifter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.7%2B-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.1%2B-blue.svg)](https://dart.dev/)

### 🎬 See It In Action

<table>
<tr>
<td align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/fade_slide.gif" width="200"/>
<br><b>Fade + Slide</b>
</td>
<td align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/scale.gif" width="200"/>
<br><b>Scale Animation</b>
</td>
<td align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/sequenced.gif" width="200"/>
<br><b>Sequenced Effects</b>
</td>
</tr>
<tr>
<td align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/glass.gif" width="200"/>
<br><b>Glass Morphism</b>
</td>
<td align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/shared.gif" width="200"/>
<br><b>Shared Elements</b>
</td>
<td align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/perspective_fade.gif" width="200"/>
<br><b>3D Perspective</b>
</td>
</tr>
</table>

</div>

## ✨ Features

- **🔗 Chainable API**: Intuitive `.fade().slide().scale()` syntax for combining effects
- **🎨 34+ Rich Effects**: Complete animation library including fade, slide, scale, rotation, blur, shear, and more
- **🚀 Shared Elements**: Hero-like transitions between pages with advanced shared element support
- **📱 Platform Presets**: Material Design and Cupertino (iOS) style transitions
- **⏱️ Sequenced Animations**: Manual timing control for precise choreography
- **🎯 Performance Optimized**: Efficient animations with minimal overhead
- **🛠️ Highly Customizable**: Custom curves, durations, and timing controls
- **🎪 Creative Effects**: Follow-path animations, parallax effects, clip-path transitions
- **📐 Advanced Geometry**: Shear, perspective, and 3D-like transformations
- **🎨 Visual Effects**: Blur, glass, glitch, color tint, and mask effects
- **🧩 Modular Architecture**: Clean, maintainable codebase with mixin-based structure

## 🚀 Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_route_shifter: ^1.0.0
```

Then run:

```bash
$ flutter pub get
```

### Basic Usage

```dart
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

// Simple fade transition
final route = RouteShifterBuilder()
  .fade(duration: Duration(milliseconds: 300))
  .toRoute(page: NextPage());

Navigator.of(context).push(route);
```

## 🎨 Complete Effects Library

### 🟢 Basic Transitions

#### Fade Transitions

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/fade.gif" width="250" align="right"/>

```dart
// Basic fade in
RouteShifterBuilder()
  .fade(
    duration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  )

// Fade with opacity control
RouteShifterBuilder()
  .fade(
    beginOpacity: 0.0,
    endOpacity: 1.0,
    duration: Duration(milliseconds: 500),
  )
```

#### Slide Transitions

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/slide.gif" width="250" align="right"/>

```dart
// Slide from right
RouteShifterBuilder()
  .slide(
    beginOffset: Offset(1.0, 0.0),
    duration: Duration(milliseconds: 300),
  )

// Slide from bottom
RouteShifterBuilder()
  .slideFromBottom()

// Slide from left  
RouteShifterBuilder()
  .slideFromLeft()

// Slide from top
RouteShifterBuilder()
  .slideFromTop()
```

#### Scale Transitions

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/scale.gif" width="250" align="right"/>

```dart
// Scale up from center
RouteShifterBuilder()
  .scale(
    beginScale: 0.0,
    endScale: 1.0,
    alignment: Alignment.center,
  )

// Scale with zoom effect
RouteShifterBuilder()
  .scaleUp()

// Scale down effect
RouteShifterBuilder()
  .scaleDown()
```

#### Rotation Transitions

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/rotate.gif" width="250" align="right"/>

```dart
// Rotate on entry
RouteShifterBuilder()
  .rotation(
    beginAngle: -0.5,
    endAngle: 0.0,
    alignment: Alignment.center,
  )

// Spin effect
RouteShifterBuilder()
  .rotation(beginAngle: -6.28) // Full rotation
```

### 🔵 Advanced Effects

#### Blur Transitions
```dart
// Blur in effect
RouteShifterBuilder()
  .blur(
    beginSigma: 10.0,
    endSigma: 0.0,
    duration: Duration(milliseconds: 600),
  )

// Backdrop blur
RouteShifterBuilder()
  .blur(
    beginSigma: 0.0,
    endSigma: 5.0,
    tileMode: TileMode.clamp,
  )
```

#### Shear Transformations

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/shear.gif" width="250" align="right"/>

```dart
// Shear effect
RouteShifterBuilder()
  .shear(
    beginShear: Offset(0.0, 0.0),
    endShear: Offset(0.2, 0.0),
    duration: Duration(milliseconds: 500),
  )
```

#### Perspective 3D

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/perspective_fade.gif" width="250" align="right"/>

```dart
// 3D perspective flip
RouteShifterBuilder()
  .perspective(
    rotationX: 0.3,
    rotationY: 0.0,
    distance: 2.0,
  )
```

#### Sequenced Animations

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/sequenced.gif" width="250" align="right"/>

```dart
// Manual timing control
RouteShifterBuilder()
  .sequenced(
    timings: {
      'header': Duration(milliseconds: 0),
      'content': Duration(milliseconds: 200),
      'footer': Duration(milliseconds: 400),
    },
    baseEffect: SlideEffect(begin: Offset(0, 0.3)),
  )

// Use with SequencedItem widgets
SequencedItem(
  id: 'header',
  child: Text('Animated Header'),
)
```

### 🟡 Creative Effects

#### Glass Morphism

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/glass.gif" width="250" align="right"/>

```dart
// Glass effect
RouteShifterBuilder()
  .glass(
    blur: 20.0,
    opacity: 0.1,
    duration: Duration(milliseconds: 800),
  )
```

#### Glitch Effect

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/glitch.gif" width="250" align="right"/>

```dart
// Digital glitch
RouteShifterBuilder()
  .glitch(
    intensity: 0.5,
    duration: Duration(milliseconds: 600),
  )
```

#### Color Tint

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/tint.gif" width="250" align="right"/>

```dart
// Color overlay transition
RouteShifterBuilder()
  .colorTint(
    beginColor: Colors.blue.withOpacity(0.8),
    endColor: Colors.transparent,
  )
```

#### Parallax Effect
```dart
// Parallax scroll effect
RouteShifterBuilder()
  .parallax(
    offset: Offset(0.0, 0.5),
    intensity: 0.7,
  )
```

#### Follow Path
```dart
// Follow custom path
RouteShifterBuilder()
  .followPath(
    path: customPath,
    duration: Duration(milliseconds: 1000),
  )
```

#### Mask Effect

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/mask.gif" width="250" align="right"/>

```dart
// Mask transition
RouteShifterBuilder()
  .mask(
    shape: MaskShape.circle,
    alignment: Alignment.center,
  )
```

#### Clip Path

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/clip.gif" width="250" align="right"/>

```dart
// Custom clip transition
RouteShifterBuilder()
  .clipPath(
    clipper: CustomClipPath(),
    duration: Duration(milliseconds: 700),
  )
```

### 🟠 Physics-Based

#### Spring Physics
```dart
// Spring bounce effect
RouteShifterBuilder()
  .spring(
    mass: 1.0,
    stiffness: 100.0,
    damping: 10.0,
  )
```

### 🔴 Platform Presets

#### Material Design

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/material.gif" width="250" align="right"/>

```dart
// Material 3 preset
RouteShifterBuilder()
  .materialPreset(MaterialTransition.slideUp)

// Available Material presets:
// - MaterialTransition.slideUp
// - MaterialTransition.fadeThrough  
// - MaterialTransition.sharedAxis
// - MaterialTransition.container
```

#### Cupertino (iOS)

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/cupertino.gif" width="250" align="right"/>

```dart
// iOS-style preset
RouteShifterBuilder()
  .cupertinoPreset(CupertinoTransition.rightToLeft)

// Available Cupertino presets:
// - CupertinoTransition.rightToLeft
// - CupertinoTransition.bottomToTop
// - CupertinoTransition.modalPresent
// - CupertinoTransition.pageReplace
```

#### Cupertino Modal

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/cupertino_modal.gif" width="250" align="right"/>

```dart
// iOS modal presentation
RouteShifterBuilder()
  .cupertinoModal(
    presentationStyle: ModalPresentationStyle.pageSheet,
    duration: Duration(milliseconds: 400),
  )
```

### 🟣 Combinations

<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/shared.gif" width="250" align="right"/>

#### Slide + Fade
```dart
RouteShifterBuilder()
  .slideAndFade(
    slideBegin: Offset(1.0, 0.0),
    fadeBegin: 0.0,
  )
```

#### Scale + Fade
```dart
RouteShifterBuilder()
  .scaleAndFade(
    scaleBegin: 0.8,
    fadeBegin: 0.0,
  )
```

#### Rotation + Scale
```dart
RouteShifterBuilder()
  .rotationAndScale(
    rotationBegin: -0.5,
    scaleBegin: 0.0,
  )
```

#### Slide + Rotation
```dart
RouteShifterBuilder()
  .slideAndRotation(
    slideBegin: Offset(1.0, 0.0),
    rotationBegin: 0.5,
  )
```

#### Complex Combination
```dart
RouteShifterBuilder()
  .complexTransition(
    slideBegin: Offset(0.0, 1.0),
    scaleBegin: 0.8,
    fadeBegin: 0.0,
    rotationBegin: 0.1,
  )
```

## 🔧 Advanced Usage

### Chaining Multiple Effects

```dart
// Chain multiple effects together
final route = RouteShifterBuilder()
  .fade(duration: Duration(milliseconds: 200))
  .slide(beginOffset: Offset(1.0, 0.0))
  .scale(beginScale: 0.8)
  .rotation(beginAngle: 0.1)
  .toRoute(page: NextPage());

Navigator.of(context).push(route);
```

### Custom Timing and Curves

```dart
RouteShifterBuilder()
  .fade(
    duration: Duration(milliseconds: 800),
    curve: Curves.elasticOut,
  )
  .slide(
    duration: Duration(milliseconds: 600),
    curve: Curves.fastOutSlowIn,
  )
```

### Interactive Dismiss Gestures

```dart
RouteShifterBuilder()
  .fade()
  .slide()
  .enableDismissGesture(
    direction: DismissDirection.horizontal,
    sensitivity: 0.3,
  )
```

## 🎯 Performance Tips

- Use `const` constructors where possible
- Prefer shorter animation durations for better UX
- Combine related effects rather than chaining many separate ones
- Use `builder` patterns for complex animations

## 📱 Platform Support

- ✅ iOS 9.0+
- ✅ Android API 16+
- ✅ Web
- ✅ macOS 10.11+
- ✅ Windows 7+
- ✅ Linux

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Community contributors and testers
- Inspiration from various animation libraries

---

Made with ❤️ for the Flutter community
