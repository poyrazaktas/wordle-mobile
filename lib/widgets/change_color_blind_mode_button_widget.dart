import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_turkce/provider/color_blind_mode_provider.dart';

class ChangeColorBlindModeButtonWidget extends StatefulWidget {
  @override
  State<ChangeColorBlindModeButtonWidget> createState() =>
      _ChangeColorBlindModeButtonWidgetState();
}

class _ChangeColorBlindModeButtonWidgetState
    extends State<ChangeColorBlindModeButtonWidget> {
  late SharedPreferences _prefs;
  late bool isColorBlindModeActive;

  void _initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    _initSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorBlindModeProvider = Provider.of<ColorBlindModeProvider>(context);

    return Switch.adaptive(
        value: _prefs.getBool("isColorBlindModeActive")!,
        activeColor: Colors.lightGreenAccent.shade700,
        onChanged: (value) async{
          final provider =
              Provider.of<ColorBlindModeProvider>(context, listen: false);
          await provider.toggleMode(value);
        });
  }
}
