import 'package:hero_anim/imports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 80),

          FadeInAnimationWidget(
            child: Image.asset(
              'assets/images/welcome.png',
              height: 200,
              width: screenWidth,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 40),

          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PositionAnimationWidget(
                    begin: const Offset(-1.5, -2.5),
                    end: const Offset(-0.9, -0.5),
                    child: Text("Welcome" , style: TextStyle(
                      fontSize: 25 , fontWeight: FontWeight.w700,  
                    ),),
                  ),
                  PositionAnimationWidget(
                    begin: const Offset(-1.5, -2.5),
                    end: const Offset(-1.0, -0.5),
                    child: Text("to" ,style: TextStyle(
                      fontSize: 25 , fontWeight: FontWeight.w700,  
                    ),),
                  ),
                  PositionAnimationWidget(
                    begin: const Offset(1.0, -2.5),
                    end: const Offset(0.5, -0.5),
                    child: Text("Destination",  style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  PositionAnimationWidget(
                    begin: const Offset(6.5, -2.5),
                    end: const Offset(3.5, -0.5),
                    child: Text("App",  style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Animated Button
          FadeInAnimationWidget(
            duration: const Duration(seconds: 2),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () {
                 
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
