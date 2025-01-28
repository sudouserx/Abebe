import 'package:abebe/abebe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

void main() {
  group('Abebe Widget Tests', () {
    late TextEditingController textController;
    late AnimationController animationController;

    setUp(() {
      textController = TextEditingController();
      animationController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: const TestVSync(),
      );
    });

    tearDown(() {
      textController.dispose();
      animationController.dispose();
    });

    testWidgets('Abebe widget initializes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Abebe(
              assetPath: 'assets/sample.json',
              textController: textController,
              animationController: animationController,
            ),
          ),
        ),
      );

      // Verify that the Lottie animation is loaded
      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets('Animation speed increases with typing speed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Abebe(
                  assetPath: 'assets/sample.json',
                  textController: textController,
                  animationController: animationController,
                  sensitivity: 0.3,
                ),
                TextField(
                  controller: textController,
                ),
              ],
            ),
          ),
        ),
      );

      // Initial animation duration
      final initialDuration = animationController.duration;

      // Simulate rapid typing
      textController.text = 'Hello, world!';
      await tester.pump();

      // Verify that the animation duration has decreased (speed increased)
      expect(animationController.duration, lessThan(initialDuration as Object));
    });

    testWidgets('Animation speed resets after inactivity', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Abebe(
                  assetPath: 'assets/sample.json',
                  textController: textController,
                  animationController: animationController,
                  sensitivity: 0.3,
                ),
                TextField(
                  controller: textController,
                ),
              ],
            ),
          ),
        ),
      );

      // Simulate typing
      textController.text = 'Typing...';
      await tester.pump();

      // Wait for 2 seconds (inactivity period)
      await tester.pump(const Duration(seconds: 2));

      // Verify that the animation duration has reset to the initial value
      expect(animationController.duration, equals(const Duration(seconds: 1)));
    });

    testWidgets('Animation speed does not exceed maximum limit', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Abebe(
                  assetPath: 'assets/sample.json',
                  textController: textController,
                  animationController: animationController,
                  sensitivity: 0.3,
                ),
                TextField(
                  controller: textController,
                ),
              ],
            ),
          ),
        ),
      );

      // Simulate extremely fast typing
      textController.text = 'This is a very long text to simulate fast typing!';
      await tester.pump();

      // Verify that the animation duration does not go below a reasonable limit
      expect(animationController.duration, greaterThan(const Duration(milliseconds: 200)));
    });
  });

  group('Abebe Unit Tests', () {
    test('Animation speed calculation works correctly', () {
      final textController = TextEditingController();
      final animationController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: const TestVSync(),
      );

      final abebe = Abebe(
        assetPath: 'assets/sample.json',
        textController: textController,
        animationController: animationController,
        sensitivity: 0.3,
      );

      // Simulate typing
      textController.text = 'Hello';
      abebe._handleTextInput(); // Call the private method directly for testing

      // Verify that the animation speed has increased
      expect(animationController.duration, lessThan(const Duration(seconds: 1)));
    });
  });
}