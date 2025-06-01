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
  bool _isLoading = false;
  bool isRemember = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        UserCredential userCredential = await AuthService.instance
            .signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (userCredential.user != null) {
          _showSnackBar('Sign in successful!', isError: false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        _showSnackBar(e.toString());
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      UserCredential? userCredential = await AuthService.instance.signInWithGoogle();
      if (userCredential != null && userCredential.user != null) {
        _showSnackBar('Signed in with Google!', isError: false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      _showSnackBar(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    const _HeaderText(),
                    _FormFields(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isRemember: isRemember,
                      onRememberChanged: (value) {
                        setState(() => isRemember = value);
                      },
                    ),
                    const SizedBox(height: 15),
                    PrimaryButton(
                      onTap: _handleSignIn,
                      text: 'Sign In',
                      // isLoading: _isLoading,
                    ),
                    const SizedBox(height: 20),
                    _BottomActionButtons(
                      onSignUpPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpView()),
                        );
                      },
                      onGooglePressed: _handleGoogleSignIn,
                      onApplePressed: () {
                        _showSnackBar('Apple Sign-In not implemented.');
                      },
                      onFacebookPressed: () {
                        _showSnackBar('Facebook Sign-In not implemented.');
                      },
                    ),
                    const SizedBox(height: 20),
                    const AgreeTermsTextCard(),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 100),
        Text(
          "Let’s Sign you in",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Connect with Us!",
          style: TextStyle(fontSize: 14, color: AppColors.kGrey60),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class _FormFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRemember;
  final ValueChanged<bool> onRememberChanged;

  const _FormFields({
    required this.emailController,
    required this.passwordController,
    required this.isRemember,
    required this.onRememberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email Field
        AuthField(
          title: 'Email Address',
          hintText: 'Enter your email address',
          controller: emailController,
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
        // Password Field
        AuthField(
          title: 'Password',
          hintText: 'Enter your password',
          controller: passwordController,
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
              onChanged: onRememberChanged,
            ),
            const Spacer(),
            CustomTextButton(
              onPressed: () {},
              text: 'Forget Password',
            ),
          ],
        ),
      ],
    );
  }
}

class _BottomActionButtons extends StatelessWidget {
  final VoidCallback onSignUpPressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onFacebookPressed;

  const _BottomActionButtons({
    required this.onSignUpPressed,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onFacebookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "Sign Up",
                recognizer: TapGestureRecognizer()..onTap = onSignUpPressed,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kBlue,
                ),
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
              onTap: onGooglePressed,
              icon: AppAssets.kGoogle,
            ),
            CustomSocialButton(
              onTap: onApplePressed,
              icon: AppAssets.kApple,
            ),
            CustomSocialButton(
              onTap: onFacebookPressed,
              icon: AppAssets.kFacebook,
            ),
          ],
        ),
      ],
    );
  }
}