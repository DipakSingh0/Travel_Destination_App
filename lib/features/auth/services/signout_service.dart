// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:travel_ease/common/utils/imports.dart';

// class SignOutService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FacebookAuth _facebookAuth = FacebookAuth.instance;
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   Future<void> signOut(
//       {required BuildContext context,
//       required VoidCallback onSignOutSuccess}) async {
//     try {
//       // Firebase sign out
//       await _auth.signOut();

//       // Google sign out
//       if (await _googleSignIn.isSignedIn()) {
//         await _googleSignIn.signOut();
//       }

//       // Facebook sign out
//       await _facebookAuth.logOut();

//       // Clear all secure storage
//       await _secureStorage.deleteAll();

//       debugPrint('User signed out from all providers.');

//       // Success snackbar
//       if (context.mounted) {
//         CustomSnackBar.show(
//           context: context,
//           message: 'Logged out successfully',
//           isError: false,
//         );
//       }

//       // Call the callback to navigate to SignInView
//       onSignOutSuccess();
//     } catch (e) {
//       debugPrint('Sign Out Error: $e');

//       if (context.mounted) {
//         CustomSnackBar.show(
//           context: context,
//           message: 'Failed to logout. Please try again.',
//           isError: true,
//         );
//       }

//       throw Exception('Failed to sign out: $e');
//     }
//   }
// }

// signout_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOutService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOut() async {
    try {
      // Disconnect Google Sign-In session
      await _googleSignIn.disconnect();

      // Optional: Also sign out from GoogleSignIn (in case disconnect fails silently)
      await _googleSignIn.signOut();

      // Then sign out from Firebase
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
