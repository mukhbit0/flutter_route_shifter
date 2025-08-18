# 🔗 go_router Integration Guide

Flutter Route Shifter provides seamless integration with the popular `go_router` package, allowing you to use all the beautiful animations with declarative routing.

## 🚀 Quick Start

### Installation

First, add both packages to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_route_shifter: ^1.0.2
  go_router: ^14.2.0  # or latest version
```

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/details',
      pageBuilder: (context, state) {
        // Create your animation
        return RouteShifterBuilder()
          .fade(duration: 400.ms)
          .slideFromRight()
          .toPage(child: DetailsPage());
      },
    ),
  ],
);
```

## 🎨 Integration Methods

### Method 1: RouteShifterPage (Recommended)

The simplest approach using the built-in `RouteShifterPage`:

```dart
GoRoute(
  path: '/profile',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .fade(duration: 300.ms)
      .scale(beginScale: 0.8)
      .toPage(child: ProfilePage());
  },
),
```

### Method 2: Direct Page Creation

For more control, create the page directly:

```dart
GoRoute(
  path: '/settings',
  pageBuilder: (context, state) {
    final shifter = RouteShifterBuilder()
      .glass(blur: 20.0, duration: 800.ms)
      .slideFromBottom();
    
    return RouteShifterPage(
      shifter: shifter,
      child: SettingsPage(),
      key: state.pageKey,
      name: 'settings',
    );
  },
),
```

### Method 3: CustomTransitionPage (Advanced)

For maximum compatibility with complex go_router setups:

```dart
GoRoute(
  path: '/gallery',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .parallax(direction: ParallaxDirection.horizontal)
      .clipPath(clipType: ClipPathType.circle)
      .toCustomPage(child: GalleryPage());
  },
),
```

## 🌟 Real-World Examples

### Example 1: E-commerce App with Category Animations

```dart
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/category/:id',
      pageBuilder: (context, state) {
        final categoryId = state.pathParameters['id']!;
        
        // Different animations for different categories
        RouteShifterBuilder shifter;
        switch (categoryId) {
          case 'electronics':
            shifter = RouteShifterBuilder()
              .glitch(intensity: 0.05, duration: 500.ms);
            break;
          case 'fashion':
            shifter = RouteShifterBuilder()
              .glass(blur: 15.0, duration: 600.ms)
              .slideFromRight();
            break;
          case 'books':
            shifter = RouteShifterBuilder()
              .clipPath(clipType: ClipPathType.diamond)
              .fade(duration: 400.ms);
            break;
          default:
            shifter = RouteShifterBuilder().fadeIn();
        }
        
        return shifter.toPage(
          child: CategoryPage(categoryId: categoryId),
        );
      },
    ),
    GoRoute(
      path: '/product/:id',
      pageBuilder: (context, state) {
        return RouteShifterBuilder()
          .sharedElement(
            shiftIds: ['product-image-${state.pathParameters['id']}'],
            flightDuration: 600.ms,
          )
          .fade(duration: 400.ms)
          .toPage(child: ProductDetailsPage(
            productId: state.pathParameters['id']!,
          ));
      },
    ),
  ],
);
```

### Example 2: Social Media App with Context-Aware Animations

```dart
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => FeedPage(),
    ),
    GoRoute(
      path: '/profile/:username',
      pageBuilder: (context, state) {
        final username = state.pathParameters['username']!;
        final fromFeed = state.uri.queryParameters['from'] == 'feed';
        
        // Different animations based on navigation source
        return RouteShifterBuilder()
          .fade(duration: 300.ms)
          .scale(
            beginScale: fromFeed ? 0.95 : 0.8,
            duration: 400.ms,
          )
          .slideFromRight(
            duration: fromFeed ? 300.ms : 500.ms,
          )
          .toPage(child: ProfilePage(username: username));
      },
    ),
    GoRoute(
      path: '/chat/:chatId',
      pageBuilder: (context, state) {
        return RouteShifterBuilder()
          .slideFromRight(duration: 250.ms)
          .fade(duration: 200.ms)
          .toPage(child: ChatPage(
            chatId: state.pathParameters['chatId']!,
          ));
      },
    ),
  ],
);
```

### Example 3: Dashboard with Tab-Based Animations

```dart
final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => DashboardShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard/analytics',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .sequenced(
                items: [
                  SequencedItem(id: 'chart-1', delay: 0.ms),
                  SequencedItem(id: 'chart-2', delay: 150.ms),
                  SequencedItem(id: 'stats', delay: 300.ms),
                ],
              )
              .fade(duration: 400.ms)
              .toPage(child: AnalyticsPage());
          },
        ),
        GoRoute(
          path: '/dashboard/reports',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .stagger(
                interval: 100.ms,
                childSelector: (index) => index < 10,
              )
              .slideFromBottom(duration: 500.ms)
              .toPage(child: ReportsPage());
          },
        ),
      ],
    ),
  ],
);
```

## 🎯 Best Practices

### 1. **Animation Consistency**
Keep animations consistent within the same flow:

```dart
// Good: Consistent slide direction for related pages
final userFlowAnimations = RouteShifterBuilder()
  .slideFromRight(duration: 300.ms)
  .fade(duration: 200.ms);

GoRoute(path: '/login', pageBuilder: (c, s) => 
  userFlowAnimations.toPage(child: LoginPage())),
GoRoute(path: '/signup', pageBuilder: (c, s) => 
  userFlowAnimations.toPage(child: SignupPage())),
```

### 2. **Performance Optimization**
Use lighter animations for frequently accessed routes:

```dart
// Lightweight animation for back navigation
GoRoute(
  path: '/back-to-main',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .fade(duration: 200.ms)  // Fast and simple
      .toPage(child: MainPage());
  },
),

// Rich animation for special features
GoRoute(
  path: '/premium-feature',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .glass(blur: 25.0, duration: 800.ms)
      .parallax(direction: ParallaxDirection.horizontal)
      .toPage(child: PremiumFeaturePage());
  },
),
```

### 3. **Conditional Animations**
Adapt animations based on context:

```dart
GoRoute(
  path: '/settings',
  pageBuilder: (context, state) {
    final isTablet = MediaQuery.of(context).size.width > 768;
    
    return RouteShifterBuilder()
      .fade(duration: 300.ms)
      .slide(
        beginOffset: isTablet 
          ? Offset(0.3, 0)  // Subtle for tablets
          : Offset(1.0, 0), // Full slide for phones
        duration: 400.ms,
      )
      .toPage(child: SettingsPage());
  },
),
```

## 🔧 Advanced Features

### Shared Elements with go_router

```dart
GoRoute(
  path: '/article/:id',
  pageBuilder: (context, state) {
    final articleId = state.pathParameters['id']!;
    
    return RouteShifterBuilder()
      .sharedElement(
        shiftIds: ['article-$articleId'],
        flightDuration: 500.ms,
        flightCurve: Curves.fastLinearToSlowEaseIn,
      )
      .fade(duration: 300.ms)
      .toPage(child: ArticlePage(id: articleId));
  },
),
```

### Custom Page Keys and Restoration

```dart
GoRoute(
  path: '/important-page',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .fade(duration: 400.ms)
      .toPage(
        child: ImportantPage(),
        key: ValueKey('important-page-${DateTime.now().millisecondsSinceEpoch}'),
        restorationId: 'important_page',
      );
  },
),
```

## 🛠️ Troubleshooting

### Issue: Animations not working with nested routes
**Solution**: Ensure each route has its own pageBuilder:

```dart
// ❌ Wrong: Missing pageBuilder
GoRoute(
  path: '/nested',
  builder: (context, state) => NestedPage(), // No animation
),

// ✅ Correct: Use pageBuilder for animations
GoRoute(
  path: '/nested',
  pageBuilder: (context, state) => RouteShifterBuilder()
    .fade()
    .toPage(child: NestedPage()),
),
```

### Issue: Performance issues with complex animations
**Solution**: Use lighter effects for frequent navigation:

```dart
// ❌ Heavy animation for common navigation
GoRoute(
  path: '/back',
  pageBuilder: (context, state) => RouteShifterBuilder()
    .glass(blur: 30.0)
    .parallax()
    .stagger()
    .toPage(child: BackPage()),
),

// ✅ Light animation for common navigation
GoRoute(
  path: '/back',
  pageBuilder: (context, state) => RouteShifterBuilder()
    .fade(duration: 200.ms)
    .toPage(child: BackPage()),
),
```

## 📚 Additional Resources

- [go_router Documentation](https://pub.dev/packages/go_router)
- [Flutter Route Shifter Examples](https://github.com/mukhbit0/flutter_route_shifter/tree/main/example)
- [Navigation Best Practices](https://docs.flutter.dev/development/ui/navigation)

---

*Happy routing with beautiful animations! 🎨✨*
