# 🔗 go_router Integration Guide

**Complete integration guide for using Flutter Route Shifter with go_router, including deep linking, responsive animations, theme integration, and animation presets.**

---

## 📖 Table of Contents

- [🚀 Quick Start](#-quick-start)
- [🔗 Basic go_router Integration](#-basic-go_router-integration)
- [🌐 Deep Link Animations](#-deep-link-animations)
- [📱 Responsive Animations](#-responsive-animations)
- [🎨 Theme Integration](#-theme-integration)
- [📦 Animation Presets](#-animation-presets)
- [🎯 Advanced Techniques](#-advanced-techniques)
- [💡 Real-World Examples](#-real-world-examples)
- [🔧 Best Practices](#-best-practices)

---

## 🚀 Quick Start

### Installation

```yaml
dependencies:
  flutter_route_shifter: ^1.2.0
  go_router: ^14.0.0  # Latest version
```

### Basic Setup

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
      path: '/profile',
      pageBuilder: (context, state) {
        return RouteShifterBuilder()
          .fade(duration: 300.ms)
          .slideFromRight()
          .toPage(child: ProfilePage());
      },
    ),
  ],
);
```

---

## 🔗 Basic go_router Integration

### Using `.toPage()` Method

The simplest way to integrate Route Shifter with go_router:

```dart
GoRoute(
  path: '/details/:id',
  pageBuilder: (context, state) {
    final id = state.pathParameters['id']!;
    
    return RouteShifterBuilder()
      .fade(duration: 400.ms)
      .slideFromRight()
      .toPage(child: DetailsPage(id: id));
  },
),
```

### Using `.toCustomPage()` Method

For advanced scenarios requiring more control:

```dart
GoRoute(
  path: '/settings',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .glassMorph(endBlur: 20.0)
      .scale(beginScale: 0.95)
      .toCustomPage(
        child: SettingsPage(),
        settings: RouteSettings(name: '/settings'),
      );
  },
),
```

### Complete Router Configuration

```dart
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // Home route - no animation
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    
    // Profile with elegant glass effect
    GoRoute(
      path: '/profile/:userId',
      pageBuilder: (context, state) {
        final userId = state.pathParameters['userId']!;
        
        return RouteShifterBuilder()
          .glassMorph(endBlur: 20.0, duration: 500.ms)
          .fade(duration: 300.ms)
          .toPage(child: ProfilePage(userId: userId));
      },
    ),
    
    // Product details with hero-like transition
    GoRoute(
      path: '/product/:productId',
      pageBuilder: (context, state) {
        final productId = state.pathParameters['productId']!;
        
        return RouteShifterBuilder()
          .scale(beginScale: 0.8, duration: 300.ms)
          .fade(duration: 250.ms)
          .toPage(child: ProductDetailsPage(productId: productId));
      },
    ),
    
    // Gallery with creative animations
    GoRoute(
      path: '/gallery',
      pageBuilder: (context, state) {
        return RouteShifterBuilder()
          .clipPath(clipType: ClipPathType.circle, duration: 600.ms)
          .parallax(direction: ParallaxDirection.horizontal)
          .toPage(child: GalleryPage());
      },
    ),
    
    // Nested routes with different animations
    GoRoute(
      path: '/shop',
      pageBuilder: (context, state) {
        return RouteShifterBuilder()
          .slideFromBottom(duration: 300.ms)
          .toPage(child: ShopPage());
      },
      routes: [
        GoRoute(
          path: 'cart',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .slideFromRight(duration: 250.ms)
              .toPage(child: CartPage());
          },
        ),
      ],
    ),
  ],
);
```

---

## 🌐 Deep Link Animations

### URL-Driven Animations

Create animations directly from URL parameters:

```dart
GoRoute(
  path: '/product/:id',
  pageBuilder: (context, state) {
    final productId = state.pathParameters['id']!;
    
    // Create animation from URL parameters
    final shifter = DeepLinkRouteShifter.fromUrl(
      state.uri,
      fallback: RouteShifterBuilder().fade(),
    );
    
    return shifter.toPage(child: ProductPage(id: productId));
  },
),
```

### Supported URL Parameters

```dart
// Example URLs and their animations:

// Basic fade
// /product/123?animation=fade&duration=300

// Glass morphism
// /product/123?animation=glass&blur=20&duration=800

// Slide transitions
// /product/123?animation=slide&direction=right&duration=400

// Scale animations
// /product/123?animation=scale&begin=0.8&end=1.0&duration=300

// Rotation effects
// /product/123?animation=rotation&begin=0.0&end=0.25&duration=500

// Parallax effects
// /product/123?animation=parallax&direction=horizontal&intensity=0.5

// Clip path reveals
// /product/123?animation=clip&shape=circle&duration=600

// Animation presets
// /product/123?animation=preset&preset=elegant

// Combination effects
// /product/123?animation=combination&effects=fade+slide+scale&duration=400
```

### Advanced Deep Link Setup

```dart
class DeepLinkRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        // Marketing landing pages with custom animations
        GoRoute(
          path: '/campaign/:campaignId',
          pageBuilder: (context, state) {
            final campaignId = state.pathParameters['campaignId']!;
            
            // Special animations for marketing campaigns
            final animationUrl = DeepLinkPresets.getMarketingUrl(
              '/campaign/$campaignId',
              'hero', // Use hero preset for campaigns
            );
            
            final shifter = DeepLinkRouteShifter.fromUrl(
              Uri.parse(animationUrl),
              fallback: RouteShifterPresets.elegant(),
            );
            
            return shifter.toPage(child: CampaignPage(id: campaignId));
          },
        ),
        
        // A/B testing with different animation variants
        GoRoute(
          path: '/ab-test/:variant',
          pageBuilder: (context, state) {
            final variant = state.pathParameters['variant']!;
            
            final animationUrl = DeepLinkPresets.getABTestUrl(
              '/ab-test/$variant',
              'variant_$variant',
            );
            
            final shifter = DeepLinkRouteShifter.fromUrl(
              Uri.parse(animationUrl),
            );
            
            return shifter.toPage(child: ABTestPage(variant: variant));
          },
        ),
        
        // Dynamic animation from API/Database
        GoRoute(
          path: '/dynamic/:configId',
          pageBuilder: (context, state) async {
            final configId = state.pathParameters['configId']!;
            
            // Fetch animation configuration from API
            final animationConfig = await ApiService.getAnimationConfig(configId);
            final shifter = DeepLinkRouteShifter.fromJson(animationConfig);
            
            return shifter.toPage(child: DynamicPage(configId: configId));
          },
        ),
      ],
    );
  }
}
```

### JSON Animation Configurations

```dart
// Store complex animations as JSON
final animationJson = '''
{
  "type": "combination",
  "effects": [
    {
      "type": "fade",
      "duration": 300
    },
    {
      "type": "scale",
      "begin": 0.8,
      "end": 1.0,
      "duration": 400
    },
    {
      "type": "slide",
      "direction": "right",
      "duration": 350
    }
  ]
}
''';

// Use in go_router
GoRoute(
  path: '/json-animation',
  pageBuilder: (context, state) {
    final shifter = DeepLinkRouteShifter.fromJson(animationJson);
    return shifter.toPage(child: JsonAnimationPage());
  },
),
```

---

## 📱 Responsive Animations

### Adaptive Animations Based on Screen Size

```dart
GoRoute(
  path: '/responsive',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .buildResponsive(
        context,
        mobile: (builder) => builder
          .slideFromBottom(duration: 300.ms)
          .fade(duration: 250.ms),
        tablet: (builder) => builder
          .scale(beginScale: 0.9, duration: 350.ms)
          .fade(duration: 300.ms),
        desktop: (builder) => builder
          .glassMorph(endBlur: 15.0, duration: 400.ms)
          .fade(duration: 200.ms),
      )
      .toPage(child: ResponsivePage());
  },
),
```

### Orientation-Adaptive Animations

```dart
GoRoute(
  path: '/orientation-adaptive',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .orientationAdaptive(
        context,
        portrait: (builder) => builder.slideFromBottom(),
        landscape: (builder) => builder.slideFromRight(),
      )
      .toPage(child: OrientationPage());
  },
),
```

### Complete Responsive Router

```dart
class ResponsiveRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        // Home with platform-adaptive animation
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .adaptive(context)
              .toPage(child: HomePage());
          },
        ),
        
        // Product grid - different animations per device
        GoRoute(
          path: '/products',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .buildResponsive(
                context,
                mobile: (b) => b.slideFromBottom().fade(),
                tablet: (b) => b.scale(beginScale: 0.95).fade(),
                desktop: (b) => b.glassMorph(endBlur: 10.0),
              )
              .toPage(child: ProductGridPage());
          },
        ),
        
        // Dashboard - desktop gets premium glass effect
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .buildResponsive(
                context,
                mobile: (b) => b.fade(duration: 250.ms),
                tablet: (b) => b.slideFromRight(duration: 300.ms),
                desktop: (b) => b
                  .glassMorph(endBlur: 20.0, duration: 500.ms)
                  .parallax(direction: ParallaxDirection.vertical),
              )
              .toPage(child: DashboardPage());
          },
        ),
      ],
    );
  }
}
```

---

## 🎨 Theme Integration

### Automatic Theme-Aware Animations

```dart
GoRoute(
  path: '/theme-aware',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .fade()
      .followPlatformTheme(context)  // Automatically adapts to iOS/Material
      .toPage(child: ThemeAwarePage());
  },
),
```

### Material 3 Integration

```dart
GoRoute(
  path: '/material',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .scale(beginScale: 0.95)
      .followMaterial3(context)  // Uses Material 3 curves and durations
      .useThemeGlass(context)    // Glass effect with theme colors
      .toPage(child: MaterialPage());
  },
),
```

### Cupertino Integration

```dart
GoRoute(
  path: '/cupertino',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .slideFromRight()
      .followCupertino(context)  // Uses iOS curves and durations
      .useThemeTint(context)     // Tint effect with theme colors
      .toPage(child: CupertinoPage());
  },
),
```

### Dynamic Theme Adaptation

```dart
class ThemeAwareRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/adaptive-theme',
          pageBuilder: (context, state) {
            // Different animations for light/dark themes
            final shifter = AdaptivePresets.themeAware(context);
            return shifter.toPage(child: AdaptiveThemePage());
          },
        ),
        
        GoRoute(
          path: '/platform-theme',
          pageBuilder: (context, state) {
            // Different animations for iOS/Android
            final shifter = AdaptivePresets.platformDefault(context);
            return shifter.toPage(child: PlatformThemePage());
          },
        ),
        
        GoRoute(
          path: '/custom-theme',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .fade()
              .useThemeGlass(context)      // Theme-aware glass
              .useThemeTint(context)       // Theme-aware tint
              .useThemeSurface(context)    // Theme-aware surface
              .toPage(child: CustomThemePage());
          },
        ),
      ],
    );
  }
}
```

---

## 📦 Animation Presets

### Industry-Specific Presets

```dart
// E-commerce routes
final ecommerceRoutes = [
  GoRoute(
    path: '/product/:id',
    pageBuilder: (context, state) {
      return RouteShifterPresets.productCard()
        .toPage(child: ProductPage(id: state.pathParameters['id']!));
    },
  ),
  GoRoute(
    path: '/cart',
    pageBuilder: (context, state) {
      return RouteShifterPresets.shoppingCart()
        .toPage(child: CartPage());
    },
  ),
  GoRoute(
    path: '/checkout',
    pageBuilder: (context, state) {
      return RouteShifterPresets.checkoutFlow()
        .toPage(child: CheckoutPage());
    },
  ),
];

// Social media routes
final socialRoutes = [
  GoRoute(
    path: '/profile/:username',
    pageBuilder: (context, state) {
      return RouteShifterPresets.socialProfile()
        .toPage(child: ProfilePage(username: state.pathParameters['username']!));
    },
  ),
  GoRoute(
    path: '/story/:id',
    pageBuilder: (context, state) {
      return RouteShifterPresets.storyViewer()
        .toPage(child: StoryPage(id: state.pathParameters['id']!));
    },
  ),
  GoRoute(
    path: '/comments/:postId',
    pageBuilder: (context, state) {
      return RouteShifterPresets.socialModal()
        .toPage(child: CommentsPage(postId: state.pathParameters['postId']!));
    },
  ),
];

// Business/productivity routes
final businessRoutes = [
  GoRoute(
    path: '/dashboard',
    pageBuilder: (context, state) {
      return RouteShifterPresets.dashboard()
        .toPage(child: DashboardPage());
    },
  ),
  GoRoute(
    path: '/document/:id',
    pageBuilder: (context, state) {
      return RouteShifterPresets.documentViewer()
        .toPage(child: DocumentPage(id: state.pathParameters['id']!));
    },
  ),
  GoRoute(
    path: '/analytics',
    pageBuilder: (context, state) {
      return RouteShifterPresets.analytics()
        .toPage(child: AnalyticsPage());
    },
  ),
];
```

### Custom Preset Combinations

```dart
// Create your own preset combinations
class CustomPresets {
  static RouteShifterBuilder premiumOnboarding() {
    return RouteShifterBuilder()
      .glassMorph(endBlur: 25.0, duration: 800.ms)
      .scale(beginScale: 0.9, duration: 600.ms)
      .parallax(direction: ParallaxDirection.vertical, backgroundSpeed: 0.3);
  }
  
  static RouteShifterBuilder gameTransition() {
    return RouteShifterBuilder()
      .rotation(beginTurns: -0.1, duration: 500.ms)
      .scale(beginScale: 0.7, duration: 600.ms)
      .fade(duration: 400.ms);
  }
  
  static RouteShifterBuilder artisticGallery() {
    return RouteShifterBuilder()
      .clipPath(clipType: ClipPathType.circle, duration: 700.ms)
      .parallax(direction: ParallaxDirection.horizontal, backgroundSpeed: 0.5)
      .glassMorph(endBlur: 15.0, duration: 500.ms);
  }
}

// Use in routes
GoRoute(
  path: '/onboarding',
  pageBuilder: (context, state) {
    return CustomPresets.premiumOnboarding()
      .toPage(child: OnboardingPage());
  },
),
```

---

## 🎯 Advanced Techniques

### Conditional Animations Based on Route Data

```dart
GoRoute(
  path: '/content/:type/:id',
  pageBuilder: (context, state) {
    final type = state.pathParameters['type']!;
    final id = state.pathParameters['id']!;
    final isFirstVisit = state.uri.queryParameters['first'] == 'true';
    
    RouteShifterBuilder shifter;
    
    switch (type) {
      case 'video':
        shifter = isFirstVisit
          ? RouteShifterPresets.mediaPlayer()
          : RouteShifterBuilder().fade(duration: 200.ms);
        break;
      case 'article':
        shifter = RouteShifterPresets.documentViewer();
        break;
      case 'gallery':
        shifter = RouteShifterPresets.artGallery();
        break;
      default:
        shifter = RouteShifterBuilder().fade();
    }
    
    return shifter.toPage(child: ContentPage(type: type, id: id));
  },
),
```

### Animation Chaining with State Management

```dart
class AnimatedRouter {
  static GoRouter createRouter(AnimationState animationState) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/stateful',
          pageBuilder: (context, state) {
            // Animations based on app state
            final shifter = animationState.isHighPerformanceMode
              ? RouteShifterBuilder().fade(duration: 150.ms)
              : RouteShifterBuilder()
                  .glassMorph(endBlur: 20.0)
                  .parallax(direction: ParallaxDirection.horizontal);
            
            return shifter.toPage(child: StatefulPage());
          },
        ),
      ],
    );
  }
}
```

### Error Route Animations

```dart
final router = GoRouter(
  routes: [...],
  errorPageBuilder: (context, state) {
    return RouteShifterBuilder()
      .scale(beginScale: 0.8)
      .fade(duration: 300.ms)
      .toPage(
        child: ErrorPage(error: state.error.toString()),
      );
  },
);
```

---

## 💡 Real-World Examples

### E-commerce App Router

```dart
class EcommerceRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        // Splash screen - no animation
        GoRoute(
          path: '/',
          builder: (context, state) => SplashPage(),
        ),
        
        // Home with subtle entrance
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) {
            return RouteShifterPresets.subtle()
              .toPage(child: HomePage());
          },
        ),
        
        // Product category - slide from bottom
        GoRoute(
          path: '/category/:categoryId',
          pageBuilder: (context, state) {
            final categoryId = state.pathParameters['categoryId']!;
            
            return RouteShifterBuilder()
              .slideFromBottom(duration: 300.ms)
              .fade(duration: 250.ms)
              .toPage(child: CategoryPage(categoryId: categoryId));
          },
        ),
        
        // Product details - hero-like transition
        GoRoute(
          path: '/product/:productId',
          pageBuilder: (context, state) {
            final productId = state.pathParameters['productId']!;
            final fromCart = state.uri.queryParameters['from'] == 'cart';
            
            final shifter = fromCart
              ? RouteShifterBuilder().slideFromLeft()
              : RouteShifterPresets.productCard();
            
            return shifter.toPage(child: ProductDetailsPage(productId: productId));
          },
        ),
        
        // Shopping cart - bottom slide with glass
        GoRoute(
          path: '/cart',
          pageBuilder: (context, state) {
            return RouteShifterPresets.shoppingCart()
              .toPage(child: CartPage());
          },
        ),
        
        // Checkout flow - professional slide
        GoRoute(
          path: '/checkout',
          pageBuilder: (context, state) {
            return RouteShifterPresets.checkoutFlow()
              .toPage(child: CheckoutPage());
          },
          routes: [
            GoRoute(
              path: 'payment',
              pageBuilder: (context, state) {
                return RouteShifterBuilder()
                  .slideFromRight(duration: 300.ms)
                  .toPage(child: PaymentPage());
              },
            ),
            GoRoute(
              path: 'confirmation',
              pageBuilder: (context, state) {
                return RouteShifterBuilder()
                  .scale(beginScale: 0.3, curve: Curves.elasticOut, duration: 800.ms)
                  .fade(duration: 400.ms)
                  .toPage(child: ConfirmationPage());
              },
            ),
          ],
        ),
        
        // User account - glass morphism
        GoRoute(
          path: '/account',
          pageBuilder: (context, state) {
            return RouteShifterBuilder()
              .glassMorph(endBlur: 20.0, duration: 500.ms)
              .fade(duration: 300.ms)
              .toPage(child: AccountPage());
          },
          routes: [
            GoRoute(
              path: 'orders',
              pageBuilder: (context, state) {
                return RouteShifterBuilder()
                  .slideFromRight()
                  .toPage(child: OrdersPage());
              },
            ),
            GoRoute(
              path: 'wishlist',
              pageBuilder: (context, state) {
                return RouteShifterBuilder()
                  .slideFromRight()
                  .toPage(child: WishlistPage());
              },
            ),
          ],
        ),
      ],
    );
  }
}
```

### Social Media App Router

```dart
class SocialMediaRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        // Feed - quick fade
        GoRoute(
          path: '/feed',
          pageBuilder: (context, state) {
            return RouteShifterPresets.feedNavigation()
              .toPage(child: FeedPage());
          },
        ),
        
        // User profile - elegant glass
        GoRoute(
          path: '/user/:username',
          pageBuilder: (context, state) {
            final username = state.pathParameters['username']!;
            
            return RouteShifterPresets.socialProfile()
              .toPage(child: UserProfilePage(username: username));
          },
        ),
        
        // Story viewer - instant
        GoRoute(
          path: '/story/:storyId',
          pageBuilder: (context, state) {
            final storyId = state.pathParameters['storyId']!;
            
            return RouteShifterPresets.storyViewer()
              .toPage(child: StoryViewerPage(storyId: storyId));
          },
        ),
        
        // Post details with comments - modal style
        GoRoute(
          path: '/post/:postId',
          pageBuilder: (context, state) {
            final postId = state.pathParameters['postId']!;
            
            return RouteShifterPresets.socialModal()
              .toPage(child: PostDetailsPage(postId: postId));
          },
        ),
        
        // Live streaming - dramatic entrance
        GoRoute(
          path: '/live/:streamId',
          pageBuilder: (context, state) {
            final streamId = state.pathParameters['streamId']!;
            
            return RouteShifterBuilder()
              .clipPath(clipType: ClipPathType.circle, duration: 600.ms)
              .fade(duration: 400.ms)
              .toPage(child: LiveStreamPage(streamId: streamId));
          },
        ),
      ],
    );
  }
}
```

### Business Dashboard Router

```dart
class BusinessDashboardRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        // Main dashboard - premium glass effect
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) {
            return RouteShifterPresets.dashboard()
              .buildResponsive(
                context,
                mobile: (b) => b.slideFromBottom(),
                tablet: (b) => b.glassMorph(endBlur: 15.0),
                desktop: (b) => b.glassMorph(endBlur: 25.0).parallax(),
              )
              .toPage(child: DashboardPage());
          },
        ),
        
        // Analytics - scale entrance for data reveal
        GoRoute(
          path: '/analytics',
          pageBuilder: (context, state) {
            return RouteShifterPresets.analytics()
              .toPage(child: AnalyticsPage());
          },
        ),
        
        // Document viewer - professional fade
        GoRoute(
          path: '/documents/:docId',
          pageBuilder: (context, state) {
            final docId = state.pathParameters['docId']!;
            
            return RouteShifterPresets.documentViewer()
              .toPage(child: DocumentViewerPage(docId: docId));
          },
        ),
        
        // Settings - clean slide
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) {
            return RouteShifterPresets.settings()
              .toPage(child: SettingsPage());
          },
        ),
      ],
    );
  }
}
```

---

## 🔧 Best Practices

### Performance Optimization

```dart
// ✅ DO: Use shorter durations for frequent transitions
GoRoute(
  path: '/frequent',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .fade(duration: 200.ms)  // Quick for frequent use
      .toPage(child: FrequentPage());
  },
),

// ✅ DO: Use longer durations for special moments
GoRoute(
  path: '/achievement',
  pageBuilder: (context, state) {
    return RouteShifterBuilder()
      .scale(beginScale: 0.3, duration: 800.ms, curve: Curves.elasticOut)
      .toPage(child: AchievementPage());
  },
),

// ✅ DO: Adapt to device capabilities
GoRoute(
  path: '/adaptive-performance',
  pageBuilder: (context, state) {
    final isLowEndDevice = DeviceInfo.isLowEnd;
    
    final shifter = isLowEndDevice
      ? RouteShifterBuilder().fade(duration: 150.ms)
      : RouteShifterBuilder().glassMorph(endBlur: 20.0);
    
    return shifter.toPage(child: AdaptivePage());
  },
),
```

### User Experience Guidelines

```dart
// ✅ DO: Match animation to content type
final contentBasedRoutes = [
  // Fast content - quick animations
  GoRoute(
    path: '/notifications',
    pageBuilder: (context, state) {
      return RouteShifterBuilder()
        .fade(duration: 150.ms)
        .toPage(child: NotificationsPage());
    },
  ),
  
  // Media content - cinematic animations
  GoRoute(
    path: '/media/:id',
    pageBuilder: (context, state) {
      return RouteShifterBuilder()
        .fade(duration: 400.ms, curve: Curves.easeInOutCubic)
        .toPage(child: MediaPage(id: state.pathParameters['id']!));
    },
  ),
  
  // Forms - gentle animations to reduce stress
  GoRoute(
    path: '/form',
    pageBuilder: (context, state) {
      return RouteShifterBuilder()
        .slideFromBottom(duration: 300.ms, curve: Curves.easeOut)
        .toPage(child: FormPage());
    },
  ),
];
```

### Accessibility Considerations

```dart
class AccessibleRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/accessible',
          pageBuilder: (context, state) {
            // Check for reduced motion preference
            final mediaQuery = MediaQuery.of(context);
            final reduceAnimations = mediaQuery.disableAnimations;
            
            final shifter = reduceAnimations
              ? RouteShifterBuilder().fade(duration: 100.ms)
              : RouteShifterBuilder()
                  .glassMorph(endBlur: 15.0)
                  .scale(beginScale: 0.95);
            
            return shifter.toPage(child: AccessiblePage());
          },
        ),
      ],
    );
  }
}
```

### Error Handling

```dart
final robustRouter = GoRouter(
  routes: [...],
  errorPageBuilder: (context, state) {
    // Gentle error page animation
    return RouteShifterBuilder()
      .fade(duration: 250.ms)
      .scale(beginScale: 0.95, duration: 300.ms)
      .toPage(
        child: ErrorPage(
          error: state.error?.toString() ?? 'Unknown error',
          onRetry: () => context.go('/'),
        ),
      );
  },
  redirect: (context, state) {
    // Handle authentication redirects with appropriate animations
    if (!AuthService.isLoggedIn && state.location.startsWith('/private')) {
      return '/login?redirect=${Uri.encodeComponent(state.location)}';
    }
    return null;
  },
);
```

### Testing Animations

```dart
// Test animation configurations
class AnimationTestUtils {
  static void testRouteAnimation(WidgetTester tester, String route) async {
    // Test that animations don't cause performance issues
    await tester.pumpWidget(TestApp(initialRoute: route));
    await tester.pumpAndSettle();
    
    // Verify no frame drops during animation
    expect(tester.binding.hasScheduledFrame, false);
  }
  
  static void testResponsiveAnimation(WidgetTester tester) async {
    // Test different screen sizes
    await tester.binding.setSurfaceSize(Size(400, 800)); // Mobile
    await testRouteAnimation(tester, '/responsive');
    
    await tester.binding.setSurfaceSize(Size(800, 600)); // Tablet
    await testRouteAnimation(tester, '/responsive');
    
    await tester.binding.setSurfaceSize(Size(1200, 800)); // Desktop
    await testRouteAnimation(tester, '/responsive');
  }
}
```

---

## 📝 Summary

This integration guide covers:

- ✅ **Basic go_router setup** with Route Shifter
- ✅ **Deep link animations** driven by URL parameters
- ✅ **Responsive animations** for different screen sizes
- ✅ **Theme integration** with Material and Cupertino
- ✅ **Animation presets** for different app types
- ✅ **Advanced techniques** and real-world examples
- ✅ **Best practices** for performance and UX

With Flutter Route Shifter and go_router, you can create sophisticated, responsive, and theme-aware navigation experiences that adapt to your users' context and preferences.

**Next Steps:**

- Experiment with different animation combinations
- Implement deep linking in your app
- Create custom presets for your brand
- Test on different devices and screen sizes
- Monitor performance and user feedback

---

**[🏠 Back to Main Documentation](README.md)** | **[📦 View on pub.dev](https://pub.dev/packages/flutter_route_shifter)**
