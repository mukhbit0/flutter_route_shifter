# Flutter Route Shifter

A powerful, declarative route transition package with chainable animations, shared elements, and advanced effects for Flutter applications.

[![pub package](https://img.shields.io/pub/v/flutter_route_shifter.svg)](https://pub.dev/packages/flutter_route_shifter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.7%2B-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.1%2B-blue.svg)](https://dart.dev/)

## ✨ Features

- **🔗 Chainable API**: Intuitive `.fade().slide().scale()` syntax for combining effects
- **🎨 Rich Effects**: 50+ built-in animation effects including fade, slide, scale, rotation, blur, shear, and more
- **🚀 Shared Elements**: Hero-like transitions between pages with advanced shared element support
- **📱 Platform Presets**: Material Design and Cupertino (iOS) style transitions
- **👆 Interactive Dismiss**: Swipe-to-dismiss gestures with customizable directions
- **⏱️ Staggered Animations**: Beautiful cascading effects for lists and grids
- **🎯 Performance Optimized**: Efficient animations with minimal overhead
- **🛠️ Highly Customizable**: Custom curves, durations, and timing controls
- **🎪 Creative Effects**: Follow-path animations, parallax effects, clip-path transitions
- **📐 Advanced Geometry**: Shear, perspective, and 3D-like transformations
- **🎨 Color Effects**: Tint and color transition animations
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

// Combined effects
final route = RouteShifterBuilder()
  .slideFromRight()
  .fade()
  .scale(beginScale: 0.9)
  .toRoute(page: NextPage());

Navigator.of(context).push(route);
```

## 📖 Complete Documentation

### Core Effects

#### 🌟 Fade Transitions
```dart
// Basic fade
RouteShifterBuilder()
  .fade(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    beginOpacity: 0.0,
    endOpacity: 1.0,
  )

// Quick fade
RouteShifterBuilder().fadeIn()
RouteShifterBuilder().fadeOut()
```

#### 📱 Slide Transitions
```dart
// Predefined directions
RouteShifterBuilder().slideFromRight()
RouteShifterBuilder().slideFromLeft()
RouteShifterBuilder().slideFromTop()
RouteShifterBuilder().slideFromBottom()

// Custom slide
RouteShifterBuilder().slide(
  begin: Offset(1.0, 0.0), // Start position
  offsetEnd: Offset.zero,  // End position
  duration: Duration(milliseconds: 350),
  curve: Curves.easeInOut,
)

// Diagonal slides
RouteShifterBuilder().slideFromTopLeft()
RouteShifterBuilder().slideFromTopRight()
RouteShifterBuilder().slideFromBottomLeft()
RouteShifterBuilder().slideFromBottomRight()
```

#### 📏 Scale Transitions
```dart
// Basic scale
RouteShifterBuilder()
  .scale(
    beginScale: 0.8,
    endScale: 1.0,
    alignment: Alignment.center,
  )

// Predefined scale effects
RouteShifterBuilder().scaleUp()
RouteShifterBuilder().scaleDown()
RouteShifterBuilder().scaleFromCenter()
```

#### 🔄 Rotation Effects
```dart
// Simple rotation
RouteShifterBuilder().rotate(
  beginTurns: 0.0,
  endTurns: 1.0,
  alignment: Alignment.center,
)

// Combined rotation with other effects
RouteShifterBuilder()
  .rotate(beginTurns: -0.1, endTurns: 0.0)
  .scale(beginScale: 0.9)
  .fade()
```

#### 🌫️ Blur Effects
```dart
// Blur transition
RouteShifterBuilder().blur(
  beginSigma: 5.0,
  endSigma: 0.0,
  duration: Duration(milliseconds: 400),
)
```

### Advanced Effects

#### 🎪 Creative & Follow-Path Effects
```dart
// Circular path animation
RouteShifterBuilder().circularPath(
  radius: 100.0,
  startAngle: 0.0,
  sweepAngle: math.pi * 2,
  center: Offset(200, 200),
)

// Wave path
RouteShifterBuilder().wavePath(
  width: 300.0,
  height: 100.0,
  amplitude: 50.0,
  frequency: 2.0,
)

// Spiral animation
RouteShifterBuilder().spiralPath(
  maxRadius: 150.0,
  turns: 3.0,
  center: Offset.zero,
)

// Heart-shaped path
RouteShifterBuilder().heartPath(
  size: 100.0,
  center: Offset(200, 200),
)

// Figure-8 path
RouteShifterBuilder().figure8Path(
  width: 200.0,
  height: 100.0,
  center: Offset(200, 200),
)
```

#### 🌊 Parallax Effects
```dart
// Basic parallax
RouteShifterBuilder().parallax(
  intensity: 0.5,
  direction: ParallaxDirection.horizontal,
)

// Multi-layer parallax
RouteShifterBuilder().multiLayerParallax(
  layers: [
    ParallaxLayer(speed: 0.2, depth: 0.1),
    ParallaxLayer(speed: 0.5, depth: 0.5),
    ParallaxLayer(speed: 1.0, depth: 1.0),
  ],
)
```

#### ✂️ Clip Path Effects
```dart
// Circle reveal
RouteShifterBuilder().circleReveal(
  center: Offset(200, 200),
  beginRadius: 0.0,
  endRadius: 300.0,
)

// Rectangle reveal
RouteShifterBuilder().rectangleReveal(
  center: Offset(200, 200),
  beginSize: Size.zero,
  endSize: Size(400, 300),
)

// Custom path reveal
RouteShifterBuilder().customPathReveal(
  pathBuilder: (size, progress) => customPath,
)
```

#### 🎨 Color & Tint Effects
```dart
// Color tint transition
RouteShifterBuilder().colorTint(
  beginColor: Colors.transparent,
  endColor: Colors.blue.withOpacity(0.3),
)

// Gradient tint
RouteShifterBuilder().gradientTint(
  beginGradient: LinearGradient(colors: [Colors.red, Colors.blue]),
  endGradient: LinearGradient(colors: [Colors.green, Colors.yellow]),
)
```

#### 📐 Shear Effects
```dart
// Horizontal shear
RouteShifterBuilder().shear(
  beginShearX: 0.0,
  endShearX: 0.2,
  beginShearY: 0.0,
  endShearY: 0.0,
)
```

#### ⚡ Stagger Effects
```dart
// Staggered list animation
RouteShifterBuilder().stagger(
  itemCount: 5,
  delay: Duration(milliseconds: 100),
  effects: [
    StaggerEffect.fade(),
    StaggerEffect.slideFromBottom(),
  ],
)
```

### Platform Presets

#### 📱 Material Design
```dart
// Standard Material transitions
RouteShifterBuilder.materialSlideUp()
RouteShifterBuilder.materialFadeThrough()

// Using preset methods
MaterialPresets.materialPageTransition()
MaterialPresets.materialSharedAxisX()
MaterialPresets.materialSharedAxisY()
MaterialPresets.materialSharedAxisZ()
MaterialPresets.materialFadeThrough()
MaterialPresets.materialContainer()
```

#### 🍎 Cupertino (iOS)
```dart
// Standard iOS transitions
RouteShifterBuilder.cupertinoSlide()
RouteShifterBuilder.cupertinoModal()

// Using preset methods
CupertinoPresets.cupertinoPageTransition()
CupertinoPresets.cupertinoModalTransition()
CupertinoPresets.cupertinoFullscreenDialog()
```

### Interactive Features

#### 👆 Interactive Dismiss
```dart
RouteShifterBuilder()
  .slideFromRight()
  .interactiveDismiss(
    direction: DismissDirection.horizontal,
  )

// Enable/disable programmatically
RouteShifterBuilder()
  .fade()
  .enableInteractiveDismiss(direction: DismissDirection.vertical)
  .disableInteractiveDismiss()
```

#### 🚀 Shared Elements
```dart
// Basic shared elements
RouteShifterBuilder()
  .sharedElements(
    flightDuration: Duration(milliseconds: 600),
    flightCurve: Curves.easeInOutCubic,
    enableMorphing: true,
    useElevation: true,
  )

// Using Shifter widgets in your UI
Shifter(
  tag: 'hero-image',
  child: Image.asset('assets/image.png'),
)
```

### Timing and Control

#### ⏱️ Advanced Timing
```dart
RouteShifterBuilder()
  .fade(
    start: 0.0,     // Start at 0% of animation
    end: 0.3,       // End at 30% of animation
  )
  .slide(
    start: 0.2,     // Start at 20% of animation
    end: 1.0,       // End at 100% of animation
  )
```

#### 🔗 Chaining Effects
```dart
// Complex multi-effect transition
final route = RouteShifterBuilder()
  .fade(duration: Duration(milliseconds: 200))
  .slideFromRight(duration: Duration(milliseconds: 300))
  .scale(beginScale: 0.95, duration: Duration(milliseconds: 250))
  .rotate(beginTurns: -0.05, endTurns: 0.0)
  .blur(beginSigma: 2.0, endSigma: 0.0)
  .interactiveDismiss()
  .toRoute(page: MyPage());
```

## 🎯 Usage Examples

### Basic Page Navigation
```dart
// Simple navigation with fade
void navigateToPage() {
  final route = RouteShifterBuilder()
    .fade(duration: Duration(milliseconds: 300))
    .toRoute(page: DetailPage());
  
  Navigator.of(context).push(route);
}
```

### Complex Transition Combinations
```dart
// Multi-effect transition
void navigateWithComplexTransition() {
  final route = RouteShifterBuilder()
    .slideFromRight(duration: Duration(milliseconds: 400))
    .fade(
      beginOpacity: 0.0,
      endOpacity: 1.0,
      start: 0.3, // Start fade at 30% of animation
    )
    .scale(
      beginScale: 0.9,
      duration: Duration(milliseconds: 350),
    )
    .blur(
      beginSigma: 5.0,
      endSigma: 0.0,
      duration: Duration(milliseconds: 300),
    )
    .interactiveDismiss(direction: DismissDirection.horizontal)
    .toRoute(page: NextPage());
  
  Navigator.of(context).push(route);
}
```

### Creative Path Animations
```dart
// Heart-shaped entrance animation
void romanticTransition() {
  final route = RouteShifterBuilder()
    .heartPath(
      size: 150.0,
      center: Offset(200, 300),
      duration: Duration(milliseconds: 1000),
    )
    .fade()
    .scale(beginScale: 0.5)
    .toRoute(page: LovePage());
  
  Navigator.of(context).push(route);
}
```

### Platform-Specific Transitions
```dart
// Adaptive transitions based on platform
void adaptiveNavigation() {
  final route = Platform.isIOS
    ? CupertinoPresets.cupertinoPageTransition()
    : MaterialPresets.materialPageTransition();
  
  Navigator.of(context).push(route.toRoute(page: NextPage()));
}
```

## 🛠️ Utility Methods

### Quick Transitions
```dart
// Utility methods for common patterns
RouteShifterUtils.quickFade()
RouteShifterUtils.quickSlide()
RouteShifterUtils.quickScale()
RouteShifterUtils.platformDefault()
```

### Builder Utilities
```dart
// Copy and modify existing builders
final baseBuilder = RouteShifterBuilder().fade().slide();
final modifiedBuilder = baseBuilder.copy().scale();

// Reset builder
builder.reset();

// Add custom effects
builder.addEffect(CustomEffect());
```

## 📚 Advanced Topics

### Custom Effects
```dart
// Creating custom effects
class CustomBounceEffect extends RouteEffect {
  // Implementation details...
}

// Using custom effects
RouteShifterBuilder()
  .addEffect(CustomBounceEffect())
  .toRoute(page: MyPage());
```

### Performance Tips
- Use `maintainState: false` for heavy pages
- Limit concurrent animations
- Use appropriate curve types for smooth animations
- Consider device capabilities when setting durations

### Best Practices
- Keep animation durations reasonable (200-500ms for most transitions)
- Use platform-appropriate presets when possible
- Test animations on various device speeds
- Provide alternative transitions for accessibility

## 🧪 Migration Guide

### From version 0.x to 1.x
The package has been completely restructured with a modular architecture:

```dart
// Old API (0.x)
RouteShifter.fade().slide().toRoute(page: MyPage())

// New API (1.x)
RouteShifterBuilder().fade().slide().toRoute(page: MyPage())
```

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Development Setup
```bash
git clone https://github.com/yourorg/flutter_route_shifter.git
cd flutter_route_shifter
flutter pub get
flutter test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Community contributors and testers
- Inspiration from various animation libraries

## 📞 Support

- 📧 Email: support@yourorg.com
- 🐛 Issues: [GitHub Issues](https://github.com/yourorg/flutter_route_shifter/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/yourorg/flutter_route_shifter/discussions)

---

Made with ❤️ by the Flutter Route Shifter team
  .fade()
  .scale(beginScale: 0.9)
  .toRoute(page: NextPage());

Navigator.of(context).push(route);
```

## 📖 Documentation

### Basic Effects

#### Fade Transition
```dart
RouteShifterBuilder()
  .fade(
    duration: 300.ms,
    curve: Curves.easeInOut,
    beginOpacity: 0.0,
    endOpacity: 1.0,
  )
```

#### Slide Transitions
```dart
// From different directions
RouteShifterBuilder().slideFromRight()
RouteShifterBuilder().slideFromLeft()
RouteShifterBuilder().slideFromTop()
RouteShifterBuilder().slideFromBottom()

// Custom slide
RouteShifterBuilder().slide(
  begin: Offset(1.0, 0.0), // Start position
  end: Offset.zero,        // End position
  duration: 350.ms,
  curve: Curves.easeInOut,
)
```

#### Scale Transitions
```dart
RouteShifterBuilder()
  .scale(
    beginScale: 0.8,
    endScale: 1.0,
    alignment: Alignment.center,
  )

// Predefined scale effects
RouteShifterBuilder().scaleUp()
RouteShifterBuilder().pop()  // Bouncy scale
```

#### Rotation Transitions
```dart
RouteShifterBuilder()
  .rotation(
    beginTurns: 0.0,
    endTurns: 0.25, // 90 degrees
    alignment: Alignment.center,
  )

// Predefined rotations
RouteShifterBuilder().rotateClockwise(turns: 1.0)
RouteShifterBuilder().rotateCounterClockwise(turns: 0.5)
```

#### Blur Transitions
```dart
RouteShifterBuilder()
  .blur(
    beginSigma: 10.0,
    endSigma: 0.0,
    duration: 400.ms,
  )
```

### Advanced Features

#### Shared Element Transitions

Use the `Shifter` widget to mark elements for shared transitions:

```dart
// Source page
Shifter(
  shiftId: 'hero-image',
  child: Image.asset('assets/image.png'),
)

// Destination page  
Shifter(
  shiftId: 'hero-image', // Same ID
  child: Image.asset('assets/image.png'),
)

// Route with shared elements enabled
final route = RouteShifterBuilder()
  .sharedElements()
  .fade()
  .toRoute(page: DetailPage());
```

#### Interactive Dismiss Gestures

```dart
RouteShifterBuilder()
  .slideFromRight()
  .interactiveDismiss(
    direction: DismissDirection.horizontal,
  )
```

#### Staggered Animations

```dart
RouteShifterBuilder()
  .stagger(
    interval: 100.ms,
    selector: (widget) => widget is Card,
  )
  .fade()
```

### Material Design Presets

Pre-built transitions following Material Design guidelines:

```dart
// Standard Material transitions
MaterialPresets.materialPageTransition()
MaterialPresets.materialSharedAxisX()
MaterialPresets.materialSharedAxisY()
MaterialPresets.materialSharedAxisZ()
MaterialPresets.materialFadeThrough()
MaterialPresets.materialContainerTransform()
MaterialPresets.materialBottomSheet()
MaterialPresets.materialDialog()

// Usage
final route = MaterialPresets.materialContainerTransform()
  .toRoute(page: NextPage());
```

### Cupertino (iOS) Presets

iOS-style transitions:

```dart
// Standard iOS transitions
CupertinoPresets.cupertinoPageTransition()
CupertinoPresets.cupertinoModalPresentation()
CupertinoPresets.cupertinoAlert()
CupertinoPresets.cupertinoActionSheet()

// Usage
final route = CupertinoPresets.cupertinoModalPresentation()
  .toRoute(page: NextPage());
```

### Custom Curves

The package includes additional curves for enhanced animations:

```dart
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

// Material Design curves
MaterialCurves.standardEasing
MaterialCurves.emphasizedEasing
MaterialCurves.emphasizedDecelerateEasing

// Cupertino curves
CupertinoCurves.easeInOut
CupertinoCurves.navigationTransition

// Custom curves
ShifterCurves.playfulBounce
ShifterCurves.dramatic
ElasticCurves.light
```

### Extension Methods

Convenient extensions for common patterns:

```dart
// Duration extensions
300.ms  // Duration(milliseconds: 300)
2.s     // Duration(seconds: 2)

// Navigation extensions
context.pushMaterial(NextPage())
context.pushCupertino(NextPage(), preset: 'modal')

// Widget extensions
myWidget.asShifter(shiftId: 'my-hero')
myWidget.asStringShifter('hero-id')
```

## 🎨 Examples

### Complex Animation Chain

```dart
final route = RouteShifterBuilder()
  .slideFromRight(duration: 400.ms, curve: Curves.easeOut)
  .fade(duration: 300.ms, start: 0.0, end: 0.5)
  .scale(beginScale: 0.95, duration: 400.ms, start: 0.2)
  .blur(beginSigma: 5.0, endSigma: 0.0, duration: 200.ms)
  .interactiveDismiss()
  .toRoute(page: NextPage());

Navigator.of(context).push(route);
```

### Shared Element with Custom Animation

```dart
// List page
ListView.builder(
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, index),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            color: colors[index],
          ).asStringShifter('card-$index'),
          title: Text('Item $index'),
        ),
      ),
    );
  },
)

// Detail page
Scaffold(
  body: Center(
    child: Container(
      width: 200,
      height: 200,
      color: color,
    ).asStringShifter('card-$index'),
  ),
)

// Navigation
void _navigateToDetail(BuildContext context, int index) {
  final route = RouteShifterBuilder()
    .sharedElements(
      flightDuration: 600.ms,
      flightCurve: Curves.easeInOutCubic,
    )
    .fade(duration: 400.ms)
    .toRoute(page: DetailPage(index: index));
    
  Navigator.of(context).push(route);
}
```

### Staggered List Animation

```dart
class StaggeredListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: items.map((item) => 
          Card(
            child: ListTile(title: Text(item.title)),
          )
        ).toList(),
      ),
    );
  }
}

// Navigate with stagger
final route = RouteShifterBuilder()
  .stagger(
    interval: 80.ms,
    selector: (widget) => widget is Card,
  )
  .slideFromBottom(duration: 600.ms)
  .fade(duration: 400.ms)
  .toRoute(page: StaggeredListPage());
```

## 🔧 Advanced Configuration

### Custom Effects

Create your own effects by extending `RouteEffect`:

```dart
class CustomEffect extends RouteEffect {
  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.custom(
          // Your custom transformation
          child: child,
        );
      },
    );
  }
  
  @override
  CustomEffect copyWith({...}) {
    // Implementation
  }
}
```

### Performance Tips

1. **Limit concurrent animations**: Avoid too many effects on complex pages
2. **Use appropriate durations**: 200-400ms for most transitions
3. **Prefer transforms over rebuilds**: Effects use efficient Flutter transitions
4. **Test on devices**: Always test animations on target devices

## 🐛 Troubleshooting

### Common Issues

**Shared elements not working:**
- Ensure both pages have `Shifter` widgets with the same `shiftId`
- Enable shared elements in the route: `.sharedElements()`

**Performance issues:**
- Reduce animation duration or complexity
- Limit the number of simultaneous effects
- Use `maintainState: false` for heavy pages

**Interactive dismiss not responding:**
- Ensure the route has `.interactiveDismiss()` enabled
- Check that gestures aren't being consumed by child widgets

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by Flutter's built-in transitions
- Material Design motion guidelines
- iOS Human Interface Guidelines
- The Flutter community for feedback and contributions

---

Made with ❤️ by the Flutter community