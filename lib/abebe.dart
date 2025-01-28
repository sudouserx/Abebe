// lib/abebe.dart

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

class Abebe extends StatefulWidget {
  final String assetPath;
  final TextEditingController textController;
  final AnimationController animationController;
  final double sensitivity;

  const Abebe({
    Key? key,
    required this.assetPath,
    required this.textController,
    required this.animationController,
    this.sensitivity = 0.2,
  }) : super(key: key);

  @override
  _AbebeState createState() => _AbebeState();
}

class _AbebeState extends State<Abebe> {
  late int _lastTextLength;
  DateTime? _lastTypingTime;
  Duration? _baseDuration;
  double _currentSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _lastTextLength = widget.textController.text.length;
    widget.textController.addListener(_handleTextInput);
    widget.animationController.addListener(_updateAnimation);
  }

  @override
  void dispose() {
    widget.textController.removeListener(_handleTextInput);
    widget.animationController.removeListener(_updateAnimation);
    super.dispose();
  }

  void _handleTextInput() {
    final now = DateTime.now();
    final textLength = widget.textController.text.length;
    
    if (_lastTypingTime != null) {
      final timeDelta = now.difference(_lastTypingTime!).inMilliseconds;
      if (timeDelta > 0) {
        final charDelta = (textLength - _lastTextLength).abs();
        final typingSpeed = charDelta / timeDelta * 1000;
        
        // Calculate new speed based on typing velocity
        _currentSpeed = max(1.0, 1.0 + typingSpeed * widget.sensitivity);
        
        // Immediately apply speed change
        _updateAnimationDuration();
      }
    }

    _lastTextLength = textLength;
    _lastTypingTime = now;
  }

  void _updateAnimation() {
    // Smoothly return to normal speed when inactive
    if (DateTime.now().difference(_lastTypingTime ?? DateTime.now()) > Duration(seconds: 1)) {
      _currentSpeed = max(1.0, _currentSpeed * 0.95);
      _updateAnimationDuration();
    }
  }

  void _updateAnimationDuration() {
    if (_baseDuration == null) return;

    final newDuration = _baseDuration! ~/ _currentSpeed.toInt();
    final progress = widget.animationController.value;

    if (widget.animationController.duration != newDuration) {
      widget.animationController
        ..stop()
        ..duration = newDuration
        ..value = progress.clamp(0.0, 1.0)
        ..repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.assetPath,
      controller: widget.animationController,
      onLoaded: (composition) {
        _baseDuration = composition.duration;
        widget.animationController
          ..duration = _baseDuration
          ..repeat();
      },
    );
  }
}