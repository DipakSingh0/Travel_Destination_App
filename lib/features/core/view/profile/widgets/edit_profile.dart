// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hero_anim/features/core/model/profile_model.dart';
import 'package:hero_anim/features/core/view/profile/widgets/profile_image_widget.dart';

class EditProfileDialog extends StatefulWidget {
  final Profile initialProfile;
  final Function(Profile) onSave;

  const EditProfileDialog({
    super.key,
    required this.initialProfile,
    required this.onSave,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _bioController;
  String? _imagePath;
  bool _isProcessingImage = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialProfile.name);
    _emailController = TextEditingController(text: widget.initialProfile.email);
    _phoneController = TextEditingController(text: widget.initialProfile.phone);
    _addressController =
        TextEditingController(text: widget.initialProfile.address);
    _bioController = TextEditingController(text: widget.initialProfile.bio);
    _imagePath = widget.initialProfile.imagePath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() => _isProcessingImage = true);

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
          _isProcessingImage = false;
        });
      } else {
        setState(() => _isProcessingImage = false);
      }
    } catch (e) {
      setState(() => _isProcessingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isProcessingImage,
      child: AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isProcessingImage)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                )
              else
                GestureDetector(
                  onTap: () => _showImageSourceDialog(context),
                  child: ProfileImage(
                    imagePath: _imagePath ?? widget.initialProfile.imagePath,
                    radius: 50,
                    onTap: () => _showImageSourceDialog(context),
                    showEditIcon: true,
                  ),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _isProcessingImage
                    ? null
                    : () => _showImageSourceDialog(context),
                child: const Text('Change Profile Picture'),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          if (!_isProcessingImage) ...[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: _saveProfile,
              child: const Text('Save'),
            ),
          ],
        ],
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    final updatedProfile = widget.initialProfile.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      bio: _bioController.text,
      imagePath: _imagePath ?? widget.initialProfile.imagePath,
    );
    widget.onSave(updatedProfile);
    Navigator.pop(context);
  }
}
