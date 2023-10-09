import 'package:booking_football_schedule/widget/splash.dart';
import 'package:booking_football_schedule/screen/home_screen.dart';
import 'package:booking_football_schedule/screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.cairoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if(snapshot.hasData) {
            return const HomeScreen();
          }
          return const WelcomeScreen();
        },
      ),
    );
  }
}