import 'package:flutter/material.dart';

class FadeInAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const FadeInAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.easeIn,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FadeInAnimationWidgetState createState() => _FadeInAnimationWidgetState();
}

class _FadeInAnimationWidgetState extends State<FadeInAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
