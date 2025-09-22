import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

void main() {
  runApp(const GoRouterDemoApp());
}

class GoRouterDemoApp extends StatelessWidget {
  const GoRouterDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'GoRouter + RouteShifter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) {
        // Use RouteShifterBuilder with go_router integration
        final shifter =
            (RouteShifterBuilder().fade(duration: 400.ms).slideFromRight())
                as RouteShifterBuilder;
        return shifter.toPage(child: const ProfilePage());
      },
    ),
    GoRoute(
      path: '/gallery',
      pageBuilder: (context, state) {
        final shifter =
            (RouteShifterBuilder()
                    .glassMorph(endBlur: 20.0, duration: 800.ms)
                    .parallax(
                      direction: ParallaxDirection.horizontal,
                      backgroundSpeed: 0.5,
                    ))
                as RouteShifterBuilder;
        return shifter.toPage(child: const GalleryPage());
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) {
        // Advanced: use custom curve and theme integration
        final shifter =
            (RouteShifterBuilder()
                    .fade(duration: 300.ms)
                    .withCustomCurve(Curves.easeInOutBack)
                    .followMaterial3(context))
                as RouteShifterBuilder;
        return shifter.toPage(child: const SettingsPage());
      },
    ),
  ],
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Go to Profile (Fade + Slide)'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/gallery'),
              child: const Text('Go to Gallery (Glass + Parallax)'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/settings'),
              child: const Text('Go to Settings (Custom Curve + Theme)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}
