import 'package:flutter/material.dart';
import 'package:hero_anim/common/utils/assets.dart';
import 'package:hero_anim/features/core/model/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  final VoidCallback onEditPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // animation with hero widget seen in profile page
        // add hero widget with saem tag
        Hero(
          tag: 'profile_image',
          child: CircleAvatar(
            radius: 60,
            backgroundImage: profile.imagePath.isNotEmpty
                ? AssetImage(profile.imagePath) 
                : AssetImage(AppAssets.kProfile), 
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profile.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditPressed,
            ),
          ],
        ),
      ],
    );
  }
}
