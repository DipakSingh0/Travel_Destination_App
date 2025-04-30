import 'package:flutter/material.dart';
import 'package:hero_anim/pages/welcome_screen.dart';
import 'package:hero_anim/provider/destination_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
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
