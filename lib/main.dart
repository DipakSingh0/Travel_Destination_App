import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:travel_ease/features/auth/view/welcome/welcome_screen.dart';
import 'package:travel_ease/features/core/services/firebase_options.dart';
import 'package:travel_ease/common/utils/imports.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    Stripe.publishableKey = stripePublishableKey;
    await Stripe.instance.applySettings();
  } catch (e) {
    debugPrint('Stripe initialization failed: $e');
  }

  // ---- Initializing Hive
  await Hive.initFlutter();

  // ------Register adapter
  Hive.registerAdapter(DestinationAdapter());
  // ------Open favorites box
  await Hive.openBox<Destination>('favorites');

  Hive.registerAdapter(ProfileAdapter());
  await Hive.openBox<Profile>('profiles');

  // Initializing AuthProvider and loading user state
  final authProvider = AuthProvider();
  await authProvider.loadUser();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => SignOutProvider()),
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
          create: (_) => CategoryProvider(),
        ),
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

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp.router(
  //     title: 'TravelEase',
  //     debugShowCheckedModeBanner: false,
  //     checkerboardOffscreenLayers: true,
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //       useMaterial3: false,
  //     ),
  //     routerConfig: router,
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      // home: Consumer<AuthProvider>(
      //   builder: (context, authProvider, child) {
      //     if (authProvider.user != null) {
      //       return HomePage();
      //     } else {
      //       return WelcomeScreen();
      //     }
      //   },
      // ),
    );
  }
}
