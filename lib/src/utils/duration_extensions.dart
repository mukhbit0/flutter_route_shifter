/// Duration extensions for cleaner syntax
///
/// Example usage:
/// ```dart
/// RouteShifterBuilder()
///   .fade(duration: 300.ms)
///   .slide(duration: 1.5.s)
/// ```
extension NumDurationExtensions on num {
  /// Converts a number to milliseconds
  Duration get ms => Duration(milliseconds: round());

  /// Converts a number to seconds
  Duration get s => Duration(seconds: round());

  /// Converts a number to minutes
  Duration get min => Duration(minutes: round());
}
