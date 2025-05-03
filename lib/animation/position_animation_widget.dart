import 'package:flutter/material.dart';

class PositionAnimationWidget extends StatefulWidget {
  final Widget child;
  final Offset begin;
  final Offset end;
  final Duration duration;
  final Curve curve;

  const PositionAnimationWidget({
    super.key,
    required this.child,
    required this.begin,
    required this.end,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeOut,
  });

  @override
  _PositionAnimationWidgetState createState() =>
      _PositionAnimationWidgetState();
}

class _PositionAnimationWidgetState extends State<PositionAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _positionAnimation = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: widget.child,
    );
  }
}
