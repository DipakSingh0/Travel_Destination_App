import 'package:flutter/material.dart';
import 'package:travel_ease/features/auth/services/signout_service.dart';
import 'package:travel_ease/features/auth/view/sign_in/sign_in_view.dart';

class SignOutProvider with ChangeNotifier {
  final SignOutService _signOutService = SignOutService();

  Future<void> logoutUser(BuildContext context) async {
    await _signOutService.signOut(
      context: context,
      onSignOutSuccess: () {
        debugPrint('Navigating to SignInView');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignInView(),
          ),
        ); // Navigate to SignInView
      },
    );

    notifyListeners();
  }
}
