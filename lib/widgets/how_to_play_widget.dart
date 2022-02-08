import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  HowToPlay({Key? key}) : super(key: key);

  final TextStyle _textStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);

  final _defaultContainerColor = Colors.grey.shade800;
  final _wrongSpotContainerColor = Colors.amber;
  final _correctSpotContainerColor = Colors.green[700];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
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
                const Text(
                  "NASIL OYNANIR?\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("WORDLE'i 6 denemede bulun.\n"),
                const Text(
                    "Her tahmin 5 harfli doğru bir kelime olmalıdır. Göndermek için enter'a basın.\n"),
                const Text(
                    "Her tahminden sonra kutucukların renkleri tahmininizin yakınlığına göre değişecektir.\n"),
                const Divider(
                  thickness: 2.0,
                ),
                const Text("Örnekler",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: const EdgeInsets.all(50),
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 5,
                    crossAxisCount: 5,
                    children: [
                      Container(
                          child: Center(
                              child: Text(
                            "A",
                            style: _textStyle,
                          )),
                          color: _correctSpotContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "B",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "O",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "N",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "E",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                    ],
                  ),
                ),
                const Text("A harfi kelimede var ve doğru yerde."),
                Expanded(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: const EdgeInsets.all(50),
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 5,
                    crossAxisCount: 5,
                    children: [
                      Container(
                          child: Center(
                              child: Text(
                            "G",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "İ",
                            style: _textStyle,
                          )),
                          color: _wrongSpotContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "Z",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "E",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "M",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                    ],
                  ),
                ),
                const Text("İ harfi kelimede var fakat yanlış yerde."),
                Expanded(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: const EdgeInsets.all(50),
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 5,
                    crossAxisCount: 5,
                    children: [
                      Container(
                          child: Center(
                              child: Text(
                            "F",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "A",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "L",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "E",
                            style: _textStyle,
                          )),
                          color: _defaultContainerColor),
                      Container(
                          child: Center(
                              child: Text(
                            "Z",
                            style: _textStyle,
                          )),
                          color: Colors.grey.shade900),
                    ],
                  ),
                ),
                const Text("Z harfi kelimede yok."),
              ],
            )
          ],
        ),
      ),
    );
  }
}
