import 'package:hero_anim/imports.dart';

class ProfileImage extends StatelessWidget {
  final String imagePath;
  final double radius;
  final VoidCallback? onTap;
  final bool showEditIcon;

  const ProfileImage({
    super.key,
    required this.imagePath,
    this.radius = 40,
    this.onTap,
    this.showEditIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: 'profile_image',
            child: CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey[200],
              backgroundImage: _getProfileImage(),
              child: _shouldShowPlaceholder()
                  ? Icon(
                      Icons.person,
                      size: radius,
                      color: Colors.grey[600],
                    )
                  : null,
            ),
          ),
          if (showEditIcon && onTap != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  ImageProvider? _getProfileImage() {
    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else if (imagePath.startsWith('assets/')) {
      return AssetImage(imagePath);
    } else if (imagePath.isNotEmpty) {
      return FileImage(File(imagePath));
    }
    return null;
  }

  bool _shouldShowPlaceholder() {
    return imagePath.isEmpty ||
        (!imagePath.startsWith('http') &&
            !imagePath.startsWith('assets/') &&
            !File(imagePath).existsSync());
  }
}
