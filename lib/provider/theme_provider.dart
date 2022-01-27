import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode;
  bool isDarkMode;

  ThemeProvider({required this.isDarkMode}) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme(bool isOn) async {
    var prefs = await SharedPreferences.getInstance();

    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    prefs.setBool("isDarkMode", isOn);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.dark(
          primary: Colors.black, onPrimary: Colors.white));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.light(
          primary: Colors.white, onPrimary: Colors.black));
}
