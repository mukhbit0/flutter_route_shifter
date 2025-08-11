# Flutter Route Animate - Development Guide

## Code Quality & Linting

This project uses strict linting rules to maintain high code quality. The linting configuration is defined in `analysis_options.yaml`.

### Suppressing Lint Warnings

If you encounter lint warnings that you want to suppress, you have several options:

#### 1. Global Configuration (analysis_options.yaml)
Add rules to the `analysis_options.yaml` file to disable them project-wide:

```yaml
linter:
  rules:
    # Disable specific rules
    avoid_print: false
    public_member_api_docs: false
    lines_longer_than_80_chars: false
```

#### 2. File-level Suppression
Add comments at the top of specific files:

```dart
// ignore_for_file: unused_import, prefer_const_constructors
```

#### 3. Line-level Suppression
Add comments above specific lines:

```dart
// ignore: avoid_print
print('Debug message');
```

### Running Analysis

```bash
# Run analysis with warnings as errors (default)
dart analyze --fatal-infos

# Run analysis but don't treat warnings as fatal
dart analyze --no-fatal-warnings

# Check specific files
dart analyze lib/src/effects/stagger_effect.dart
```

### Common Lint Rules in This Project

- **prefer_const_constructors**: Enforces const constructors where possible
- **avoid_unnecessary_containers**: Prevents unnecessary Container widgets  
- **prefer_const_literals_to_create_immutables**: Use const for immutable collections
- **sized_box_for_whitespace**: Use SizedBox instead of Container for spacing
- **use_key_in_widget_constructors**: Require keys in widget constructors

### Disabled Rules

Some strict rules are disabled for better developer experience:

- **avoid_print**: Allows print statements (useful for examples)
- **public_member_api_docs**: Doesn't require docs on all public members
- **lines_longer_than_80_chars**: Allows longer lines for readability
- **file_names**: Flexible file naming conventions
- **constant_identifier_names**: Allows ALL_CAPS constants

## Enhanced Stagger Effect

The stagger effect has been enhanced with robust widget tree traversal using `Element.visitChildren()`. This allows the effect to find and animate nested widgets reliably, even when they're wrapped in containers or other layout widgets.

### Key Features:

1. **Deep Traversal**: Uses `Element.visitChildren()` for comprehensive widget discovery
2. **Element Selector**: Advanced filtering based on Element properties (size, position, etc.)
3. **Fallback Support**: Falls back to widget-based traversal when element traversal fails
4. **Performance Optimized**: Configurable limits to prevent performance issues

### Usage Examples:

```dart
// Basic stagger with automatic widget detection
RouteShifterBuilder()
  .stagger(interval: Duration(milliseconds: 100))
  .fade()
  .toRoute(page: NextPage())

// Advanced stagger with element-based filtering
RouteShifterBuilder()
  .stagger(
    interval: Duration(milliseconds: 80),
    elementSelector: (element) {
      final widget = element.widget;
      final size = element.size;
      return (widget is Card || widget is Material) &&
             size != null && 
             size.height > 50;
    },
    baseEffect: ScaleEffect(start: 0.8),
  )
  .toRoute(page: NextPage())
```

## Testing

The enhanced stagger effect can be tested using the demo file:

```dart
// Run the example
flutter run example/lib/stagger_demo.dart
```

This provides interactive demonstrations of:
- Basic stagger animations
- Advanced element-based selection
- Reverse stagger ordering
- Nested widget detection
