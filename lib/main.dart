import 'package:evently_app/app_theme.dart';
import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/auth/register_screen.dart';
import 'package:evently_app/edit_event.dart';
import 'package:evently_app/event_details.dart';
import 'package:evently_app/home_screen.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/onboarding_screen.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/providers/userProvider.dart';
import 'package:evently_app/widget/create_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Userprovider()),
        ChangeNotifierProvider(create: (_) => EventProvider()..getEvents()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: EventlyApp(),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
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
              EventDetails.routeName: (_) => EventDetails(),
              EditEvent.routeName: (_) => EditEvent(),
            },
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            themeMode: settingsProvider.themeMode,
            home: seenOnboarding ? LoginScreen() : OnboardingScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(settingsProvider.languageCode),
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
