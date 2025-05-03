import 'package:flutter/material.dart';
import 'package:hero_anim/model/destination_model.dart';
import 'package:hero_anim/model/profile_model.dart';
import 'package:hero_anim/pages/welcome_screen.dart';
import 'package:hero_anim/provider/categories_provider.dart';
import 'package:hero_anim/provider/destination_provider.dart';
import 'package:hero_anim/provider/settings_provider.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(DestinationAdapter());
  // Open favorites box
  await Hive.openBox<Destination>('favorites');


  Hive.registerAdapter(ProfileAdapter());
  await Hive.openBox<Profile>('profiles');


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = DestinationProvider();
            provider.loadFavoritesStatus(); // Load favorites status
            return provider;
          },
        ),
        
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),

        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      // home: HomePage(),
      home: const WelcomeScreen(),
    );
  }
}
