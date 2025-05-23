// GoRouter configuration
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hero_anim/features/auth/view/sign_in/sign_in_view.dart';
import 'package:hero_anim/imports.dart';
import 'package:hero_anim/features/core/view/map_screen1.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    //  GoRoute(
    //   path: '/',
    //   builder: (context, state) => const WelcomeScreen(),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: '/sign_in',
      builder: (context, state) => const SignInView(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) =>  MapScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
     
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final destination = state.extra as Destination;
        final params = state.uri.queryParameters;
        return DetailPage(
          destination: destination,
          categoryName: params['category'],
          itemName: params['item'],
        );
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    Stripe.publishableKey = stripePublishableKey;
    await Stripe.instance.applySettings();
  } catch (e) {
    debugPrint('Stripe initialization failed: $e');
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Destination App',
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      routerConfig: _router,
    );
  }
}
