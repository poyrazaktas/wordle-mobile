import 'package:flutter/material.dart';

class ColorBlindModeProvider extends ChangeNotifier {
  ContainerStyles colorBlindMode = ColorBlindMode.colorBlindModeOff;
  bool get isColorBlindModeActive => !colorBlindMode.mode;

  void toggleMode(bool isOn) {
    colorBlindMode = isOn
        ? ColorBlindMode.colorBlindModeOn
        : ColorBlindMode.colorBlindModeOff;
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
