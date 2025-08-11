import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

/// Comprehensive example demonstrating advanced shared element transitions
/// with edge case handling, different aspect ratios, and smooth animations.
class SharedElementAdvancedExample extends StatefulWidget {
  const SharedElementAdvancedExample({Key? key}) : super(key: key);

  @override
  State<SharedElementAdvancedExample> createState() =>
      _SharedElementAdvancedExampleState();
}

class _SharedElementAdvancedExampleState
    extends State<SharedElementAdvancedExample> {
  final List<DemoItem> _items = [
    DemoItem(
        id: 'hero1',
        title: 'Hero Image',
        color: Colors.blue,
        type: DemoType.image),
    DemoItem(
        id: 'card1',
        title: 'Card Expansion',
        color: Colors.green,
        type: DemoType.card),
    DemoItem(
        id: 'avatar1',
        title: 'Avatar Growth',
        color: Colors.purple,
        type: DemoType.avatar),
    DemoItem(
        id: 'text1',
        title: 'Text Morph',
        color: Colors.orange,
        type: DemoType.text),
    DemoItem(
        id: 'complex1',
        title: 'Complex Widget',
        color: Colors.red,
        type: DemoType.complex),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Shared Elements'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Header section with instructions
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Advanced Shared Element Demos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Tap any item to see sophisticated shared element transitions with:',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text('• Smooth aspect ratio morphing',
                    style: TextStyle(fontSize: 12)),
                Text('• Edge case handling', style: TextStyle(fontSize: 12)),
                Text('• Performance optimization',
                    style: TextStyle(fontSize: 12)),
                Text('• Custom flight paths', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),

          // Demo items grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return _buildDemoItem(context, item);
              },
            ),
          ),

          // Multi-element transition demo
          Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => _navigateToMultiElementDemo(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Multi-Element Transition Demo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoItem(BuildContext context, DemoItem item) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, item),
      child: Shifter(
        shiftId: item.id,
        child: Container(
          decoration: BoxDecoration(
            color: item.color.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: item.color.shade300),
            boxShadow: [
              BoxShadow(
                color: item.color.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildItemIcon(item),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: item.color.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                _getItemDescription(item.type),
                style: TextStyle(
                  fontSize: 12,
                  color: item.color.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemIcon(DemoItem item) {
    IconData iconData;
    switch (item.type) {
      case DemoType.image:
        iconData = Icons.image;
        break;
      case DemoType.card:
        iconData = Icons.credit_card;
        break;
      case DemoType.avatar:
        iconData = Icons.account_circle;
        break;
      case DemoType.text:
        iconData = Icons.text_fields;
        break;
      case DemoType.complex:
        iconData = Icons.widgets;
        break;
    }

    return Icon(
      iconData,
      size: 48,
      color: item.color.shade700,
    );
  }

  String _getItemDescription(DemoType type) {
    switch (type) {
      case DemoType.image:
        return 'Hero-style transition';
      case DemoType.card:
        return 'Card expansion';
      case DemoType.avatar:
        return 'Circular morphing';
      case DemoType.text:
        return 'Text transformation';
      case DemoType.complex:
        return 'Complex widget morph';
    }
  }

  void _navigateToDetail(BuildContext context, DemoItem item) {
    final route = RouteShifterBuilder()
        .sharedElements(
          flightDuration: const Duration(milliseconds: 600),
          flightCurve: Curves.easeInOutCubic,
          enableMorphing: true,
          useElevation: true,
        )
        .fade(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        )
        .toRoute(
          page: SharedElementDetailPage(item: item),
        );

    Navigator.of(context).push(route);
  }

  void _navigateToMultiElementDemo(BuildContext context) {
    final route = RouteShifterBuilder()
        .sharedElements(
          flightDuration: const Duration(milliseconds: 800),
          flightCurve: Curves.easeInOutBack,
          enableMorphing: true,
        )
        .slide(offsetBegin: const Offset(0, 1))
        .toRoute(
          page: const MultiElementDemoPage(),
        );

    Navigator.of(context).push(route);
  }
}

/// Detail page showing advanced shared element transition
class SharedElementDetailPage extends StatelessWidget {
  final DemoItem item;

  const SharedElementDetailPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: item.color.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Shared element with different aspect ratio
            Center(
              child: Shifter(
                shiftId: item.id,
                child: _buildDetailWidget(item),
              ),
            ),

            const SizedBox(height: 40),

            // Additional content to demonstrate the transition
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transition Details',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    _buildTransitionInfo(item.type),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: item.color.shade600,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailWidget(DemoItem item) {
    switch (item.type) {
      case DemoType.image:
        return Container(
          width: 300,
          height: 200, // Different aspect ratio
          decoration: BoxDecoration(
            color: item.color.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: item.color.shade300, width: 2),
          ),
          child: Icon(
            Icons.image,
            size: 80,
            color: item.color.shade700,
          ),
        );

      case DemoType.card:
        return Container(
          width: 320,
          height: 240, // Expanded size
          decoration: BoxDecoration(
            color: item.color.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: item.color.shade300, width: 2),
            boxShadow: [
              BoxShadow(
                color: item.color.shade300,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.credit_card, size: 64, color: item.color.shade700),
              const SizedBox(height: 16),
              Text(
                'Expanded Card',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: item.color.shade800,
                ),
              ),
            ],
          ),
        );

      case DemoType.avatar:
        return Container(
          width: 200,
          height: 200, // Square aspect ratio
          decoration: BoxDecoration(
            color: item.color.shade100,
            shape: BoxShape.circle,
            border: Border.all(color: item.color.shade300, width: 3),
          ),
          child: Icon(
            Icons.account_circle,
            size: 120,
            color: item.color.shade700,
          ),
        );

      case DemoType.text:
        return Container(
          width: 280,
          height: 120, // Different ratio
          decoration: BoxDecoration(
            color: item.color.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: item.color.shade300),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.text_fields, size: 40, color: item.color.shade700),
                const SizedBox(height: 8),
                Text(
                  'Transformed Text',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: item.color.shade800,
                  ),
                ),
              ],
            ),
          ),
        );

      case DemoType.complex:
        return Container(
          width: 340,
          height: 280, // Much larger
          decoration: BoxDecoration(
            color: item.color.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: item.color.shade300, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.widgets, size: 32, color: item.color.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Complex Widget',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: item.color.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: List.generate(
                        9,
                        (index) => Container(
                              decoration: BoxDecoration(
                                color: item.color.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: item.color.shade700,
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildTransitionInfo(DemoType type) {
    List<String> features;
    switch (type) {
      case DemoType.image:
        features = [
          'Aspect ratio morphing (1.2:1 → 1.5:1)',
          'Smooth corner radius transition',
          'Elevation animation',
          'Color interpolation',
        ];
        break;
      case DemoType.card:
        features = [
          'Size expansion with morphing',
          'Shadow depth animation',
          'Content fade-in transition',
          'Border radius scaling',
        ];
        break;
      case DemoType.avatar:
        features = [
          'Rectangular to circular morphing',
          'Size scaling with aspect preservation',
          'Border width transition',
          'Icon size adaptation',
        ];
        break;
      case DemoType.text:
        features = [
          'Text size and weight transition',
          'Container aspect ratio change',
          'Layout reflow handling',
          'Color scheme morphing',
        ];
        break;
      case DemoType.complex:
        features = [
          'Multi-widget composition handling',
          'Complex layout transitions',
          'Performance optimization',
          'Child widget morphing',
        ];
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(Icons.check_circle,
                        size: 16, color: item.color.shade600),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(feature,
                            style: const TextStyle(fontSize: 14))),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

/// Demo page for multi-element transitions
class MultiElementDemoPage extends StatelessWidget {
  const MultiElementDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Element Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Multiple shared elements would be placed here
            // Each with different stagger timings
            Text(
              'Multi-Element Transition Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This demonstrates coordinated transitions\nof multiple shared elements',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data models
class DemoItem {
  final String id;
  final String title;
  final MaterialColor color;
  final DemoType type;

  DemoItem({
    required this.id,
    required this.title,
    required this.color,
    required this.type,
  });
}

enum DemoType {
  image,
  card,
  avatar,
  text,
  complex,
}
