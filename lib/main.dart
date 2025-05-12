import 'package:hero_anim/features/auth/welcome/welcome_screen.dart';
import 'package:hero_anim/features/core/favorites/provider/favorites_provider.dart';
import 'package:hero_anim/imports.dart';

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
            provider.loadFavoritesStatus();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider()),
        ChangeNotifierProvider(
          create: (context) =>
              FavoritesProvider(
                Hive.box<Destination>('favorites')),
        ),
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
      title: 'Destination App',
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: true, // this will show animation in debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      // home: HomePage(),
      home: const WelcomeScreen(),
      // home: LoginScreen(),
      // home: SignInView()
    );
  }
}
