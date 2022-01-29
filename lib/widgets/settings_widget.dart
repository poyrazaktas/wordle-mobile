import 'package:flutter/material.dart';
import 'package:wordle_turkce/widgets/change_color_blind_mode_button_widget.dart';
import 'package:wordle_turkce/widgets/change_theme_button_widget.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Zor Mod (Geliştirme altında)"),
                    Switch(
                      value: false,
                      onChanged: null,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.withOpacity(0.5),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Renk Körü Modu"),
                    ChangeColorBlindModeButtonWidget()
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Koyu Tema"),
                    ChangeThemeButtonWidget()
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
