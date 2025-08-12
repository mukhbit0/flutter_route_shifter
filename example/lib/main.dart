import 'package:example/effect_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

void main() {
  runApp(const RouteShifterDemoApp());
}

/// Flutter Route Shifter Demo Application - Complete Edition
class RouteShifterDemoApp extends StatelessWidget {
  const RouteShifterDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Route Shifter - Complete Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: const CompleteDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Complete demo page showcasing ALL effects
class CompleteDemoPage extends StatefulWidget {
  const CompleteDemoPage({super.key});

  @override
  State<CompleteDemoPage> createState() => _CompleteDemoPageState();
}

class _CompleteDemoPageState extends State<CompleteDemoPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: SafeCurve(Curves.easeOutCubic),
    );
    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: SafeCurve(Curves.easeOutBack),
    );

    // Start animations
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _cardController.forward();
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
                  colors: [Colors.blue.shade600, Colors.purple.shade500],
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
                ],
              ),
            ),
          ),

          // Effects Grid
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: _getResponsivePadding(context),
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75, // Increased for more height
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final effect = _allEffects[index];

                // Simple card with basic fade-in, no stagger
                return AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _cardAnimation.value,
                      child: _buildEffectCard(effect),
                    );
                  },
                );
              }, childCount: _allEffects.length),
            ),
          ),
        ],
      ),
    );
  }

  double _getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) return 32.0;
    if (screenWidth > 800) return 24.0;
    if (screenWidth > 600) return 20.0;
    return 16.0;
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade50.withValues(alpha: 0.8),
            Colors.purple.shade50.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withValues(alpha: 0.3),
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
            style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildEffectCard(EffectDemo effect) {
    return Card(
      elevation: 8,
      shadowColor: effect.color.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _navigateWithEffect(context, effect),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                effect.color.withValues(alpha: 0.1),
                effect.color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Effect Icon
              Shifter(
                shiftId: 'hero-${effect.id}',
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: effect.color,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: effect.color.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(effect.icon, color: Colors.white, size: 22),
                ),
              ),
              const SizedBox(height: 10),

              // Effect Title
              Text(
                effect.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: effect.color,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),

              // Effect Description
              Text(
                effect.description,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: effect.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  effect.category.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: effect.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateWithEffect(BuildContext context, EffectDemo effect) {
    RouteShifterBuilder builder = RouteShifterBuilder();

    // Apply the specific effect based on ID
    switch (effect.id) {
      case 'fade':
        builder = builder.fade(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        break;

      case 'fade_in':
        builder = builder.fadeIn(duration: const Duration(milliseconds: 500));
        break;

      case 'slide':
        builder = builder.slide(
          beginOffset: const Offset(1.0, 0.0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
        break;

      case 'slide_from_right':
        builder = builder.slideFromRight(
          duration: const Duration(milliseconds: 500),
        );
        break;

      case 'slide_from_left':
        builder = builder.slideFromLeft(
          duration: const Duration(milliseconds: 500),
        );
        break;

      case 'slide_from_top':
        builder = builder.slideFromTop(
          duration: const Duration(milliseconds: 500),
        );
        break;

      case 'slide_from_bottom':
        builder = builder.slideFromBottom(
          duration: const Duration(milliseconds: 500),
        );
        break;

      case 'scale':
        builder = builder.scale(
          beginScale: 0.0,
          endScale: 1.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
        );
        break;

      case 'scale_up':
        builder = builder.scaleUp(duration: const Duration(milliseconds: 500));
        break;

      case 'scale_down':
        builder = builder.scaleDown(
          duration: const Duration(milliseconds: 500),
        );
        break;

      case 'bounce_scale':
        builder = builder.bounceScale(
          duration: const Duration(milliseconds: 800),
        );
        break;

      case 'rotation':
        builder = builder.rotation(
          beginTurns: 0.0,
          endTurns: 1.0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutBack,
        );
        break;

      case 'rotate_clockwise':
        builder = builder.rotateClockwise(
          turns: 0.5,
          duration: const Duration(milliseconds: 600),
        );
        break;

      case 'rotate_counter_clockwise':
        builder = builder.rotateCounterClockwise(
          turns: 0.5,
          duration: const Duration(milliseconds: 600),
        );
        break;

      case 'blur':
        // Blur effect that affects the entire screen transition
        builder = builder.blur(
          beginSigma: 0.0,
          endSigma: 15.0, // Stronger blur for whole screen effect
          duration: const Duration(
            milliseconds: 1200,
          ), // Longer to see full screen blur
        );
        break;

      case 'blur_in':
        builder = builder.blurIn(
          maxBlur: 10.0,
          duration: const Duration(milliseconds: 600),
        );
        break;

      case 'shear':
        builder = builder.shear(
          beginShear: const Offset(0.0, 0.0),
          endShear: const Offset(0.2, 0.0),
          duration: const Duration(milliseconds: 600),
        );
        break;

      case 'perspective':
        builder = builder.perspective(
          beginRotateY: 0.0,
          endRotateY: 0.15, // Much smaller rotation (27° instead of 90°)
          perspective: 0.001, // Less extreme perspective
          duration: const Duration(milliseconds: 800),
        );
        break;

      case 'glass_morph':
        // Glass morph effect covering the whole screen
        builder = builder.glassMorph(
          beginBlur: 0.0,
          endBlur: 5.0, // More noticeable glass effect
          beginColor: Colors.transparent,
          endColor: Colors.white.withValues(
            alpha: 0.15,
          ), // More visible overlay
          duration: const Duration(milliseconds: 900),
        );
        break;

      case 'glitch':
        builder = builder.glitch(
          intensity: 8.0, // Reduced intensity for better visibility
          duration: const Duration(milliseconds: 800), // Shorter duration
        );
        break;

      case 'color_tint':
        // Color tint covering the whole screen
        builder = builder.colorTint(
          beginColor: Colors.transparent,
          endColor: effect.color.withValues(alpha: 0.25), // More visible tint
          duration: const Duration(milliseconds: 800),
        );
        break;

      case 'parallax':
        builder = builder.parallax(
          backgroundSpeed: 0.5,
          duration: const Duration(milliseconds: 800),
        );
        break;

      case 'follow_path':
        final path = Path()
          ..moveTo(0, 0)
          ..quadraticBezierTo(100, -50, 200, 0)
          ..quadraticBezierTo(300, 50, 400, 0);
        builder = builder.followPath(
          path: path,
          rotateAlongPath: true,
          duration: const Duration(milliseconds: 1200),
        );
        break;

      case 'physics_spring':
        builder = builder.spring(
          effect: ScaleEffect(beginScale: 0.5, endScale: 1.0),
          stiffness: 100,
          damping: 10,
          mass: 1.0,
        );
        break;

      case 'mask':
        // Mask covering the whole screen with visible effect
        builder = builder.mask(
          maskChild: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.transparent, Colors.black], // Stronger mask
                stops: [
                  0.4,
                  1.0,
                ], // Smaller transparent area for more visible effect
              ),
            ),
          ),
          duration: const Duration(milliseconds: 1000),
        );
        break;

      case 'clip_path':
        builder = builder.clipPath(
          type: ClipPathType.circle,
          duration: const Duration(milliseconds: 700),
        );
        break;

      case 'sequenced':
        builder = builder.sequenced(
          timings: {
            // Define the animation sequence here
            'title_card': const Duration(milliseconds: 100),
            'image_card': const Duration(milliseconds: 300),
            'button_card': const Duration(
              milliseconds: 200,
            ), // This will animate before the image
            'footer_card': const Duration(
              milliseconds: 300,
            ), // This animates with the image
          },
          baseEffect: const SlideEffect(begin: Offset(0.0, 0.5)),
          duration: const Duration(
            milliseconds: 800,
          ), // Overall transition duration
        );
        break;

      // Combination effects
      case 'fade_slide':
        builder = builder
            .fade(duration: const Duration(milliseconds: 400))
            .slide(
              beginOffset: const Offset(0.0, 1.0),
              duration: const Duration(milliseconds: 600),
            );
        break;

      case 'scale_rotation':
        builder = builder
            .scale(beginScale: 0.5, duration: const Duration(milliseconds: 600))
            .rotation(
              beginTurns: 0.0,
              endTurns: 0.25,
              duration: const Duration(milliseconds: 600),
            );
        break;

      case 'blur_scale':
        builder = builder
            .blur(
              beginSigma: 10.0,
              endSigma: 0.0,
              duration: const Duration(milliseconds: 500),
            )
            .scale(
              beginScale: 0.8,
              endScale: 1.0,
              duration: const Duration(milliseconds: 700),
            );
        break;

      case 'perspective_fade':
        builder = builder
            .perspective(
              beginRotateY: 0.0,
              endRotateY: 0.3,
              duration: const Duration(milliseconds: 800),
            )
            .fade(duration: const Duration(milliseconds: 600));
        break;

      case 'complex_combo':
        builder = builder
            .fade(duration: const Duration(milliseconds: 300))
            .slide(
              beginOffset: const Offset(0.0, 0.5),
              duration: const Duration(milliseconds: 500),
            )
            .scale(
              beginScale: 0.9,
              endScale: 1.0,
              duration: const Duration(milliseconds: 400),
            )
            .rotation(
              beginTurns: 0.0,
              endTurns: 0.05,
              duration: const Duration(milliseconds: 600),
            );
        break;

      // Material Design Presets
      case 'material_slide_up':
        builder = builder.materialSlideUp();
        break;

      case 'material_fade_through':
        builder = builder.materialFadeThrough();
        break;

      // Cupertino (iOS) Presets
      case 'cupertino_slide':
        builder = builder.cupertinoSlide();
        break;

      case 'cupertino_modal':
        builder = builder.cupertinoModal();
        break;

      case 'shared_element':
        builder = builder.sharedElement(
          flightDuration: const Duration(milliseconds: 600),
          flightCurve: Curves.fastLinearToSlowEaseIn,
          enableMorphing: true,
          useElevation: true,
          flightElevation: 12.0,
        );
        break;

      default:
        builder = builder.fade(duration: const Duration(milliseconds: 300));
    }

    // Navigate with the effect
    final route = builder.toRoute(page: EffectDemoPage(effect: effect));
    Navigator.of(context).push(route);
  }

  // All available effects
  final List<EffectDemo> _allEffects = [
    // Basic Effects
    EffectDemo(
      id: 'fade',
      title: 'Fade Transition',
      description: 'Smooth opacity animation',
      icon: Icons.opacity,
      color: Colors.blue,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'fade_in',
      title: 'Fade In',
      description: 'Fade from transparent to opaque',
      icon: Icons.visibility,
      color: Colors.lightBlue,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'slide',
      title: 'Slide Transition',
      description: 'Position-based movement',
      icon: Icons.slideshow,
      color: Colors.green,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'slide_from_right',
      title: 'Slide From Right',
      description: 'Enter from right edge',
      icon: Icons.keyboard_arrow_left,
      color: Colors.lightGreen,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'slide_from_left',
      title: 'Slide From Left',
      description: 'Enter from left edge',
      icon: Icons.keyboard_arrow_right,
      color: Colors.greenAccent,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'slide_from_top',
      title: 'Slide From Top',
      description: 'Enter from top edge',
      icon: Icons.keyboard_arrow_down,
      color: Colors.teal,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'slide_from_bottom',
      title: 'Slide From Bottom',
      description: 'Enter from bottom edge',
      icon: Icons.keyboard_arrow_up,
      color: Colors.tealAccent,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'scale',
      title: 'Scale Transition',
      description: 'Size transformation effect',
      icon: Icons.zoom_in,
      color: Colors.orange,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'scale_up',
      title: 'Scale Up',
      description: 'Grow from small to normal',
      icon: Icons.zoom_out_map,
      color: Colors.deepOrange,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'scale_down',
      title: 'Scale Down',
      description: 'Shrink from large to normal',
      icon: Icons.zoom_in_map,
      color: Colors.orangeAccent,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'bounce_scale',
      title: 'Bounce Scale',
      description: 'Elastic scaling effect',
      icon: Icons.open_in_full,
      color: Colors.amber,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'rotation',
      title: 'Rotation Transition',
      description: 'Spinning animation effect',
      icon: Icons.rotate_right,
      color: Colors.purple,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'rotate_clockwise',
      title: 'Rotate Clockwise',
      description: 'Spin in clockwise direction',
      icon: Icons.rotate_right,
      color: Colors.deepPurple,
      category: EffectCategory.basic,
    ),
    EffectDemo(
      id: 'rotate_counter_clockwise',
      title: 'Rotate Counter-Clockwise',
      description: 'Spin in counter-clockwise direction',
      icon: Icons.rotate_left,
      color: Colors.purpleAccent,
      category: EffectCategory.basic,
    ),

    // Advanced Effects
    EffectDemo(
      id: 'blur',
      title: 'Blur Effect',
      description: 'Gaussian blur animation',
      icon: Icons.blur_on,
      color: Colors.indigo,
      category: EffectCategory.advanced,
    ),
    EffectDemo(
      id: 'blur_in',
      title: 'Blur In',
      description: 'Start blurred, become clear',
      icon: Icons.blur_off,
      color: Colors.indigoAccent,
      category: EffectCategory.advanced,
    ),
    EffectDemo(
      id: 'shear',
      title: 'Shear Transform',
      description: 'Skew and distortion effects',
      icon: Icons.transform,
      color: Colors.teal,
      category: EffectCategory.advanced,
    ),
    EffectDemo(
      id: 'perspective',
      title: 'Perspective 3D',
      description: '3D depth transformation',
      icon: Icons.view_in_ar,
      color: Colors.deepOrange,
      category: EffectCategory.advanced,
    ),
    EffectDemo(
      id: 'glass_morph',
      title: 'Glass Morphism',
      description: 'Modern glass effect',
      icon: Icons.opacity_outlined,
      color: Colors.cyan,
      category: EffectCategory.advanced,
    ),

    // Creative Effects
    EffectDemo(
      id: 'glitch',
      title: 'Glitch Effect',
      description: 'Digital distortion animation',
      icon: Icons.electrical_services,
      color: Colors.red,
      category: EffectCategory.creative,
    ),
    EffectDemo(
      id: 'color_tint',
      title: 'Color Tint',
      description: 'Color overlay transition',
      icon: Icons.color_lens,
      color: Colors.pink,
      category: EffectCategory.creative,
    ),
    EffectDemo(
      id: 'parallax',
      title: 'Parallax Effect',
      description: 'Multi-layer depth motion',
      icon: Icons.layers,
      color: Colors.amber,
      category: EffectCategory.creative,
    ),
    EffectDemo(
      id: 'follow_path',
      title: 'Follow Path',
      description: 'Custom curve animation',
      icon: Icons.timeline,
      color: Colors.lime,
      category: EffectCategory.creative,
    ),

    // Physics & Advanced
    EffectDemo(
      id: 'physics_spring',
      title: 'Physics Spring',
      description: 'Realistic spring physics',
      icon: Icons.settings_input_component,
      color: Colors.deepPurple,
      category: EffectCategory.physics,
    ),
    EffectDemo(
      id: 'mask',
      title: 'Mask Effect',
      description: 'Shape-based reveal',
      icon: Icons.crop,
      color: Colors.brown,
      category: EffectCategory.advanced,
    ),
    EffectDemo(
      id: 'clip_path',
      title: 'Clip Path',
      description: 'Custom shape clipping',
      icon: Icons.cut,
      color: Colors.blueGrey,
      category: EffectCategory.advanced,
    ),
    EffectDemo(
      id: 'sequenced',
      title: 'Sequenced',
      description: 'Manually timed animations',
      icon: Icons.sort_by_alpha,
      color: Colors.redAccent,
      category: EffectCategory.advanced,
    ),

    // Combination Effects
    EffectDemo(
      id: 'fade_slide',
      title: 'Fade + Slide',
      description: 'Combined smooth transition',
      icon: Icons.layers,
      color: Colors.teal,
      category: EffectCategory.combination,
    ),
    EffectDemo(
      id: 'scale_rotation',
      title: 'Scale + Rotation',
      description: 'Dynamic size and spin',
      icon: Icons.rotate_90_degrees_ccw,
      color: Colors.orange,
      category: EffectCategory.combination,
    ),
    EffectDemo(
      id: 'blur_scale',
      title: 'Blur + Scale',
      description: 'Focus transition effect',
      icon: Icons.zoom_out_map,
      color: Colors.purple,
      category: EffectCategory.combination,
    ),
    EffectDemo(
      id: 'perspective_fade',
      title: 'Perspective + Fade',
      description: '3D depth with opacity',
      icon: Icons.threed_rotation,
      color: Colors.red,
      category: EffectCategory.combination,
    ),
    EffectDemo(
      id: 'complex_combo',
      title: 'Complex Combo',
      description: 'Multi-effect masterpiece',
      icon: Icons.auto_awesome,
      color: Colors.deepOrange,
      category: EffectCategory.combination,
    ),
    // Special Effects
    EffectDemo(
      id: 'shared_element',
      title: 'Shared Element',
      description: 'Hero-like element transitions',
      icon: Icons.swap_horiz,
      color: Colors.indigo,
      category: EffectCategory.advanced,
    ),

    // Material Design Presets
    EffectDemo(
      id: 'material_slide_up',
      title: 'Material Slide Up',
      description: 'Material Design bottom sheet style',
      icon: Icons.expand_less,
      color: Colors.blue.shade600,
      category: EffectCategory.preset,
    ),
    EffectDemo(
      id: 'material_fade_through',
      title: 'Material Fade Through',
      description: 'Material Design fade through transition',
      icon: Icons.visibility,
      color: Colors.blue.shade700,
      category: EffectCategory.preset,
    ),

    // Cupertino (iOS) Presets
    EffectDemo(
      id: 'cupertino_slide',
      title: 'Cupertino Slide',
      description: 'iOS-style horizontal slide',
      icon: Icons.phone_iphone,
      color: Colors.grey.shade600,
      category: EffectCategory.preset,
    ),
    EffectDemo(
      id: 'cupertino_modal',
      title: 'Cupertino Modal',
      description: 'iOS-style modal presentation',
      icon: Icons.vertical_align_top,
      color: Colors.grey.shade700,
      category: EffectCategory.preset,
    ),
  ];
}

/// Effect demo data model
class EffectDemo {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final EffectCategory category;

  const EffectDemo({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.category,
  });
}

/// Effect categories
enum EffectCategory { basic, advanced, creative, physics, combination, preset }
