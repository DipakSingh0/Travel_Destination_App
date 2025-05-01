import 'package:flutter/material.dart';
import 'package:hero_anim/pages/favorites_page.dart';
import 'package:hero_anim/provider/settings_provider.dart';
import 'package:provider/provider.dart';

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
        children: [
          // Header with profile image
           UserAccountsDrawerHeader(
            accountName: Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "images/profile.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
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
          ),

         

          // Navigation items
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const ProfilePage()),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SettingsPage()),
              // );
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
