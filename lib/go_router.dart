// // router.dart
// import 'package:travel_ease/features/auth/view/sign_in/sign_in_view.dart';
// import 'package:travel_ease/features/core/view/map_screen1.dart';
// import 'package:travel_ease/imports.dart';

// final router = GoRouter(
//   initialLocation: '/',
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomePage(),
//     ),
//     GoRoute(
//       path: '/sign_up',
//       builder: (context, state) => const SignUpView(),
//     ),
//     GoRoute(
//       path: '/sign_in',
//       builder: (context, state) => const SignInView(),
//     ),
//     GoRoute(
//       path: '/map',
//       builder: (context, state) => const MapScreen(),
//     ),
//     GoRoute(
//       path: '/profile',
//       builder: (context, state) => const ProfilePage(),
//     ),
//     GoRoute(
//       path: '/details',
//       builder: (context, state) {
//         final destination = state.extra as Destination;
//         return DetailPage(destination: destination);
//       },
//     ),
//   ],
// );
