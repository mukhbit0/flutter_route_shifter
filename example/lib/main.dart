import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

void main() {
  runApp(const RouteShifterDemoApp());
}

/// Flutter Route Shifter Demo Application
class RouteShifterDemoApp extends StatelessWidget {
  const RouteShifterDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Route Shifter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: const MainDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Main demo page with all transition effects - Enhanced responsive version
class MainDemoPage extends StatefulWidget {
  const MainDemoPage({super.key});

  @override
  State<MainDemoPage> createState() => _MainDemoPageState();
}

class _MainDemoPageState extends State<MainDemoPage> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardAnimation;

  final List<DemoItem> _basicEffects = [
    DemoItem(
      id: 'fade',
      title: 'Fade Transition',
      subtitle: 'Smooth opacity changes',
      color: Colors.blue,
      icon: Icons.opacity,
      category: DemoCategory.basic,
    ),
    DemoItem(
      id: 'slide',
      title: 'Slide Transition',
      subtitle: 'Position-based animation',
      color: Colors.green,
      icon: Icons.swap_horiz,
      category: DemoCategory.basic,
    ),
    DemoItem(
      id: 'scale',
      title: 'Scale Transition',
      subtitle: 'Size transformation',
      color: Colors.orange,
      icon: Icons.zoom_in,
      category: DemoCategory.basic,
    ),
    DemoItem(
      id: 'rotation',
      title: 'Rotation Effect',
      subtitle: 'Rotate transformation',
      color: Colors.purple,
      icon: Icons.rotate_right,
      category: DemoCategory.basic,
    ),
  ];

  final List<DemoItem> _advancedEffects = [
    DemoItem(
      id: 'blur',
      title: 'Blur Effect',
      subtitle: 'Gaussian blur transition',
      color: Colors.indigo,
      icon: Icons.blur_on,
      category: DemoCategory.advanced,
    ),
    DemoItem(
      id: 'shear',
      title: 'Shear Transform',
      subtitle: 'Skew transformation',
      color: Colors.teal,
      icon: Icons.transform,
      category: DemoCategory.advanced,
    ),
    DemoItem(
      id: 'perspective',
      title: 'Perspective Effect',
      subtitle: '3D-like transformation',
      color: Colors.deepPurple,
      icon: Icons.view_in_ar,
      category: DemoCategory.advanced,
    ),
    DemoItem(
      id: 'color_tint',
      title: 'Color Tint',
      subtitle: 'Color overlay effects',
      color: Colors.pink,
      icon: Icons.palette,
      category: DemoCategory.advanced,
    ),
  ];

  final List<DemoItem> _creativeEffects = [
    DemoItem(
      id: 'glass_morph',
      title: 'Glass Morphism',
      subtitle: 'Modern glass effect',
      color: Colors.cyan,
      icon: Icons.layers,
      category: DemoCategory.creative,
    ),
    DemoItem(
      id: 'glitch',
      title: 'Glitch Effect',
      subtitle: 'Digital distortion',
      color: Colors.red,
      icon: Icons.electrical_services,
      category: DemoCategory.creative,
    ),
    DemoItem(
      id: 'parallax',
      title: 'Parallax Effect',
      subtitle: 'Layered movement',
      color: Colors.amber,
      icon: Icons.landscape,
      category: DemoCategory.creative,
    ),
    DemoItem(
      id: 'physics_spring',
      title: 'Physics Spring',
      subtitle: 'Natural spring motion',
      color: Colors.lightGreen,
      icon: Icons.waves,
      category: DemoCategory.creative,
    ),
  ];

  final List<DemoItem> _combinedEffects = [
    DemoItem(
      id: 'fade_slide',
      title: 'Fade + Slide',
      subtitle: 'Combined smooth effects',
      color: Colors.blueGrey,
      icon: Icons.double_arrow,
      category: DemoCategory.combined,
    ),
    DemoItem(
      id: 'scale_rotation',
      title: 'Scale + Rotation',
      subtitle: 'Size and rotation combo',
      color: Colors.brown,
      icon: Icons.crop_rotate,
      category: DemoCategory.combined,
    ),
    DemoItem(
      id: 'shared_elements',
      title: 'Shared Elements',
      subtitle: 'Hero-like transitions',
      color: Colors.deepOrange,
      icon: Icons.share,
      category: DemoCategory.combined,
    ),
    DemoItem(
      id: 'custom_chain',
      title: 'Custom Chain',
      subtitle: 'Multiple effects + .then()',
      color: Colors.indigo,
      icon: Icons.link,
      category: DemoCategory.combined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    );
    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutCubic,
    );

    // Start animations
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with gradient
          SliverAppBar.large(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade600,
                    Colors.purple.shade500,
                  ],
                ),
              ),
              child: const FlexibleSpaceBar(
                title: Text(
                  'Flutter Route Shifter',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(_getResponsivePadding(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Animated Header section
                  FadeTransition(
                    opacity: _headerAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.5),
                        end: Offset.zero,
                      ).animate(_headerAnimation),
                      child: _buildHeaderSection(context),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Animated sections
                  AnimatedBuilder(
                    animation: _cardAnimation,
                    builder: (context, child) {
                      return Column(
                        children: [
                          // Basic Effects Section
                          _buildAnimatedSection(
                            'Basic Effects',
                            'Essential transitions for everyday use',
                            _basicEffects,
                            0,
                          ),

                          const SizedBox(height: 32),

                          // Advanced Effects Section
                          _buildAnimatedSection(
                            'Advanced Effects',
                            'Sophisticated visual transformations',
                            _advancedEffects,
                            1,
                          ),

                          const SizedBox(height: 32),

                          // Creative Effects Section
                          _buildAnimatedSection(
                            'Creative Effects',
                            'Unique and artistic transitions',
                            _creativeEffects,
                            2,
                          ),

                          const SizedBox(height: 32),

                          // Combined Effects Section
                          _buildAnimatedSection(
                            'Combined Effects',
                            'Chained animations with .then() callbacks',
                            _combinedEffects,
                            3,
                          ),

                          const SizedBox(height: 32),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 32;
    if (width > 800) return 24;
    return 16;
  }

  int _getResponsiveCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }

  double _getResponsiveAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 1.0;
    if (width > 800) return 0.95;
    if (width > 600) return 0.9;
    return 1.1;
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade50.withOpacity(0.8),
            Colors.purple.shade50.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade100.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Explore All Transitions',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Discover the power of chainable animations, shared elements, and advanced effects. Tap any card to experience smooth transitions with .then() callbacks!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection(String title, String description, List<DemoItem> items, int sectionIndex) {
    final delay = sectionIndex * 200.0;
    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _cardAnimation,
        curve: Interval(
          (delay / 1200).clamp(0.0, 1.0),
          ((delay + 400) / 1200).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation),
        child: _buildSection(title, description, items),
      ),
    );
  }

  Widget _buildSection(String title, String description, List<DemoItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with improved typography
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Responsive grid
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getResponsiveCrossAxisCount(context),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: _getResponsiveAspectRatio(context),
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildEffectCard(context, items[index], index);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildEffectCard(BuildContext context, DemoItem item, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () => _navigateWithEffect(context, item),
              child: Shifter(
                shiftId: 'card_${item.id}',
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: item.color.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: item.color.withOpacity(0.15),
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      splashColor: item.color.withOpacity(0.1),
                      highlightColor: item.color.withOpacity(0.05),
                      onTap: () => _navigateWithEffect(context, item),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Enhanced icon container
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    item.color.withOpacity(0.1),
                                    item.color.withOpacity(0.05),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: item.color.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                item.icon,
                                size: 32,
                                color: item.color,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Title
                            Text(
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

                            const SizedBox(height: 8),

                            // Subtitle
                            Text(
                              item.subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 12),

                            // Enhanced category indicator
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    item.color.withOpacity(0.15),
                                    item.color.withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: item.color.withOpacity(0.2),
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                _getCategoryName(item.category),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: item.color.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getCategoryName(DemoCategory category) {
    switch (category) {
      case DemoCategory.basic:
        return 'BASIC';
      case DemoCategory.advanced:
        return 'ADVANCED';
      case DemoCategory.creative:
        return 'CREATIVE';
      case DemoCategory.combined:
        return 'COMBINED';
    }
  }

  void _navigateWithEffect(BuildContext context, DemoItem item) {
    RouteShifterBuilder? builder;

    // Enhanced loading snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text('🚀 Preparing ${item.title} transition...'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 800),
        backgroundColor: item.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    switch (item.id) {
      case 'fade':
        builder = RouteShifterBuilder().fade(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        break;

      case 'slide':
        builder = RouteShifterBuilder().slide(
          beginOffset: const Offset(1.0, 0.0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
        break;

      case 'scale':
        builder = RouteShifterBuilder().scale(
          beginScale: 0.0,
          endScale: 1.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
        );
        break;

      case 'rotation':
        builder = RouteShifterBuilder().rotation(
          beginTurns: 0.0,
          endTurns: 1.0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutBack,
        );
        break;

      case 'fade_slide':
        builder = RouteShifterBuilder()
            .fade(duration: const Duration(milliseconds: 500))
            .slide(
              beginOffset: const Offset(1.0, 0.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
            );
        break;

      case 'scale_rotation':
        builder = RouteShifterBuilder()
            .scale(beginScale: 0.5, duration: const Duration(milliseconds: 600))
            .rotation(beginTurns: 0.0, endTurns: 0.25, duration: const Duration(milliseconds: 600));
        break;

      case 'shared_elements':
        builder = RouteShifterBuilder()
            .sharedElements(
              flightDuration: const Duration(milliseconds: 800),
              flightCurve: Curves.easeInOutCubic,
              enableMorphing: true,
            )
            .fade(duration: const Duration(milliseconds: 400));
        break;

      case 'custom_chain':
        builder = RouteShifterBuilder()
            .fade(duration: const Duration(milliseconds: 300))
            .slide(
              beginOffset: const Offset(0.0, 1.0),
              duration: const Duration(milliseconds: 500),
            )
            .scale(beginScale: 0.8, duration: const Duration(milliseconds: 400))
            .rotation(beginTurns: 0.0, endTurns: 0.125, duration: const Duration(milliseconds: 600));
        break;

      default:
        builder = RouteShifterBuilder().fade(duration: const Duration(milliseconds: 300));
    }

    // Navigate with enhanced callback
    final route = builder!.toRoute(page: EffectDemoPage(item: item));
    Navigator.of(context).push(route).then((result) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white.withOpacity(0.9),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('✅ ${item.title} transition completed!'),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    });
  }
}

/// Enhanced demo page that shows the effect result
class EffectDemoPage extends StatefulWidget {
  final DemoItem item;

  const EffectDemoPage({super.key, required this.item});

  @override
  State<EffectDemoPage> createState() => _EffectDemoPageState();
}

class _EffectDemoPageState extends State<EffectDemoPage> with TickerProviderStateMixin {
  late AnimationController _contentController;
  late Animation<double> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _contentAnimation = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOutCubic,
    );
    
    // Start animation after a brief delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _contentController.forward();
      }
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.item.color.withOpacity(0.02),
      appBar: AppBar(
        title: Text(widget.item.title),
        backgroundColor: widget.item.color,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: AnimatedBuilder(
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

                    // Enhanced hero element
                    Center(child: _buildHeroElement()),

                    const SizedBox(height: 48),

                    // Success message with improved design
                    _buildSuccessCard(),

                    const SizedBox(height: 32),

                    // Enhanced return button
                    _buildReturnButton(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroElement() {
    return Shifter(
      shiftId: 'card_${widget.item.id}',
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              widget.item.color.withOpacity(0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: widget.item.color.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: widget.item.color.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            // Large animated icon
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1000),
              tween: Tween(begin: 0.0, end: 1.0),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.item.color.withOpacity(0.15),
                          widget.item.color.withOpacity(0.05),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.item.color.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      widget.item.icon,
                      size: 64,
                      color: widget.item.color,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              widget.item.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              widget.item.subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.item.color.withOpacity(0.2),
                    widget.item.color.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.item.color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                _getCategoryName(widget.item.category),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.item.color.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.08),
            Colors.green.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Animated check icon
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.bounceOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          Text(
            'Transition Completed Successfully!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'The ${widget.item.title.toLowerCase()} effect executed with .then() callback.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReturnButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.item.color,
            widget.item.color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.item.color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).pop(),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 8),
                Text(
                  'Back to Effects',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryName(DemoCategory category) {
    switch (category) {
      case DemoCategory.basic:
        return 'BASIC';
      case DemoCategory.advanced:
        return 'ADVANCED';
      case DemoCategory.creative:
        return 'CREATIVE';
      case DemoCategory.combined:
        return 'COMBINED';
    }
  }
}

// Enhanced data models with better structure
class DemoItem {
  final String id;
  final String title;
  final String subtitle;
  final MaterialColor color;
  final IconData icon;
  final DemoCategory category;

  const DemoItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.category,
  });
}

enum DemoCategory {
  basic,
  advanced,
  creative,
  combined,
}
