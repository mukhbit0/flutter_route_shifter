import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';
import 'shared_element_advanced_demo.dart';

void main() {
  runApp(const MyApp());
}

/// Flutter Route Shifter Demo Application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Route Shifter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

/// Modern home screen with clean navigation options
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Route Shifter Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.purple.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Route Shifter',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Experience beautiful page transitions and shared element animations',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Demo sections
            Expanded(
              child: Column(
                children: [
                  // Basic transitions
                  _buildDemoCard(
                    context,
                    title: 'Basic Transitions',
                    description: 'Explore fundamental page transition effects',
                    icon: Icons.animation,
                    color: Colors.blue,
                    onTap: () => _navigateToBasicDemo(context),
                  ),

                  const SizedBox(height: 16),

                  // Shared elements
                  _buildDemoCard(
                    context,
                    title: 'Shared Element Transitions',
                    description: 'Advanced shared element animations',
                    icon: Icons.sync_alt,
                    color: Colors.purple,
                    onTap: () => _navigateToSharedElementDemo(context),
                  ),

                  const SizedBox(height: 16),

                  // Interactive demos
                  _buildDemoCard(
                    context,
                    title: 'Interactive Demos',
                    description: 'Touch and gesture-based transitions',
                    icon: Icons.touch_app,
                    color: Colors.green,
                    onTap: () => _navigateToInteractiveDemo(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToBasicDemo(BuildContext context) {
    final route = RouteShifterBuilder()
        .fade(duration: 400.ms)
        .slide(beginOffset: const Offset(1, 0))
        .toRoute(page: const BasicTransitionsDemo());
    Navigator.of(context).push(route);
  }

  void _navigateToSharedElementDemo(BuildContext context) {
    final route = RouteShifterBuilder()
        .fade(duration: 400.ms)
        .sharedElements()
        .toRoute(page: const SharedElementAdvancedExample());
    Navigator.of(context).push(route);
  }

  void _navigateToInteractiveDemo(BuildContext context) {
    final route = RouteShifterBuilder()
        .fade(duration: 400.ms)
        .scale(beginScale: 0.8)
        .toRoute(page: const InteractiveDemo());
    Navigator.of(context).push(route);
  }
}

/// Simple basic transitions demo
class BasicTransitionsDemo extends StatelessWidget {
  const BasicTransitionsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Transitions'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.animation,
              size: 64,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              'Basic Transitions Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This would contain various basic transition examples',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Interactive demo placeholder
class InteractiveDemo extends StatelessWidget {
  const InteractiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Demos'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.touch_app,
              size: 64,
              color: Colors.green,
            ),
            SizedBox(height: 16),
            Text(
              'Interactive Demos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This would contain gesture-based transition examples',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
