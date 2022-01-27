import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorBlindModeProvider extends ChangeNotifier {

  late ContainerStyles colorBlindMode;
  bool isColorBlindModeActive;


  ColorBlindModeProvider({required this.isColorBlindModeActive}){
    colorBlindMode = isColorBlindModeActive ? ColorBlindMode.colorBlindModeOn : ColorBlindMode.colorBlindModeOff;
  }

  Future<void> toggleMode(bool isOn) async {
    var prefs = await SharedPreferences.getInstance();

    colorBlindMode = isOn
        ? ColorBlindMode.colorBlindModeOn
        : ColorBlindMode.colorBlindModeOff;
    prefs.setBool("isColorBlindModeActive",isOn);
    notifyListeners();
  }
}

class ColorBlindMode {
  static final ContainerStyles colorBlindModeOn = ContainerStyles(
      mode: true,
      wrongSpotContainerColor: Colors.amber.shade900,
      correctSpotContainerColor: Colors.blue);

  static final ContainerStyles colorBlindModeOff = ContainerStyles(
      mode: false,
      wrongSpotContainerColor: Colors.amber,
      correctSpotContainerColor: Colors.green.shade700);
}

class ContainerStyles {
  late Color wrongSpotContainerColor;
  late Color correctSpotContainerColor;
  late bool mode;

  ContainerStyles(
      {required this.wrongSpotContainerColor,
      required this.correctSpotContainerColor,
      required this.mode});
}
