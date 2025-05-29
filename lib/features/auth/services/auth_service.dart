import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

class AuthService {
  AuthService._privateConstructor(); 
  static final AuthService instance = AuthService._privateConstructor();

  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final GoogleSignIn _googleSignIn = GoogleSignIn(); 
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  // --- Email/Password Authentication ---

  /// Registers a new user with email and password.
  /// Returns a UserCredential on success, throws an Exception on failure.
  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName, 
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user display name 
      await userCredential.user?.updateDisplayName(fullName);

      // Save user information securely 
      await _saveUserData(userCredential.user);

      debugPrint('User registered: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else {
        errorMessage =
            e.message ?? 'An unknown error occurred during registration.';
      }
      debugPrint('Registration Error: $errorMessage');
      throw Exception(errorMessage);
    } catch (e) {
      debugPrint('Registration Error: $e');
      throw Exception('Failed to register: $e');
    }
  }

  /// Signs in a user with email and password.
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveUserData(userCredential.user);

      debugPrint('User signed in: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Invalid email or password.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred during sign-in.';
      }
      debugPrint('Sign-In Error: $errorMessage');
      throw Exception(errorMessage);
    } catch (e) {
      debugPrint('Sign-In Error: $e');
      throw Exception('Failed to sign in: $e');
    }
  }

  /// Sends a password reset email to the given email address.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent to $email');
    } on FirebaseAuthException catch (e) {
      debugPrint('Password Reset Error: ${e.message}');
      throw Exception(e.message ?? 'Failed to send password reset email.');
    } catch (e) {
      debugPrint('Password Reset Error: $e');
      throw Exception('Failed to send password reset email: $e');
    }
  }

  // --- Google Authentication ---

  /// Signs in a user with Google.
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // -- user canceled the sign-in flow
        debugPrint('Google Sign-In cancelled by user.');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Save user information securely (optional)
      await _saveUserData(userCredential.user);

      debugPrint('User signed in with Google: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Google Sign-In Error (FirebaseAuthException): ${e.message}');
      throw Exception(e.message ?? 'Failed to sign in with Google.');
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  // --- Facebook Authentication ---

  // Future<UserCredential?> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await _facebookAuth.login();

  //     if (result.status == LoginStatus.success) {
  //       // Get the access token
  //       final AccessToken accessToken = result.accessToken!;

  //       final OAuthCredential credential =
  //           FacebookAuthProvider.credential(accessToken.token);

  //       // Sign in to Firebase with the credential
  //       UserCredential userCredential =
  //           await _auth.signInWithCredential(credential);

  //       await _saveUserData(userCredential.user);

  //       debugPrint(
  //           'User signed in with Facebook: ${userCredential.user?.email}');
  //       return userCredential;
  //     } else if (result.status == LoginStatus.cancelled) {
  //       debugPrint('Facebook Sign-In cancelled by user.');
  //       return null;
  //     } else {
  //       debugPrint('Facebook Sign-In Error: ${result.message}');
  //       throw Exception(result.message ?? 'Failed to sign in with Facebook.');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint(
  //         'Facebook Sign-In Error (FirebaseAuthException): ${e.message}');
  //     throw Exception(e.message ?? 'Failed to sign in with Facebook.');
  //   } catch (e) {
  //     debugPrint('Facebook Sign-In Error: $e');
  //     throw Exception('Failed to sign in with Facebook: $e');
  //   }
  // }

  // --- Logout ---

  /// Signs out the current user from all authentication providers.
  Future<void> signOut() async {
    try {
      await _auth.signOut();

      // Sign out from Google (if previously signed in via Google)
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      await _facebookAuth.logOut();

      // Clear any stored user data
      await _secureStorage.delete(key: 'user_token'); 
      await _secureStorage.delete(key: 'user_email'); 

      debugPrint('User signed out successfully.');
    } catch (e) {
      debugPrint('Sign Out Error: $e');
      throw Exception('Failed to sign out: $e');
    }
  }

  // --- User Session Management / Storage ---

  /// Save user data e.g., UID, email
  Future<void> _saveUserData(User? user) async {
    if (user != null) {
      await _secureStorage.write(key: 'user_uid', value: user.uid);
      await _secureStorage.write(key: 'user_email', value: user.email);
      // You might also save display name, photo URL, etc.
      // String? token = await user.getIdToken();
      // if (token != null) {
      //   await _secureStorage.write(key: 'user_token', value: token);
      // }
      debugPrint('User data saved for: ${user.email}');
    } else {
      await _secureStorage.deleteAll(); // Clear all user data if user is null
    }
  }

  /// Check if a user is currently logged in.
  Future<bool> isLoggedIn() async {
    // Check Firebase's current user
    if (_auth.currentUser != null) {
      return true;
    }
    String? storedUid = await _secureStorage.read(key: 'user_uid');
    return storedUid != null;
  }

  /// Get the currently logged-in Firebase user.
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
