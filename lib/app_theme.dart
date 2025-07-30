import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF5669FF);
  static const Color backGroundLight = Color(0xFFF2FEFF);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color black = Color(0xFF2C2C2C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF5659);
  static const Color grey = Color(0xFF7B7B7B);

  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: backGroundLight,
<<<<<<< HEAD
=======
    appBarTheme: AppBarTheme(
      backgroundColor: backGroundLight,
      centerTitle: true,
      foregroundColor: primary,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
    ),
>>>>>>> development
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: white,
      unselectedItemColor: white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(color: white, width: 5)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: grey,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      enabledBorder: OutlineInputBorder(
<<<<<<< HEAD
        borderSide: BorderSide(color: grey),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: grey),
=======
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
>>>>>>> development
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: red),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: red),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: black,
        fontWeight: FontWeight.w500,
      ),
<<<<<<< HEAD
=======
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      headlineLarge: TextStyle(
        fontSize: 36,
        color: primary,
        fontWeight: FontWeight.bold,
      ),
>>>>>>> development
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
<<<<<<< HEAD
=======
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        iconSize: 33,
        foregroundColor: primary,
        shape: CircleBorder(side: BorderSide(color: primary)),
      ),
    ),
>>>>>>> development
  );

  static ThemeData darkMode = ThemeData();
}
