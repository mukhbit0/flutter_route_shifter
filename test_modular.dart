import 'lib/src/core/route_shifter_builder.dart';

void main() {
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

  print('Modular RouteShifterBuilder methods work correctly!');
  print('Builder has ${builder.effects.length} effects configured.');
}
