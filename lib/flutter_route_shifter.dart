/// A powerful, declarative route transition package with chainable animations,
/// shared elements, and advanced effects for Flutter applications.
library flutter_route_shifter;

// Core exports
export 'src/core/route_shifter_builder.dart';
export 'src/core/route_shifter.dart';
export 'src/core/shifter_registry.dart';
export 'src/core/shared_element_manager.dart';
export 'src/core/edge_case_handler.dart';

// Effects exports
export 'src/effects/base_effect.dart';
export 'src/effects/fade_effect.dart';
export 'src/effects/slide_effect.dart';
export 'src/effects/scale_effect.dart';
export 'src/effects/rotation_effect.dart';
export 'src/effects/blur_effect.dart';
export 'src/effects/stagger_effect.dart';
export 'src/effects/shared_element_effect.dart';

// Widget exports
export 'src/widgets/shifter_widget.dart';

// Preset exports
export 'src/presets/material_presets.dart';
export 'src/presets/cupertino_presets.dart';

// Utility exports
export 'src/utils/extensions.dart';
export 'src/utils/curves.dart';
