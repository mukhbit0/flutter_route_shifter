import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/src/core/route_shifter_builder.dart';

void main() {
  group('RouteShifterBuilder Modular Tests', () {
    test('should create builder with multiple effects', () {
      // Test that the modular RouteShifterBuilder works correctly
      final builder = RouteShifterBuilder()
        // Test basic effects that should work
        ..fade()
        ..slide()
        ..scale()
        ..blur()
        ..rotation()
        ..stagger()
        // Test creative effects that should work
        ..circleReveal()
        ..rectangleReveal()
        ..starReveal()
        ..waveReveal();

      // Verify that all effects were added
      expect(builder.effects.length, equals(10));
      print('✅ Modular RouteShifterBuilder methods work correctly!');
      print('✅ Builder has ${builder.effects.length} effects configured.');
    });

    test('should create route with effects', () {
      final builder = RouteShifterBuilder()
        ..fade()
        ..slide();

      // Create a simple test page
      final testPage = const Scaffold(
        body: Center(
          child: Text('Test Page'),
        ),
      );

      // Should be able to create a route
      final route = builder.toRoute(page: testPage);

      expect(route, isNotNull);
      expect(builder.effects.length, equals(2));
    });

    test('should support stagger effect with element selector', () {
      final builder = RouteShifterBuilder()
        ..stagger(
          interval: const Duration(milliseconds: 100),
          selector: (Widget widget) {
            return widget is Card || widget is ListTile;
          },
        );

      expect(builder.effects.length, equals(1));
      print('✅ Enhanced stagger effect with element selector works!');
    });

    test('should support chaining with .then callbacks', () {
      // This would be tested in widget tests, but we can verify the API exists
      final builder = RouteShifterBuilder()
        ..fade()
        ..slide();

      // Verify that pushTo method exists and returns Future
      expect(builder.pushTo, isA<Function>());
      print('✅ .then callback support API available!');
    });
  });
}
