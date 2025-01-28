import 'package:abebe/abebe.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abebe Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Default duration
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller and text controller
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abebe Animation Example'),
      ),
      body: Column(
        children: [
          // Abebe widget with Lottie animation
          Abebe(
            assetPath: 'assets/sample.json', // Path to your Lottie JSON file
            textController: _textController,
            animationController: _animationController,
            sensitivity: 0.3, // Adjust sensitivity for speed changes
          ),
          const SizedBox(height: 20),
          // Text field for user input
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type here to control the animation speed...',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }
}