// lib/abebe.dart

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';

class Abebe extends StatefulWidget {
  final String assetPath;
  final TextEditingController textController;
  final int speedMultiplier;

  const Abebe({
    super.key,
    required this.assetPath,
    required this.textController,
    this.speedMultiplier = 1,
  });

  @override
  State<Abebe> createState() => _AbebeState();
}

class _AbebeState extends State<Abebe> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Duration _defaultDuration;
  late DateTime _startTime;
  int _typedCharacters = 0;
  double _typingSpeed = 0.0;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _animationController = AnimationController(vsync: this);

    // Set default values and add listener to text controller
    widget.textController.addListener(_calculateTypingSpeed);
    _startTime = DateTime.now();
  }

  @override
  void dispose() {
    widget.textController.removeListener(_calculateTypingSpeed);
    _animationController.dispose();
    super.dispose();
  }

  void _calculateTypingSpeed() {
    final currentTime = DateTime.now();
    final timeElapsed =
        currentTime.difference(_startTime).inMilliseconds / 1000.0;

    if (timeElapsed > 0) {
      _typedCharacters = widget.textController.text.length;
      _typingSpeed = _typedCharacters / timeElapsed; // Characters per second

      _adjustAnimationSpeed();
    }
  }

  void _adjustAnimationSpeed() {
    final speedMultiplier = widget.speedMultiplier;
    final newSpeed = 1.0 + (_typingSpeed * 0.1 * speedMultiplier);
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.assetPath,
      controller: _animationController,
      onLoaded: (composition) {
        _defaultDuration = composition.duration;
        _animationController.duration = _defaultDuration;
        _animationController.repeat();
      },
    );
  }
}
