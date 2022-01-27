import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_turkce/provider/color_blind_mode_provider.dart';

class ChangeColorBlindModeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorBlindModeProvider = Provider.of<ColorBlindModeProvider>(context);

    return Switch.adaptive(
        value: colorBlindModeProvider.colorBlindMode.mode,
        activeColor: Colors.lightGreenAccent.shade700,
        onChanged: (value) {
          final provider =
              Provider.of<ColorBlindModeProvider>(context, listen: false);
          provider.toggleMode(value);
        });
  }
}
