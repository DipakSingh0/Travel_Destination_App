import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ease/imports.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService.instance;
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final userCredential = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
      _user = userCredential.user;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();

      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        _user = userCredential.user;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ... rest of AuthProvider code ...

  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }

  Future<void> loadUser() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}
