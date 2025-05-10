import 'package:hero_anim/imports.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider()..initProfile(),
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profile = profileProvider.profile;
          if (profile == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
             appBar: MyAppBar(title: "Profile"),
            // drawer: DrawerWidget(
            //   userName: "Jane Smith",
            //   userEmail: "jane@example.com",
            //   profileImageUrl: "images/profile.jpg",
            // ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ProfileImage(
                    imagePath: profile.imagePath,
                    radius: 60,
                    onTap: () => _showEditDialog(context),
                    showEditIcon: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  _buildProfileItem(Icons.person, 'Name', profile.name),
                  _buildProfileItem(Icons.email, 'Email', profile.email),
                  _buildProfileItem(Icons.phone, 'Phone', profile.phone),
                  _buildProfileItem(
                      Icons.location_on, 'Address', profile.address),
                  _buildProfileItem(Icons.info, 'Bio', profile.bio),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showEditDialog(context),
              child: const Icon(Icons.edit),
            ),
          );
        },
      ),
    );
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
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.profile!;
    showDialog(
      context: context,
      builder: (context) => EditProfileDialog(
        initialProfile: profile,
        onSave: (updatedProfile) =>
            profileProvider.updateProfile(updatedProfile),
      ),
    );
  }
}
