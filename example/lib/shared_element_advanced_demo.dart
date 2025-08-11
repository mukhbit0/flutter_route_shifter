import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

/// Modern and clean shared element transitions demo
class SharedElementAdvancedExample extends StatefulWidget {
  const SharedElementAdvancedExample({super.key});

  @override
  State<SharedElementAdvancedExample> createState() =>
      _SharedElementAdvancedExampleState();
}

class _SharedElementAdvancedExampleState
    extends State<SharedElementAdvancedExample> {
  final List<DemoItem> _items = [
    DemoItem(
      id: 'photo',
      title: 'Photo Gallery',
      color: Colors.blue,
      type: DemoType.image,
    ),
    DemoItem(
      id: 'profile',
      title: 'User Profile',
      color: Colors.green,
      type: DemoType.avatar,
    ),
    DemoItem(
      id: 'article',
      title: 'Article Card',
      color: Colors.orange,
      type: DemoType.card,
    ),
    DemoItem(
      id: 'dashboard',
      title: 'Dashboard',
      color: Colors.purple,
      type: DemoType.complex,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Shared Element Transitions'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.purple.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Transitions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap any card to experience smooth shared element transitions',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Demo items grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return _buildGridItem(context, item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, DemoItem item) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, item),
      child: Shifter(
        shiftId: 'container_${item.id}',
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconForType(item.type),
                  size: 32,
                  color: item.color,
                ),
              ),

              const SizedBox(height: 16),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle based on type
              Text(
                _getSubtitleForType(item.type),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(DemoType type) {
    switch (type) {
      case DemoType.image:
        return Icons.photo_library;
      case DemoType.avatar:
        return Icons.person;
      case DemoType.card:
        return Icons.article;
      case DemoType.complex:
        return Icons.dashboard;
      default:
        return Icons.widgets;
    }
  }

  String _getSubtitleForType(DemoType type) {
    switch (type) {
      case DemoType.image:
        return 'Image transitions';
      case DemoType.avatar:
        return 'Avatar expansion';
      case DemoType.card:
        return 'Content morphing';
      case DemoType.complex:
        return 'Complex layouts';
      default:
        return 'Transition demo';
    }
  }

  void _navigateToDetail(BuildContext context, DemoItem item) {
    // RouteShifterBuilder with Hero-based shared elements
    final route = RouteShifterBuilder()
        .sharedElements(
          flightDuration: const Duration(milliseconds: 600),
          flightCurve: Curves.easeInOutCubic,
          enableMorphing: true,
          useElevation: true,
          shiftIds: ['container_${item.id}'],
        )
        .fade(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        )
        .toRoute(page: SharedElementDetailPage(item: item));
    Navigator.of(context).push(route);
  }
}

/// Clean and modern detail page
class SharedElementDetailPage extends StatelessWidget {
  final DemoItem item;

  const SharedElementDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Shared element container
            Center(child: _buildDetailContent(item)),

            const SizedBox(height: 40),

            // Information card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transition Details',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureList(item.type),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Back button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: item.color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Go Back',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContent(DemoItem item) {
    return Shifter(
      shiftId: 'container_${item.id}',
      child: Container(
        width: 280,
        height: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: item.color.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForType(item.type),
                size: 64,
                color: item.color,
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _getDescriptionForType(item.type),
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(DemoType type) {
    switch (type) {
      case DemoType.image:
        return Icons.photo_library;
      case DemoType.avatar:
        return Icons.person;
      case DemoType.card:
        return Icons.article;
      case DemoType.complex:
        return Icons.dashboard;
      default:
        return Icons.widgets;
    }
  }

  String _getDescriptionForType(DemoType type) {
    switch (type) {
      case DemoType.image:
        return 'Beautiful image gallery with smooth transitions and aspect ratio morphing';
      case DemoType.avatar:
        return 'User profile with expanding avatar and circular transformation effects';
      case DemoType.card:
        return 'Article cards that morph seamlessly with content-aware transitions';
      case DemoType.complex:
        return 'Complex dashboard layouts with multiple element coordination';
      default:
        return 'Advanced transition demonstration';
    }
  }

  Widget _buildFeatureList(DemoType type) {
    List<String> features = _getFeaturesForType(type);

    return Column(
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 16, color: item.color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(feature, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  List<String> _getFeaturesForType(DemoType type) {
    switch (type) {
      case DemoType.image:
        return [
          'Aspect ratio morphing',
          'Smooth corner radius transition',
          'Elevation animation',
          'Color interpolation',
        ];
      case DemoType.avatar:
        return [
          'Circular to rectangular morphing',
          'Size scaling with proportions',
          'Smooth border transitions',
          'Content fade effects',
        ];
      case DemoType.card:
        return [
          'Content-aware morphing',
          'Shadow depth animation',
          'Text scaling transitions',
          'Layout restructuring',
        ];
      case DemoType.complex:
        return [
          'Multi-element coordination',
          'Staggered animations',
          'Layout transformation',
          'Performance optimization',
        ];
      default:
        return ['Advanced transition effects'];
    }
  }
}

// Data model classes
class DemoItem {
  final String id;
  final String title;
  final MaterialColor color;
  final DemoType type;

  const DemoItem({
    required this.id,
    required this.title,
    required this.color,
    required this.type,
  });
}

enum DemoType { image, card, avatar, text, complex }
