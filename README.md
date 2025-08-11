# Flutter Route Shifter

A powerful and intuitive Flutter package for creating beautiful page transitions and shared element animations.

[![pub package](https://img.shields.io/pub/v/flutter_route_shifter.svg)](https://pub.dev/packages/flutter_route_shifter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.7%2B-blue.svg)](https://flutter.dev/)

## ✨ Features

- **🔗 Chainable API**: Simple `.fade().slide().scale()` syntax
- **🎨 Rich Effects**: Fade, slide, scale, rotation, blur, and more
- **🚀 Shared Elements**: Hero-style transitions between pages  
- **📱 Platform Presets**: Material Design and Cupertino transitions
- **👆 Interactive Gestures**: Swipe-to-dismiss with custom directions
- **⚡ High Performance**: Optimized animations with minimal overhead
- **🛠️ Highly Customizable**: Custom curves, durations, and effects

## 🚀 Quick Start

### Installation

```yaml
dependencies:
  flutter_route_shifter: ^1.0.0
```

### Basic Usage

```dart
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

// Simple fade transition
final route = RouteShifterBuilder()
  .fade(duration: 300.ms)
  .toRoute(page: NextPage());

Navigator.of(context).push(route);
```

### Chaining Effects

```dart
// Combine multiple effects
final route = RouteShifterBuilder()
  .fade(duration: 400.ms)
  .slide(beginOffset: Offset(1, 0))
  .scale(beginScale: 0.8)
  .toRoute(page: NextPage());
```

### Shared Element Transitions

```dart
// Wrap elements in Shifter widgets
Shifter(
  shiftId: 'hero-image',
  child: Image.asset('assets/image.jpg'),
)

// Create shared element transition
final route = RouteShifterBuilder()
  .sharedElements(
    flightDuration: Duration(milliseconds: 600),
    enableMorphing: true,
  )
  .toRoute(page: DetailPage());
```

## 📱 Platform Presets

### Material Design

```dart
// Material slide up
RouteShifterBuilder()
  .materialSlideUp()
  .toRoute(page: NextPage());

// Material fade through
RouteShifterBuilder()
  .materialFadeThrough()
  .toRoute(page: NextPage());
```

### Cupertino (iOS)

```dart
// iOS-style slide
RouteShifterBuilder()
  .cupertinoSlide()
  .toRoute(page: NextPage());

// iOS-style modal
RouteShifterBuilder()
  .cupertinoModal()
  .toRoute(page: NextPage());
```

## 🎨 Available Effects

| Effect | Description |
|--------|-------------|
| `fade()` | Opacity transitions |
| `slide()` | Position-based sliding |
| `scale()` | Size scaling animations |
| `rotation()` | Rotation transformations |
| `blur()` | Blur effects |
| `stagger()` | Cascading animations |

## 👆 Interactive Gestures

```dart
RouteShifterBuilder()
  .fade()
  .enableInteractiveDismiss(
    direction: DismissDirection.down,
  )
  .toRoute(page: NextPage());
```

## 📖 Example App

Check out the example app for comprehensive demos:

```bash
cd example
flutter run
```

The example includes:
- Basic transition effects
- Shared element animations  
- Interactive gesture demos
- Platform-specific presets

## 🤝 Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting PRs.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Community contributors and feedback
- Inspiration from various animation libraries

---

Made with ❤️ for the Flutter community
