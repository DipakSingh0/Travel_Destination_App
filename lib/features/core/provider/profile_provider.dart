import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hero_anim/features/core/model/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  late Box<Profile> _profileBox;
  Profile? _profile;

  Future<void> initProfile() async {
    _profileBox = await Hive.openBox<Profile>('profiles');
    if (_profileBox.isEmpty) {
      _profile = Profile(
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+1 234 567 890',
        address: '123 Main St, City, Country',
        imagePath: 'assets/default_profile.png',
        bio: 'Flutter enthusiast',
      );
      await _profileBox.add(_profile!);
    } else {
      _profile = _profileBox.getAt(0);
    }
    notifyListeners();
  }

  Profile? get profile => _profile;

  Future<void> updateProfile(Profile updatedProfile) async {
    await _profileBox.putAt(0, updatedProfile);
    _profile = updatedProfile;
    notifyListeners();
  }
}
