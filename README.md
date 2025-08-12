# Flutter Route Shifter

<div align="center">

**A powerful, declarative route transition package with 34+ chainable animations, shared elements, and advanced effects for Flutter applications.**

[![pub package](https://img.shields.io/pub/v/flutter_route_shifter.svg)](https://pub.dev/packages/flutter_route_shifter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
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
- **34+ Built-in Effects** - Complete collection of transitions
- **Chainable API** - Intuitive `.fade().slide().scale()` syntax
- **Creative Effects** - Glass, glitch, parallax, and more
- **3D Transformations** - Perspective, shear, and depth effects

</td>
<td width="50%">

### 🚀 **Advanced Features**
- **Shared Elements** - Hero-like transitions between pages
- **Platform Presets** - Material Design & Cupertino styles
- **Sequenced Animations** - Precise timing control
- **Performance Optimized** - Minimal overhead, smooth 60fps

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

// Simple fade transition
final route = RouteShifterBuilder()
  .fade(duration: Duration(milliseconds: 300))
  .toRoute(page: NextPage());

Navigator.of(context).push(route);
```

---

## 🎨 Animation Effects

### 🔹 Core Transitions

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
    duration: Duration(milliseconds: 300),
  )

// Convenient presets
RouteShifterBuilder().slideFromBottom()
RouteShifterBuilder().slideFromLeft()
RouteShifterBuilder().slideFromTop()
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

// Quick presets
RouteShifterBuilder().scaleUp()
RouteShifterBuilder().scaleDown()
```

</details>

<details>
<summary><strong>📱 Rotation Transitions</strong></summary>

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

// Full spin effect
RouteShifterBuilder()
  .rotation(beginAngle: -6.28) // 2π rotation
```

</details>

---

### 🔹 Advanced Effects

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
    duration: Duration(milliseconds: 800),
  )
```

</details>

<details>
<summary><strong>🌟 3D Perspective</strong></summary>

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
  )
```

</details>

<details>
<summary><strong>🌟 Shear Transform</strong></summary>

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
    duration: Duration(milliseconds: 500),
  )
```

</details>

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

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

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