import 'package:travel_ease/common/utils/imports.dart';
import 'package:travel_ease/features/auth/services/signout_service.dart';

class SignOutProvider with ChangeNotifier {
  final SignOutService _signOutService = SignOutService();
  bool _isSigningOut = false;

  bool get isSigningOut => _isSigningOut;

  Future<bool> signOutUser(BuildContext context) async {
    _isSigningOut = true;
    notifyListeners();

    try {
      await _signOutService.signOut();
      return true;
    } catch (e) {
      debugPrint("Sign out failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logout failed. Please try again.")),
      );
      return false;
    } finally {
      _isSigningOut = false;
      notifyListeners();
    }
  }
}
