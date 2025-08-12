import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

/// Individual effect demo page with proper Scaffold
class EffectDemoPage extends StatefulWidget {
  final EffectDemo effect;

  const EffectDemoPage({super.key, required this.effect});

  @override
  State<EffectDemoPage> createState() => _EffectDemoPageState();
}

class _EffectDemoPageState extends State<EffectDemoPage>
    with TickerProviderStateMixin {
  late AnimationController _contentController;
  late AnimationController _interactionController;
  late Animation<double> _contentAnimation;
  late Animation<double> _interactionAnimation;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _interactionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _contentAnimation = CurvedAnimation(
      parent: _contentController,
      curve: SafeCurve(Curves.easeOutCubic),
    );
    _interactionAnimation = CurvedAnimation(
      parent: _interactionController,
      curve: SafeCurve(Curves.easeInOut),
    );

    // Start content animation after brief delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _contentController.forward();
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _interactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use a gradient background for better visibility of blur/glass effects
    final needsGradientBackground = [
      'blur',
      'blur_in',
      'blur_out',
      'glass_morph',
      'color_tint',
    ].contains(widget.effect.id);
    final isBlurEffect = [
      'blur',
      'blur_in',
      'blur_out',
    ].contains(widget.effect.id);

    return Scaffold(
      backgroundColor: needsGradientBackground
          ? null
          : Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: needsGradientBackground
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.effect.color.withValues(alpha: 0.1),
                    Theme.of(context).colorScheme.surface,
                    widget.effect.color.withValues(alpha: 0.05),
                  ],
                ),
              )
            : null,
        child: Stack(
          children: [
            // Add background elements for blur effect
            if (isBlurEffect) ...[
              // More scattered emojis and shapes for better blur visibility
              Positioned(
                top: 80,
                left: 30,
                child: Text(
                  '🌟',
                  style: TextStyle(
                    fontSize: 50,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              Positioned(
                top: 180,
                right: 60,
                child: Text(
                  '🎨',
                  style: TextStyle(
                    fontSize: 45,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              Positioned(
                top: 280,
                left: 100,
                child: Text(
                  '🚀',
                  style: TextStyle(
                    fontSize: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              Positioned(
                top: 380,
                right: 120,
                child: Text(
                  '⭐',
                  style: TextStyle(
                    fontSize: 35,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              Positioned(
                bottom: 180,
                right: 40,
                child: Text(
                  '✨',
                  style: TextStyle(
                    fontSize: 55,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              Positioned(
                bottom: 280,
                left: 60,
                child: Text(
                  '🎯',
                  style: TextStyle(
                    fontSize: 30,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              Positioned(
                bottom: 380,
                right: 80,
                child: Text(
                  '🎪',
                  style: TextStyle(
                    fontSize: 42,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: 200,
                child: Text(
                  '�',
                  style: TextStyle(
                    fontSize: 38,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                  ),
                ),
              ),
              // Colorful geometric shapes with more contrast
              Positioned(
                top: 120,
                right: 30,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 350,
                left: 30,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 320,
                right: 100,
                child: Container(
                  width: 50,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 150,
                left: 120,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 240,
                left: 40,
                child: Container(
                  width: 55,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(17.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            // Main content
            Column(
              children: [
                // Safe AppBar that's always visible and touchable
                AppBar(
                  title: Text(widget.effect.title),
                  backgroundColor: widget.effect.color,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () => _showEffectInfo(context),
                    ),
                  ],
                ),
                // Body content
                Expanded(
                  child: AnimatedBuilder(
                    animation: _contentAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _contentAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(_contentAnimation),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),

                                // For stagger effect, create simple Card widgets for route stagger effect
                                if (widget.effect.id == 'stagger') ...[
                                  // The selector `(widget) => widget is Card` will find these.
                                  const Card(
                                    child: ListTile(
                                      leading: Icon(Icons.star),
                                      title: Text('First Element'),
                                      subtitle: Text(
                                        'This will animate in first',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Card(
                                    child: ListTile(
                                      leading: Icon(Icons.favorite),
                                      title: Text('Second Element'),
                                      subtitle: Text(
                                        'This will animate in second',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Card(
                                    child: ListTile(
                                      leading: Icon(Icons.thumb_up),
                                      title: Text('Third Element'),
                                      subtitle: Text('And so on...'),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Card(
                                    child: ListTile(
                                      leading: Icon(Icons.celebration),
                                      title: Text('Fourth Element'),
                                      subtitle: Text(
                                        'Creating a cascading effect.',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Card(
                                    child: ListTile(
                                      leading: Icon(Icons.emoji_events),
                                      title: Text('Fifth Element'),
                                      subtitle: Text(
                                        'The last one in the sequence.',
                                      ),
                                    ),
                                  ),
                                ] else if (widget.effect.id == 'sequenced') ...[
                                  // Wrap each item with SequencedItem and provide the matching ID
                                  const SequencedItem(
                                    id: 'title_card',
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                          'Title Card (Animates at 100ms)',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const SequencedItem(
                                    id: 'image_card',
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                          'Image Card (Animates at 300ms)',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const SequencedItem(
                                    id: 'button_card',
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                          'Button Card (Animates at 200ms)',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const SequencedItem(
                                    id: 'footer_card',
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                          'Footer Card (Animates at 300ms)',
                                        ),
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  // Hero Element for other effects
                                  Center(child: _buildHeroElement()),
                                  const SizedBox(height: 40),

                                  // Effect Information Card
                                  _buildInfoCard(),
                                  const SizedBox(height: 30),

                                  // Interactive Demo Section
                                  _buildInteractiveDemo(),
                                  const SizedBox(height: 30),

                                  // Action Buttons
                                  _buildActionButtons(),
                                ],
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ], // Close Stack children
            ),
          ], // Close Stack
        ),
      ),
    ); // Close Container
  }

  Widget _buildHeroElement() {
    final isSharedElement = widget.effect.id == 'shared_element';

    Widget heroWidget = AnimatedBuilder(
      animation: _interactionAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_interactionAnimation.value * 0.1),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: widget.effect.color,
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: widget.effect.color.withValues(alpha: 0.4),
                  blurRadius: 20 + (_interactionAnimation.value * 10),
                  offset: const Offset(0, 10),
                ),
              ],
              gradient: RadialGradient(
                colors: [
                  widget.effect.color.withValues(alpha: 0.8),
                  widget.effect.color,
                ],
              ),
            ),
            child: Icon(widget.effect.icon, size: 50, color: Colors.white),
          ),
        );
      },
    );

    // Wrap with Shifter for shared element transitions
    if (isSharedElement) {
      heroWidget = Shifter(
        shiftId: 'hero-${widget.effect.id}',
        child: heroWidget,
      );
    }

    return heroWidget;
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: widget.effect.color, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Effect Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.effect.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Name', widget.effect.title),
            _buildDetailRow('Description', widget.effect.description),
            _buildDetailRow(
              'Category',
              widget.effect.category.name.toUpperCase(),
            ),
            _buildDetailRow('ID', widget.effect.id),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveDemo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Interactive Demo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.effect.color,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _interactionController.forward().then((_) {
                  _interactionController.reverse();
                });
              },
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: widget.effect.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.effect.color.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: widget.effect.color,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to test animation',
                        style: TextStyle(
                          color: widget.effect.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _showEffectInfo(context),
          icon: const Icon(Icons.code),
          label: const Text('View Code'),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.effect.color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  void _showEffectInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${widget.effect.title} - Usage'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Code Example:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.effect.color,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getCodeExample(),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.effect.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(widget.effect.description),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _getCodeExample() {
    switch (widget.effect.id) {
      case 'fade':
        return '''RouteShifterBuilder()
  .fade(
    duration: Duration(milliseconds: 600),
    curve: Curves.easeInOut,
  )
  .toRoute(page: YourPage())''';
      case 'slide':
        return '''RouteShifterBuilder()
  .slide(
    beginOffset: Offset(1.0, 0.0),
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOutCubic,
  )
  .toRoute(page: YourPage())''';
      case 'scale':
        return '''RouteShifterBuilder()
  .scale(
    beginScale: 0.0,
    endScale: 1.0,
    duration: Duration(milliseconds: 600),
    curve: Curves.elasticOut,
  )
  .toRoute(page: YourPage())''';
      default:
        return '''RouteShifterBuilder()
  .${widget.effect.id}(
    // Effect parameters
    duration: Duration(milliseconds: 600),
  )
  .toRoute(page: YourPage())''';
    }
  }
}
