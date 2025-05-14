import 'package:hero_anim/features/auth/view/sign_in/sign_in_view.dart';
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
          const SizedBox(height: 120),
          FadeInAnimationWidget(
            child: Image.asset(
              AppAssets.kWelcome,
              height: 200,
              width: screenWidth,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 100),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PositionAnimationWidget(
                    begin: const Offset(-1.5, -2.5),
                    end: const Offset(-0.9, -0.5),
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  PositionAnimationWidget(
                    begin: const Offset(-1.5, -2.5),
                    end: const Offset(-1.0, -0.5),
                    child: Text(
                      "to",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  PositionAnimationWidget(
                    begin: const Offset(1.0, -2.5),
                    end: const Offset(0.5, -0.5),
                    child: Text(
                      "Destination",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  PositionAnimationWidget(
                    begin: const Offset(6.5, -2.5),
                    end: const Offset(3.5, -0.5),
                    child: Text(
                      "App",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(40),
          //   child: FadeInAnimationWidget(
          //     duration: const Duration(seconds: 2),
          //     child: PrimaryButton(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => SignInView()),
          //         );
          //       },
          //       text: "Let's Start",
          //     ),
          //   ),
          // ),
          PositionAnimationWidget(
            begin: const Offset(0.0,1.2), 
            end: const Offset(0.0, -0.5),

            child: PrimaryButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInView()),
                );
              },
              text: "Let's Start",
            ),
          ),
          // const SizedBox(
          //   height: 50,
          // ),
        ],
      ),
    );
  }
}
