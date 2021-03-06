import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_turkce/provider/theme_provider.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  late SharedPreferences _prefs;
  late bool isDarkMode;
  bool isLoading = true;

  void _initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _initSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Switch.adaptive(
        value: _prefs.getBool("isDarkMode")!,
        activeColor: Colors.lightGreenAccent.shade700,
        onChanged: (value) async {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          await provider.toggleTheme(value);
        });
  }
}
