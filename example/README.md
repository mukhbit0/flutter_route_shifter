# Flutter Route Shifter Examples

This directory contains examples demonstrating the various features of the Flutter Route Shifter package.

## Examples Overview

### Basic Usage Examples
- **main.dart**: Comprehensive demo with all transition types
- **shared_element_advanced_demo.dart**: Advanced shared element transitions

### Quick Start Examples

#### Simple Fade Transition
```dart
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

void navigateToPage() {
  final route = RouteShifterBuilder()
    .fade(duration: Duration(milliseconds: 300))
    .toRoute(page: NextPage());
  
  Navigator.of(context).push(route);
}
```

#### Multi-Effect Transition
```dart
void complexTransition() {
  final route = RouteShifterBuilder()
    .slideFromRight()
    .fade(start: 0.3)
    .scale(beginScale: 0.9)
    .toRoute(page: NextPage());
  
  Navigator.of(context).push(route);
}
```

#### Creative Path Animation
```dart
void heartPathAnimation() {
  final route = RouteShifterBuilder()
    .heartPath(size: 150.0, center: Offset(200, 300))
    .fade()
    .toRoute(page: LovePage());
  
  Navigator.of(context).push(route);
}
```

## Running the Examples

1. Navigate to the root directory of the package
2. Run `flutter pub get` to install dependencies
3. Use `flutter run` to run the example app
4. Explore different transition effects in the demo

## Key Features Demonstrated

- ✨ Basic effects (fade, slide, scale, rotation, blur)
- 🎪 Creative effects (heart, spiral, wave paths)
- 🌊 Parallax and advanced geometry effects
- 📱 Platform-specific presets
- 👆 Interactive dismiss gestures
- 🚀 Shared element transitions
- ⏱️ Advanced timing control
