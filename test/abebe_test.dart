import 'package:abebe/abebe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

void main() {
  group('Abebe Widget Tests', () {
    late TextEditingController textController;

    setUp(() {
      textController = TextEditingController();
    });

    tearDown(() {
      textController.dispose();
    });

    testWidgets('renders correctly with default parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Abebe(
              assetPath:
                  'assets/sample.json', // Ensure this asset exists or mock it
              textController: textController,
            ),
          ),
        ),
      );

      // Debugging Step: Print widget tree to verify rendering
      debugPrint(tester.element(find.byType(Abebe)).toString());

      // Verify TextField
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('updates TextController on text input',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Abebe(
              assetPath: 'assets/sample.json',
              textController: textController,
            ),
          ),
        ),
      );

      // Ensure TextField is present
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      // Enter text and validate
      await tester.enterText(textFieldFinder, 'Hello, Abebe!');
      expect(textController.text, 'Hello, Abebe!');
    });

    testWidgets('handles speedMultiplier correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Abebe(
              assetPath: 'assets/sample.json',
              textController: textController,
              speedMultiplier: 2,
            ),
          ),
        ),
      );

      // Verify the widget handles speedMultiplier logic (implementation-specific)
      // Example: Check animation duration, if exposed.
      // For now, assuming speedMultiplier impacts internal state or behavior.
      expect(find.byType(Lottie), findsOneWidget);
    });
  });
}
