import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  final String text;
  final Animation<Offset> animation;

  const AnimatedTextWidget(
      {super.key, required this.text, required this.animation});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}
