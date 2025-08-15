import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = "en";

  bool get isDark => themeMode == ThemeMode.dark;

  void changeTheme({required ThemeMode theme}) {
    themeMode = theme;
    notifyListeners();
  }

  void changeLanguage({required String language}) {
    if (languageCode == language) return;
    languageCode = language;
    notifyListeners();
  }
}
