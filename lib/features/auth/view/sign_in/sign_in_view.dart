// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ease/features/auth/services/auth_service.dart';
import 'package:travel_ease/imports.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRemember = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Helper function to show a snackbar
  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      // appBar: AppBar(
      //     backgroundColor: AppColors.kWhite,
      //     elevation: 0,
      //     leading: const BackButton(
      //       color: AppColors.kBlue,
      //     )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Text('Let’s Sign you in',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 10),
                const Text(
                  'Connect with Us!',
                  style: TextStyle(fontSize: 14, color: AppColors.kGrey60),
                ),
                const SizedBox(height: 30),
                // Email Field.
                AuthField(
                  title: 'Email Address',
                  hintText: 'Enter your email address',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                // Password Field.
                AuthField(
                  title: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password should be at least 8 characters long';
                    }
                    return null;
                  },
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    RememberMeCard(
                      onChanged: (value) {
                        setState(() {
                          isRemember = value;
                        });
                      },
                    ),
                    const Spacer(),
                    CustomTextButton(
                      onPressed: () {},
                      text: 'Forget Password',
                    ),

                    //  CustomTextButton(
                    //   onPressed: () async {
                    //     // Handle Forgot Password
                    //     final String email = _emailController.text.trim();
                    //     if (email.isEmpty) {
                    //       _showSnackBar(
                    //           'Please enter your email to reset password.');
                    //       return;
                    //     }
                    //     try {
                    //       await AuthService.instance
                    //           .sendPasswordResetEmail(email);
                    //       _showSnackBar('Password reset email sent!',
                    //           isError: false);
                    //     } catch (e) {
                    //       _showSnackBar(e.toString());
                    //     }
                    //   },
                    //   text: 'Forget Password',
                    // ),
                  ],
                ),
                const SizedBox(height: 15),
                PrimaryButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserCredential userCredential = await AuthService
                            .instance
                            .signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        if (userCredential.user != null) {
                          _showSnackBar('Sign in successful!', isError: false);
                          // Navigate to home page and remove all previous routes
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      } catch (e) {
                        _showSnackBar(e.toString());
                      }
                    }
                  },
                  text: 'Sign In',
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Don’t have an account? ',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpView()));
                            // context.go('/sign_up');
                          },
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.kBlue),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const TextWithDivider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomSocialButton(
                      onTap: () async {
                        try {
                          UserCredential? userCredential =
                              await AuthService.instance.signInWithGoogle();
                          if (userCredential != null &&
                              userCredential.user != null) {
                            _showSnackBar('Signed in with Google!',
                                isError: false);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false,
                            );
                          }
                        } catch (e) {
                          _showSnackBar(e.toString());
                        }
                      },
                      icon: AppAssets.kGoogle,
                    ),
                    CustomSocialButton(
                      // onTap: () {},
                      onTap: () {
                        _showSnackBar('Apple Sign-In not implemented.');
                      },
                      icon: AppAssets.kApple,
                    ),
                    CustomSocialButton(
                      onTap: () async {
                        // try {
                        //   UserCredential? userCredential =
                        //       await AuthService.instance.signInWithFacebook();
                        //   if (userCredential != null &&
                        //       userCredential.user != null) {
                        //     _showSnackBar('Signed in with Facebook!',
                        //         isError: false);
                        //     Navigator.pushAndRemoveUntil(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const HomePage()),
                        //       (Route<dynamic> route) => false,
                        //     );
                        //   }
                        // } catch (e) {
                        //   _showSnackBar(e.toString());
                        // }
                      },
                      icon: AppAssets.kFacebook,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const AgreeTermsTextCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
