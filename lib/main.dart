import 'package:app/pages/home.dart';
import 'package:app/pages/onboarding_business.dart';
import 'package:app/pages/onboarding_mem.dart';
import 'package:app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 0, 0),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 255, 0, 0),
        ),
      ),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: const SplashScreen(),
=======
      home: const onBoardingBus(),
>>>>>>> 07f661c0467f73c8b6f5ddafadc9e5905dc382ce
    );
  }
}
