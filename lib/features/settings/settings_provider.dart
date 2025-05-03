import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  // Notification Settings
  final ValueNotifier<bool> _notificationsEnabled = ValueNotifier(true);
  ValueNotifier<bool> get notificationsEnabled => _notificationsEnabled;

  // Theme Settings
  final ValueNotifier<bool> _darkModeEnabled = ValueNotifier(false);
  ValueNotifier<bool> get darkModeEnabled => _darkModeEnabled;

  void toggleNotifications() {
    _notificationsEnabled.value = !_notificationsEnabled.value;
    notifyListeners();
  }

  void toggleDarkMode() {
    _darkModeEnabled.value = !_darkModeEnabled.value;
    notifyListeners();
  }
}
