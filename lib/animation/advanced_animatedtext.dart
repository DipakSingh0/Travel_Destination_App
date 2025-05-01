import 'package:flutter/material.dart';

class AdvancedAnimatedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final Curve curve;
  final double verticalOffset;
  final double horizontalOffset;
  final double scaleStart;
  final bool fadeEnabled;
  final bool slideEnabled;
  final bool scaleEnabled;
  final TextAlign textAlign;

  const AdvancedAnimatedText({
    super.key,
    required this.text,
    this.style = const TextStyle(fontSize: 24),
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeInOut,
    this.verticalOffset = 0,
    this.horizontalOffset = 0,
    this.scaleStart = 0.8,
    this.fadeEnabled = true,
    this.slideEnabled = true,
    this.scaleEnabled = false,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              slideEnabled ? (1 - value) * horizontalOffset : 0,
              slideEnabled ? (1 - value) * verticalOffset : 0,
            )
            ..scale(
                scaleEnabled ? (scaleStart + (value * (1 - scaleStart))) : 1),
          child: Opacity(
            opacity: fadeEnabled ? value : 1.0,
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
