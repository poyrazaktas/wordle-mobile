import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.dark(primary: Colors.black, onPrimary: Colors.white));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,

      colorScheme: const ColorScheme.light(primary: Colors.white, onPrimary: Colors.black));
}
