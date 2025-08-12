# Flutter Route Shifter

<div align="center">

**A powerful, declarative route transition package with 34+ chainable animations, shared elements, and advanced effects for Flutter applications.**

[![pub package](https://img.shields.io/pub/v/flutter_route_shifter.svg)](https://pub.dev/packages/flutter_route_shifter)
[![License: BSD-3](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Flutter](https://img.shields.io/badge/Flutter-3.7%2B-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.1%2B-blue.svg)](https://dart.dev/)
[![GitHub](https://img.shields.io/badge/View%20Animations-GitHub-blue.svg)](https://github.com/mukhbit0/flutter_route_animate/tree/main/animations)

> 🎥 **View Live Animations**: [See all 17 animation demos on GitHub](https://github.com/mukhbit0/flutter_route_animate/tree/main/animations) - GIFs show each transition in action!

</div>

---

## 🎬 Animation Showcase

<div align="center">
<table>
<tr>
<td align="center" width="33%">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/fade_slide.gif" width="180" height="320"/>
<br><strong>Fade + Slide</strong>
</td>
<td align="center" width="33%">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/scale.gif" width="180" height="320"/>
<br><strong>Scale Animation</strong>
</td>
<td align="center" width="33%">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/sequenced.gif" width="180" height="320"/>
<br><strong>Sequenced Effects</strong>
</td>
</tr>
<tr>
<td align="center" width="33%">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/glass.gif" width="180" height="320"/>
<br><strong>Glass Morphism</strong>
</td>
<td align="center" width="33%">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/shared.gif" width="180" height="320"/>
<br><strong>Shared Elements</strong>
</td>
<td align="center" width="33%">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/perspective_fade.gif" width="180" height="320"/>
<br><strong>3D Perspective</strong>
</td>
</tr>
</table>
</div>

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎨 **Rich Animation Library**
- **18+ Categorized Effects** - Organized for easy discovery
- **Modern Widget API** - Intuitive widget extension syntax
- **Duration Extensions** - Clean `300.ms` syntax  
- **3D Transformations** - Perspective, shear, and depth effects

### 🟢 **Basic Effects** (4)
Essential transitions: fade, slide, scale, rotation

### 🟡 **Advanced Effects** (7)  
Professional UX: blur, perspective, sequenced, shared elements

</td>
<td width="50%">

### 🚀 **Advanced Features**
- **Widget Extensions** - `MyWidget().routeShift().fadeIn()`
- **Chaining API** - Multiple effects in sequence
- **Platform Presets** - Material Design & Cupertino styles
- **Performance Optimized** - Minimal overhead, smooth 60fps

### 🔴 **Creative Effects** (7)
Artistic transitions: glass morphism, glitch, parallax, clip paths

### 📦 **Clean Architecture**
Organized exports, tree-shaking friendly, pub.dev optimized

</td>
</tr>
</table>

---

## 🚀 Quick Start

### Installation

```yaml
dependencies:
  flutter_route_shifter: ^1.0.0
```

```bash
$ flutter pub get
```

### Basic Usage

```dart
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

// Traditional Builder API
final route = RouteShifterBuilder()
  .fade(duration: 300.ms)  // New duration extension!
  .toRoute(page: NextPage());

Navigator.of(context).push(route);

// ✨ NEW: Widget Extension API (Modern chaining style!)
NextPage().routeShift()
  .fade(duration: 300.ms)
  .slide(beginOffset: Offset(1.0, 0.0))
  .scale(beginScale: 0.8)
  .push(context);  // Direct navigation

// ✨ NEW: Chaining with duration extensions
MyWidget().routeShift()
  .fadeIn(500.ms)
  .slideFromRight(400.ms)
  .scaleUp(300.ms)
  .toRoute();
```

### Quick Examples

```dart
// Basic animations
LoginPage().routeShift().fadeIn(300.ms).push(context);
ProfilePage().routeShift().slideFromBottom().push(context);
SettingsPage().routeShift().scaleUp().push(context);

// Advanced combinations
DetailPage().routeShift()
  .fade(300.ms)
  .slide(beginOffset: Offset(0.3, 0), duration: 400.ms)
  .blur(beginBlur: 0, endBlur: 10, duration: 200.ms)
  .push(context);

// Creative effects
GalleryPage().routeShift()
  .glass(blur: 20.0, duration: 800.ms)
  .clipPath(clipType: ClipPathType.circle)
  .push(context);
```

---

## 🎨 Animation Effects

Flutter Route Shifter organizes its 18+ effects into three categories for optimal discoverability:

### � **Basic Effects** - Essential transitions for everyday use
Clean, performant animations that form the foundation of most app transitions.

<details>
<summary><strong>📱 Fade Transitions</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/fade.gif" width="250"/>
</div>

```dart
// Basic fade in
RouteShifterBuilder()
  .fade(
    duration: 300.ms,  // New duration extension!
    curve: Curves.easeInOut,
  )

// Fade with opacity control
RouteShifterBuilder()
  .fade(
    beginOpacity: 0.0,
    endOpacity: 1.0,
    duration: 500.ms,
  )

// New Widget Extension API - Modern chaining style!
MyWidget().routeShift()
  .fade(duration: 300.ms)
  .toRoute()
```

</details>

<details>
<summary><strong>📱 Slide Transitions</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/slide.gif" width="250"/>
</div>

```dart
// Slide from right
RouteShifterBuilder()
  .slide(
    beginOffset: Offset(1.0, 0.0),
    duration: 300.ms,
  )

// Convenient presets
RouteShifterBuilder().slideFromBottom()
RouteShifterBuilder().slideFromLeft()
RouteShifterBuilder().slideFromTop()

// Widget extension API
MyWidget().routeShift()
  .slideFromRight(duration: 400.ms)
```

</details>

<details>
<summary><strong>📱 Scale Transitions</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/scale.gif" width="250"/>
</div>

```dart
// Scale up from center
RouteShifterBuilder()
  .scale(
    beginScale: 0.0,
    endScale: 1.0,
    alignment: Alignment.center,
  )

// Quick presets with new API
MyWidget().routeShift()
  .scaleUp(duration: 250.ms)
  .scaleDown(duration: 250.ms)
```

</details>

<details>
<summary><strong>� Rotation Transitions</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/rotate.gif" width="250"/>
</div>

```dart
// Rotate on entry
RouteShifterBuilder()
  .rotation(
    beginAngle: -0.5,
    endAngle: 0.0,
    alignment: Alignment.center,
  )

// Full spin effect with new API
MyWidget().routeShift()
  .rotation(beginAngle: -6.28, duration: 400.ms) // 2π rotation
```

</details>

</details>

---

### 🟡 **Advanced Effects** - Professional animations for enhanced UX
Sophisticated transitions that add depth and interactivity to your app.

<details>
<summary><strong>🌀 Blur Transitions</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/blur.gif" width="250"/>
</div>

```dart
// Blur effect
RouteShifterBuilder()
  .blur(
    beginBlur: 0.0,
    endBlur: 10.0,
    duration: 500.ms,
  )

// Widget extension
MyWidget().routeShift()
  .blur(endBlur: 15.0, duration: 600.ms)
```

</details>

<details>
<summary><strong>🎭 Perspective 3D</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/perspective_fade.gif" width="250"/>
</div>

```dart
// 3D perspective flip
RouteShifterBuilder()
  .perspective(
    rotationX: 0.3,
    rotationY: 0.0,
    distance: 2.0,
    duration: 700.ms,
  )
```

</details>

<details>
<summary><strong>🎯 Sequenced Animations</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/sequenced.gif" width="250"/>
</div>

```dart
// Precise timing control
RouteShifterBuilder()
  .sequenced(
    items: [
      SequencedItem(id: 'header', delay: 0.ms),
      SequencedItem(id: 'content', delay: 200.ms),
      SequencedItem(id: 'footer', delay: 400.ms),
    ],
    staggerDuration: 100.ms,
  )
```

</details>

<details>
<summary><strong>🔄 Shear Transform</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/shear.gif" width="250"/>
</div>

```dart
// Shear effect
RouteShifterBuilder()
  .shear(
    beginShear: Offset(0.0, 0.0),
    endShear: Offset(0.2, 0.0),
    duration: 500.ms,
  )
```

</details>

<details>
<summary><strong>⭐ Shared Elements</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/shared.gif" width="250"/>
</div>

```dart
// Hero-like shared element transitions
RouteShifterBuilder()
  .sharedElement(
    shiftIds: ['hero-image', 'hero-title'],
    flightDuration: 600.ms,
    flightCurve: Curves.fastLinearToSlowEaseIn,
  )
```

</details>

<details>
<summary><strong>🌊 Stagger Effects</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/stagger.gif" width="250"/>
</div>

```dart
// Staggered child animations
RouteShifterBuilder()
  .stagger(
    interval: 100.ms,
    childSelector: (index) => index < 5, // First 5 children
    childEffect: SlideEffect(beginOffset: Offset(0, 20)),
  )
```

</details>

<details>
<summary><strong>⚡ Physics Spring</strong></summary>

```dart
// Spring physics
RouteShifterBuilder()
  .physicsSpring(
    spring: SpringDescription(
      mass: 1.0,
      stiffness: 500.0,
      damping: 20.0,
    ),
  )
```

</details>

---

### 🔴 **Creative Effects** - Experimental and artistic transitions
Eye-catching animations that make your app memorable and unique.

<details>
<summary><strong>🌟 Glass Morphism</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/glass.gif" width="250"/>
</div>

```dart
// Glass effect
RouteShifterBuilder()
  .glass(
    blur: 20.0,
    opacity: 0.1,
    duration: 800.ms,
  )

// Widget extension
MyWidget().routeShift()
  .glass(blur: 25.0, opacity: 0.15)
```

</details>

<details>
<summary><strong>✂️ Clip Path</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/clip.gif" width="250"/>
</div>

```dart
// Geometric reveal animations
RouteShifterBuilder()
  .clipPath(
    clipType: ClipPathType.circle,
    direction: ClipDirection.centerOut,
    duration: 800.ms,
  )

// Different shapes
MyWidget().routeShift()
  .clipPath(clipType: ClipPathType.diamond)
  .clipPath(clipType: ClipPathType.star)
```

</details>

<details>
<summary><strong>🎨 Color Tint</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/tint.gif" width="250"/>
</div>

```dart
// Color overlay transitions
RouteShifterBuilder()
  .colorTint(
    color: Colors.blue.withOpacity(0.3),
    blendMode: BlendMode.overlay,
    duration: 600.ms,
  )
```

</details>

<details>
<summary><strong>⚡ Glitch Effect</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/glitch.gif" width="250"/>
</div>

```dart
// Digital glitch
RouteShifterBuilder()
  .glitch(
    intensity: 0.1,
    frequency: 8,
    duration: 1000.ms,
  )
```

</details>

<details>
<summary><strong>🌌 Parallax</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/parallax.gif" width="250"/>
</div>

```dart
// Multi-layer parallax
RouteShifterBuilder()
  .parallax(
    direction: ParallaxDirection.horizontal,
    intensity: 0.5,
    layers: 3,
  )
```

</details>

<details>
<summary><strong>🛤️ Follow Path</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/path.gif" width="250"/>
</div>

```dart
// Custom path animation
RouteShifterBuilder()
  .followPath(
    path: Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(100, -50, 200, 0),
    duration: 1.2.s,
  )
```

</details>

<details>
<summary><strong>🎭 Mask Effect</strong></summary>

```dart
// Mask-based reveals
RouteShifterBuilder()
  .mask(
    maskWidget: Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [Colors.transparent, Colors.black]),
      ),
    ),
    duration: 800.ms,
  )
```

</details>

---

### 🔹 Advanced Effects

<details>
<summary><strong>🌟 Sequenced Animations</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/sequenced.gif" width="250"/>
</div>

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

</details>

---

### 🔹 Creative Effects

<details>
<summary><strong>⚡ Glitch Effect</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/glitch.gif" width="250"/>
</div>

```dart
// Digital glitch
RouteShifterBuilder()
  .glitch(
    intensity: 0.5,
    duration: Duration(milliseconds: 600),
  )
```

</details>

<details>
<summary><strong>⚡ Color Tint</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/tint.gif" width="250"/>
</div>

```dart
// Color overlay transition
RouteShifterBuilder()
  .colorTint(
    beginColor: Colors.blue.withOpacity(0.8),
    endColor: Colors.transparent,
  )
```

</details>

<details>
<summary><strong>⚡ Mask Transition</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/mask.gif" width="250"/>
</div>

```dart
// Mask transition
RouteShifterBuilder()
  .mask(
    shape: MaskShape.circle,
    alignment: Alignment.center,
  )
```

</details>

<details>
<summary><strong>⚡ Clip Path</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/clip.gif" width="250"/>
</div>

```dart
// Custom clip transition
RouteShifterBuilder()
  .clipPath(
    clipper: CustomClipPath(),
    duration: Duration(milliseconds: 700),
  )
```

</details>

---

### 🔹 Platform Presets

<details>
<summary><strong>📱 Material Design</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/material.gif" width="250"/>
</div>

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

</details>

<details>
<summary><strong>🍎 Cupertino (iOS)</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/cupertino.gif" width="250"/>
</div>

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

</details>

<details>
<summary><strong>🍎 Cupertino Modal</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/cupertino_modal.gif" width="250"/>
</div>

```dart
// iOS modal presentation
RouteShifterBuilder()
  .cupertinoModal(
    presentationStyle: ModalPresentationStyle.pageSheet,
    duration: Duration(milliseconds: 400),
  )
```

</details>

---

### 🔹 Effect Combinations

<details>
<summary><strong>🔗 Popular Combinations</strong></summary>

<br>

<div align="center">
<img src="https://raw.githubusercontent.com/mukhbit0/flutter_route_animate/main/animations/shared.gif" width="250"/>
</div>

```dart
// Slide + Fade
RouteShifterBuilder()
  .slideAndFade(
    slideBegin: Offset(1.0, 0.0),
    fadeBegin: 0.0,
  )

// Scale + Fade
RouteShifterBuilder()
  .scaleAndFade(
    scaleBegin: 0.8,
    fadeBegin: 0.0,
  )

// Rotation + Scale
RouteShifterBuilder()
  .rotationAndScale(
    rotationBegin: -0.5,
    scaleBegin: 0.0,
  )

// Complex combination
RouteShifterBuilder()
  .complexTransition(
    slideBegin: Offset(0.0, 1.0),
    scaleBegin: 0.8,
    fadeBegin: 0.0,
    rotationBegin: 0.1,
  )
```

</details>

---

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

### Additional Effects

<details>
<summary>Click to see more effects</summary>

```dart
// Blur transitions
RouteShifterBuilder()
  .blur(
    beginSigma: 10.0,
    endSigma: 0.0,
    duration: Duration(milliseconds: 600),
  )

// Parallax effect
RouteShifterBuilder()
  .parallax(
    offset: Offset(0.0, 0.5),
    intensity: 0.7,
  )

// Follow path animation
RouteShifterBuilder()
  .followPath(
    path: customPath,
    duration: Duration(milliseconds: 1000),
  )

// Spring physics
RouteShifterBuilder()
  .spring(
    mass: 1.0,
    stiffness: 100.0,
    damping: 10.0,
  )
```

</details>

---

## 🎯 Performance Tips

- ✅ Use `const` constructors where possible
- ✅ Prefer shorter animation durations for better UX (200-400ms)
- ✅ Combine related effects rather than chaining many separate ones
- ✅ Use `builder` patterns for complex animations
- ✅ Test on lower-end devices to ensure smooth performance

---

## 📱 Platform Support

<div align="center">

| Platform | Version | Status |
|----------|---------|---------|
| 🤖 **Android** | API 16+ | ✅ Fully Supported |
| 🍎 **iOS** | 9.0+ | ✅ Fully Supported |
| 🌐 **Web** | Modern Browsers | ✅ Fully Supported |
| 🖥️ **macOS** | 10.11+ | ✅ Fully Supported |
| 🪟 **Windows** | 7+ | ✅ Fully Supported |
| 🐧 **Linux** | All Distros | ✅ Fully Supported |

</div>

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **🐛 Report Bugs** - Found an issue? [Create an issue](https://github.com/mukhbit0/flutter_route_shifter/issues)
2. **💡 Suggest Features** - Have an idea? We'd love to hear it!
3. **📝 Improve Documentation** - Help make our docs better
4. **🔧 Submit Pull Requests** - Read our [Contributing Guide](CONTRIBUTING.md)

---

## 📄 License

This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- 💙 **Flutter Team** - For the incredible framework
- 🌟 **Community Contributors** - Thank you for your support and feedback
- 🎨 **Design Inspiration** - Various animation libraries and design systems

---

<div align="center">

**Made with ❤️ for the Flutter community**

[⭐ Star us on GitHub](https://github.com/mukhbit0/flutter_route_shifter) | [📦 View on pub.dev](https://pub.dev/packages/flutter_route_shifter) | [📚 Documentation](https://github.com/mukhbit0/flutter_route_shifter/wiki)

</div>
