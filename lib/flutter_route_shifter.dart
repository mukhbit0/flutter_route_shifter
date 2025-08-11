/// A powerful, declarative route transition package with chainable animations,
/// shared elements using Hero widgets, and advanced effects for Flutter applications.
library flutter_route_shifter;

// Core exports
export 'src/core/route_shifter_builder.dart';
export 'src/core/route_shifter.dart';

// Effects exports (keep all the cool effects!)
export 'src/effects/base_effect.dart';
export 'src/effects/fade_effect.dart';
export 'src/effects/slide_effect.dart';
export 'src/effects/scale_effect.dart';
export 'src/effects/rotation_effect.dart';
export 'src/effects/blur_effect.dart';
export 'src/effects/stagger_effect.dart';
export 'src/effects/shear_effect.dart';
export 'src/effects/color_tint_effect.dart';
export 'src/effects/clip_path_effect.dart';
export 'src/effects/follow_path_effect.dart';
export 'src/effects/glass_morph_effect.dart';
export 'src/effects/glitch_effect.dart';
export 'src/effects/mask_effect.dart';
export 'src/effects/parallax_effect.dart';
export 'src/effects/perspective_effect.dart';
export 'src/effects/physics_spring_effect.dart';

// Widget exports - simplified Shifter (Hero wrapper)
export 'src/widgets/shifter_widget.dart';

// Preset exports
export 'src/presets/material_presets.dart';
export 'src/presets/cupertino_presets.dart';

// Utility exports
export 'src/utils/extensions.dart';
export 'src/utils/curves.dart';
