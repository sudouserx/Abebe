import 'package:flutter/material.dart';
import 'package:abebe/abebe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Abebe Example')),
        body: Center(
          child: Abebe(
            assetPath: 'assets/animation.json',
            textController: textController,
            speedMultiplier: 2,
          ),
        ),
      ),
    );
  }
}
