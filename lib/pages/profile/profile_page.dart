import 'package:flutter/material.dart';
import 'package:hero_anim/pages/profile/edit_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hero_anim/model/profile_model.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Box<Profile> _profileBox;
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    _initProfile();
  }

  Future<void> _initProfile() async {
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
    setState(() {});
  }

  Future<void> _updateProfile(Profile updatedProfile) async {
    await _profileBox.putAt(0, updatedProfile);
    setState(() => _profile = updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Updated Profile Header with image display
            GestureDetector(
              onTap: () => _showEditDialog(context),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _getProfileImage(_profile!),
                    child: _profile!.imagePath.isEmpty
                        ? const Icon(Icons.person, size: 60)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _profile!.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _profile!.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileItem(Icons.person, 'Name', _profile!.name),
            _buildProfileItem(Icons.email, 'Email', _profile!.email),
            _buildProfileItem(Icons.phone, 'Phone', _profile!.phone),
            _buildProfileItem(Icons.location_on, 'Address', _profile!.address),
            _buildProfileItem(Icons.info, 'Bio', _profile!.bio),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(context),
        child: const Icon(Icons.edit),
      ),
    );
  }

  ImageProvider? _getProfileImage(Profile profile) {
    if (profile.imagePath.startsWith('http')) {
      return NetworkImage(profile.imagePath);
    } else if (profile.imagePath.startsWith('assets/')) {
      return AssetImage(profile.imagePath);
    } else if (profile.imagePath.isNotEmpty) {
      return FileImage(File(profile.imagePath));
    }
    return null;
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
          const Divider(height: 24),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditProfileDialog(
        initialProfile: _profile!,
        onSave: _updateProfile,
      ),
    );
  }
}
