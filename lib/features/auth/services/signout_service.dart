import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ease/imports.dart';

class SignOutService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> signOut(
      {required BuildContext context,
      required VoidCallback onSignOutSuccess}) async {
    try {
      // Firebase sign out
      await _auth.signOut();

      // Google sign out
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Facebook sign out
      await _facebookAuth.logOut();

      // Clear all secure storage
      await _secureStorage.deleteAll();

      debugPrint('User signed out from all providers.');

      // Success snackbar
      if (context.mounted) {
        CustomSnackBar.show(
          context: context,
          message: 'Logged out successfully',
          isError: false,
        );
      }

      // Call the callback to navigate to SignInView
      onSignOutSuccess();
    } catch (e) {
      debugPrint('Sign Out Error: $e');

      if (context.mounted) {
        CustomSnackBar.show(
          context: context,
          message: 'Failed to logout. Please try again.',
          isError: true,
        );
      }

      throw Exception('Failed to sign out: $e');
    }
  }
}
