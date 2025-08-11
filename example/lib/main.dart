import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Route Shifter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Shifter Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose a transition type:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20),

            // Basic Effects
            _SectionTitle('Basic Effects'),
            _TransitionButton(
              'Fade Transition',
              () => _navigateWithTransition(
                context,
                RouteShifterBuilder().fade(duration: 500.ms),
                'Fade Effect',
                Colors.purple,
              ),
            ),
            _TransitionButton(
              'Slide from Right',
              () => _navigateWithTransition(
                context,
                RouteShifterBuilder().slideFromRight(duration: 350.ms),
                'Slide Right',
                Colors.orange,
              ),
            ),
            _TransitionButton(
              'Scale Up',
              () => _navigateWithTransition(
                context,
                RouteShifterBuilder().scaleUp(duration: 300.ms),
                'Scale Effect',
                Colors.green,
              ),
            ),
            _TransitionButton(
              'Rotation',
              () => _navigateWithTransition(
                context,
                RouteShifterBuilder()
                    .rotateClockwise(turns: 0.25, duration: 400.ms),
                'Rotation Effect',
                Colors.red,
              ),
            ),

            SizedBox(height: 16),

            // Combined Effects
            _SectionTitle('Combined Effects'),
            _TransitionButton(
              'Slide + Fade',
              () => _navigateWithTransition(
                context,
                RouteShifterBuilder()
                    .slideFromRight(duration: 400.ms)
                    .fade(duration: 300.ms),
                'Slide + Fade',
                Colors.teal,
              ),
            ),
            _TransitionButton(
              'Scale + Rotation + Fade',
              () => _navigateWithTransition(
                context,
                RouteShifterBuilder()
                    .scale(beginScale: 0.5, duration: 500.ms)
                    .rotation(beginTurns: -0.5, duration: 500.ms)
                    .fade(duration: 400.ms),
                'Complex Animation',
                Colors.indigo,
              ),
            ),

            SizedBox(height: 16),

            // Material Presets
            _SectionTitle('Material Design Presets'),
            _TransitionButton(
              'Material Page Transition',
              () => _navigateWithPreset(
                context,
                MaterialPresets.materialPageTransition(),
                'Material Page',
                Colors.blue,
              ),
            ),
            _TransitionButton(
              'Material Shared Axis Z',
              () => _navigateWithPreset(
                context,
                MaterialPresets.materialSharedAxisZ(),
                'Shared Axis Z',
                Colors.deepPurple,
              ),
            ),
            _TransitionButton(
              'Material Container Transform',
              () => _navigateWithPreset(
                context,
                MaterialPresets.materialContainerTransform(),
                'Container Transform',
                Colors.pink,
              ),
            ),

            SizedBox(height: 16),

            // Cupertino Presets
            _SectionTitle('Cupertino (iOS) Presets'),
            _TransitionButton(
              'iOS Page Transition',
              () => _navigateWithPreset(
                context,
                CupertinoPresets.cupertinoPageTransition(),
                'iOS Page',
                Colors.grey,
              ),
            ),
            _TransitionButton(
              'iOS Modal Presentation',
              () => _navigateWithPreset(
                context,
                CupertinoPresets.cupertinoModalPresentation(),
                'iOS Modal',
                Colors.cyan,
              ),
            ),

            SizedBox(height: 16),

            // Advanced Features
            _SectionTitle('Advanced Features'),
            _TransitionButton(
              'Interactive Dismiss',
              () => _navigateWithTransition(
                context,
                RouteShifterBuilder()
                    .slideFromRight()
                    .fade()
                    .interactiveDismiss(),
                'Interactive Dismiss (Swipe to go back)',
                Colors.amber,
              ),
            ),
            _TransitionButton(
              'Shared Element Demo',
              () => _navigateToSharedElementDemo(context),
            ),
            _TransitionButton(
              'Staggered Animation',
              () => _navigateToStaggeredDemo(context),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateWithTransition(
    BuildContext context,
    RouteShifterBuilder builder,
    String title,
    Color color,
  ) {
    final route = builder.toRoute(
      page: DemoPage(title: title, color: color),
    );
    Navigator.of(context).push(route);
  }

  void _navigateWithPreset(
    BuildContext context,
    RouteShifterBuilder preset,
    String title,
    Color color,
  ) {
    final route = preset.toRoute(
      page: DemoPage(title: title, color: color),
    );
    Navigator.of(context).push(route);
  }

  void _navigateToSharedElementDemo(BuildContext context) {
    final route = RouteShifterBuilder()
        .fade(duration: 400.ms)
        .sharedElements()
        .toRoute(page: SharedElementDemoPage());
    Navigator.of(context).push(route);
  }

  void _navigateToStaggeredDemo(BuildContext context) {
    final route = RouteShifterBuilder()
        .stagger(interval: 100.ms)
        .fade(duration: 600.ms)
        .toRoute(page: StaggeredDemoPage());
    Navigator.of(context).push(route);
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}

class _TransitionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _TransitionButton(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(title),
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  final String title;
  final Color color;

  const DemoPage({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.animation,
                size: 80,
                color: color,
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'This page demonstrates the $title animation.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
                label: Text('Go Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SharedElementDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Element Demo'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Shared Elements',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),

            // Hero image that can be shared
            GestureDetector(
              onTap: () => _navigateToImageDetail(context),
              child: Hero(
                tag: 'demo-image',
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrange.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Tap the image above to see a shared element transition!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            SizedBox(height: 40),

            // Examples with Shifter widgets
            Text(
              'Shifter Widget Examples',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _navigateWithShifter(context, 'card-1'),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.star, color: Colors.white),
                  ).asStringShifter('card-1'),
                ),
                GestureDetector(
                  onTap: () => _navigateWithShifter(context, 'card-2'),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.favorite, color: Colors.white),
                  ).asStringShifter('card-2'),
                ),
                GestureDetector(
                  onTap: () => _navigateWithShifter(context, 'card-3'),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.lightbulb, color: Colors.white),
                  ).asStringShifter('card-3'),
                ),
              ],
            ),

            SizedBox(height: 16),
            Text(
              'Tap any card to see Shifter widget transitions!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToImageDetail(BuildContext context) {
    final route = RouteShifterBuilder()
        .fade(duration: 400.ms)
        .scale(beginScale: 0.8, duration: 400.ms)
        .toRoute(page: ImageDetailPage());
    Navigator.of(context).push(route);
  }

  void _navigateWithShifter(BuildContext context, String shiftId) {
    final route = RouteShifterBuilder()
        .sharedElements()
        .fade(duration: 500.ms)
        .toRoute(page: ShifterDetailPage(shiftId: shiftId));
    Navigator.of(context).push(route);
  }
}

class ImageDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Hero(
          tag: 'demo-image',
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  size: 120,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  'Expanded View',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShifterDetailPage extends StatelessWidget {
  final String shiftId;

  const ShifterDetailPage({Key? key, required this.shiftId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _getColorForId(shiftId);
    final icon = _getIconForId(shiftId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shifter Detail'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 100, color: Colors.white),
            ).asStringShifter(shiftId),
            SizedBox(height: 20),
            Text(
              'Detail View for $shiftId',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForId(String id) {
    switch (id) {
      case 'card-1':
        return Colors.blue;
      case 'card-2':
        return Colors.green;
      case 'card-3':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconForId(String id) {
    switch (id) {
      case 'card-1':
        return Icons.star;
      case 'card-2':
        return Icons.favorite;
      case 'card-3':
        return Icons.lightbulb;
      default:
        return Icons.help;
    }
  }
}

class StaggeredDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staggered Animation Demo'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Staggered Cards',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Text('${index + 1}'),
                        ),
                        title: Text('Staggered Item ${index + 1}'),
                        subtitle: Text(
                            'This item appears with a ${index * 100}ms delay'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
