import 'package:hero_anim/imports.dart';

class DrawerWidget extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String profileImageUrl;
  final VoidCallback? onProfileTap;

  const DrawerWidget({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.profileImageUrl,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Drawer(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Watch for profile changes in Hive
          ValueListenableBuilder<Box<Profile>>(
            valueListenable: Hive.box<Profile>('profiles').listenable(),
            builder: (context, box, _) {
              final profile = box.isNotEmpty ? box.getAt(0) : null;
              final userName = profile?.name ?? 'Guest User';
              final userEmail = profile?.email ?? 'guest@example.com';
              final profileImage =
                  profile?.imagePath ?? 'assets/default_profile.png';

              return UserAccountsDrawerHeader(
                accountName: Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(userEmail),
                currentAccountPicture:
                // creating animation between pages with hero widget tag-profile_image
                // adding this to drawer too where we want animation
                // Hero(
                //   tag: 'profile_image',
                //   child: ProfileImage(
                //     imagePath: profileImage,
                //     radius: 45,
                //     onTap: onProfileTap,
                //   ),
                // ),
                 ProfileImage(
                   imagePath: profileImage,
                   radius: 45,
                   onTap: onProfileTap,
                 ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                onDetailsPressed: onProfileTap,
              );
            },
          ),

          // Navigation items
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Navigator.pop(context); // Close drawer first
              Navigator.push(
                  context,
                  CustomPageRoute(
                    builder: (_) => ProfilePage(),
                  ));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.favorite),
          //   title: const Text('Favorites'),
          //   onTap: () {
          //     // Navigator.pop(context);
          //     Navigator.push(
          //         context,
          //         CustomPageRoute(
          //           builder: (_) => FavoritePage(),
          //         ));
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     CustomPageRoute(
              //       builder: (_) => SettingsPage(),
              //     ));
            },
          ),

          // Notification Toggle
          ValueListenableBuilder<bool>(
            valueListenable: settingsProvider.notificationsEnabled,
            builder: (context, enabled, child) => SwitchListTile(
              title: const Text('Notifications'),
              value: enabled,
              onChanged: (value) => settingsProvider.toggleNotifications(),
              secondary: const Icon(Icons.notifications),
            ),
          ),

          // Dark Mode Toggle
          ValueListenableBuilder<bool>(
            valueListenable:
                Provider.of<SettingsProvider>(context).darkModeEnabled,
            builder: (context, enabled, child) => SwitchListTile(
              title: const Text('Dark Mode'),
              value: enabled,
              onChanged: (value) =>
                  Provider.of<SettingsProvider>(context, listen: false)
                      .toggleDarkMode(),
              secondary: Icon(enabled ? Icons.dark_mode : Icons.light_mode),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
