import 'package:evently_app/app_theme.dart';
import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/auth/register_screen.dart';
import 'package:evently_app/home_screen.dart';
import 'package:evently_app/onboarding_screen.dart';
import 'package:evently_app/widget/create_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EventlyApp());
}

class EventlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasSeenOnBoarding(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: OnboardingScreen(),
          );
        } else {
          final bool seenOnboarding = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              LoginScreen.routeName: (_) => LoginScreen(),
              RegisterScreen.routeName: (_) => RegisterScreen(),
              HomeScreen.routeName: (_) => HomeScreen(),
              OnboardingScreen.routeName: (_) => OnboardingScreen(),
              CreateEvent.routeName: (_) => CreateEvent(),
            },
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            themeMode: ThemeMode.light,
            home: seenOnboarding ? LoginScreen() : OnboardingScreen(),
          );
        }
      },
    );
  }

  Future<bool> hasSeenOnBoarding() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('onBoarding_seen') ?? false;
  }
}
