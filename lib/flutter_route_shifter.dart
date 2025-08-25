/// A powerful, declarative route transition package with chainable animations,
/// shared elements using Hero widgets, and advanced effects for Flutter applications.
library flutter_route_shifter;

// Core exports
export 'src/core/route_shifter_builder.dart';
export 'src/core/route_shifter.dart';

// Grouped exports (Modern structured approach)
export 'src/effects/effects.dart';
export 'src/presets/presets.dart';
export 'src/widgets/widgets.dart';
export 'src/utils/utils.dart';

// Integration support for popular packages
export 'src/integrations/integrations.dart';

// 🔑 CRITICAL: Explicitly export go_router integration to make toPage() available
// This ensures the extension methods are available without separate imports
export 'src/integrations/go_router_support.dart';

// Advanced features
export 'src/theme/theme.dart';
export 'src/responsive/responsive.dart';
export 'src/curves/curves.dart';
