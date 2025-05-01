import 'package:flutter/material.dart';
import 'package:hero_anim/pages/home_page.dart';
import 'package:hero_anim/animation/animated_text_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _fadeController;

  late Animation<Offset> _topLeftAnim;
  late Animation<Offset> _topRightAnim;
  late Animation<Offset> _bottomLeftAnim;
  late Animation<Offset> _bottomRightAnim;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _topLeftAnim = Tween<Offset>(
            begin: const Offset(-1.5, -1.5), end:  const Offset(-1.0, -0.5))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _topRightAnim = Tween<Offset>(
            begin: const Offset(1.5, -1.5), end:  const Offset(-1.0, -0.5))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _bottomLeftAnim = Tween<Offset>(
            begin: const Offset(-1.5, 1.5), end: const Offset(0.5, -0.5))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _bottomRightAnim = Tween<Offset>(
            begin: const Offset(1.5, 1.5), end: const Offset(1.5, -0.5))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _controller.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
  }
@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      children: [
        const SizedBox(height: 80),

        //  Fade-in anim Image
        FadeTransition(
          opacity: _fadeAnimation,
          child: Image.asset(
            'images/welcome.jpg',
            height: 200,
            width: screenWidth, 
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 40),

        // Animated Texts from Corners
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedTextWidget(text: "Welcome", animation: _topLeftAnim),
                AnimatedTextWidget(text: "to", animation: _topRightAnim),
                AnimatedTextWidget(text: "the", animation: _bottomLeftAnim),
                AnimatedTextWidget(text: "App", animation: _bottomRightAnim),
              ],
            ),
          ),
        ),

        // animated  Button
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _fadeController,
            curve: Curves.easeOutBack,
          )),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: _navigateToHome,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}