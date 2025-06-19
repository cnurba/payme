import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    colorScheme: ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.amber,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green, // Цвет кнопок
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Скругление углов кнопок
      ),
      // Цвет текста кнопок
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(color: Colors.green),
      unselectedLabelStyle: TextStyle(color: Colors.grey),
    ),
    // ...другие параметры темы...
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
    colorScheme: ColorScheme.dark(
      primary: Colors.green[700]!,
      secondary: Colors.amber[700]!,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green[700], // Цвет кнопок
      textTheme: ButtonTextTheme.primary, // Цвет текста кнопок
    ),
    // ...другие параметры темы...
  );
}
