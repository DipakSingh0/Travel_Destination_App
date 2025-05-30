import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ease/features/auth/services/auth_service.dart';
import 'package:travel_ease/imports.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  
  @override
  void dispose() {
    _nameController.dispose();
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
      appBar: AppBar(
          backgroundColor: AppColors.kWhite,
          elevation: 0,
          leading: const BackButton(
            color: AppColors.kBlue,
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(

              children: [
                // const SizedBox(height: 25),

                const Text('Create Account',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 5),
                const Text('Just one step away',
                    style: TextStyle(fontSize: 14, color: AppColors.kGrey60)),
                const SizedBox(height: 30),
                // FullName.
                AuthField(
                  title: 'Full Name',
                  hintText: 'Enter your name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else if (!RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$')
                        .hasMatch(value.trim())) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                // Email Field.
                AuthField(
                  title: 'E-mail',
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
                const SizedBox(height: 30),
                PrimaryButton(
                     onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserCredential userCredential = await AuthService
                            .instance
                            .registerWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          fullName: _nameController.text.trim(),
                        );
                        if (userCredential.user != null) {
                          _showSnackBar(
                              'Registration successful! Please sign in.',
                              isError: false);
                          context.go('/sign_in'); // Navigate to sign-in page
                        }
                      } catch (e) {
                        _showSnackBar(e.toString());
                      }
                    }
                  },
                  text: 'Create An Account',
                ),
                const SizedBox(height: 30),
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


