/// Extension methods for Duration to create more readable code.
extension DurationExtensions on int {
  /// Converts an integer to a Duration in milliseconds.
  ///
  /// Example:
  /// ```dart
  /// 300.ms  // Duration(milliseconds: 300)
  /// ```
  Duration get ms => Duration(milliseconds: this);

  /// Converts an integer to a Duration in seconds.
  ///
  /// Example:
  /// ```dart
  /// 2.seconds  // Duration(seconds: 2)
  /// ```
  Duration get seconds => Duration(seconds: this);

  /// Converts an integer to a Duration in minutes.
  ///
  /// Example:
  /// ```dart
  /// 5.minutes  // Duration(minutes: 5)
  /// ```
  Duration get minutes => Duration(minutes: this);

  /// Converts an integer to a Duration in hours.
  ///
  /// Example:
  /// ```dart
  /// 2.hours  // Duration(hours: 2)
  /// ```
  Duration get hours => Duration(hours: this);

  /// Converts an integer to a Duration in days.
  ///
  /// Example:
  /// ```dart
  /// 7.days  // Duration(days: 7)
  /// ```
  Duration get days => Duration(days: this);

  /// Converts an integer to a Duration in microseconds.
  ///
  /// Example:
  /// ```dart
  /// 500.microseconds  // Duration(microseconds: 500)
  /// ```
  Duration get microseconds => Duration(microseconds: this);
}

/// Extension methods for double values as Duration.
extension DoubleDurationExtensions on double {
  /// Converts a double to a Duration in milliseconds.
  ///
  /// Example:
  /// ```dart
  /// 250.5.ms  // Duration(microseconds: 250500)
  /// ```
  Duration get ms => Duration(microseconds: (this * 1000).round());

  /// Converts a double to a Duration in seconds.
  ///
  /// Example:
  /// ```dart
  /// 2.5.seconds  // Duration(milliseconds: 2500)
  /// ```
  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  /// Converts a double to a Duration in minutes.
  ///
  /// Example:
  /// ```dart
  /// 1.5.minutes  // Duration(seconds: 90)
  /// ```
  Duration get minutes => Duration(seconds: (this * 60).round());
}
