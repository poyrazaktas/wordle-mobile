import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int attemptCtr = 0;
  String attempt1 = "",
      attempt2 = "",
      attempt3 = "",
      attempt4 = "",
      attempt5 = "",
      attempt6 = "";

  final TextStyle _textStyle =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final _defaultContainerColor = Colors.blueGrey[900];
  // final _wrongSpotContainerColor = Colors.amber;
  // final _correctSpotContainerColor = Colors.green[700];

  final inputController = TextEditingController();
  void _clearInput() {
    inputController.clear();
  }

  String _createLetter(String attempt, index) {
    try {
      return attempt[index];
    } catch (e) {
      return "";
    }
  }

  Widget _buildGameBody() {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.all(50),
            crossAxisSpacing: 3,
            mainAxisSpacing: 5,
            crossAxisCount: 5,
            children: [
              //attempt1
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              //attempt2
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              //attempt3
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              //attempt4
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              //attempt5
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              //attempt6
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: _defaultContainerColor),
            ],
          ),
        ),
        TextField(
          controller: inputController,
          autofocus: true,
          maxLength: 5,
          onChanged: (value) {
            switch (attemptCtr) {
              case 0:
                setState(() {
                  attempt1 = value;
                });
                break;
              case 1:
                setState(() {
                  attempt2 = value;
                });
                break;
              case 2:
                setState(() {
                  attempt3 = value;
                });
                break;
              case 3:
                setState(() {
                  attempt4 = value;
                });
                break;
              case 4:
                setState(() {
                  attempt5 = value;
                });
                break;
              case 5:
                setState(() {
                  attempt6 = value;
                });
                break;
              default:
            }
          },
          onSubmitted: (value) {
            var conditionOnAttemptCount = attemptCtr;
            switch (conditionOnAttemptCount) {
              case 0:
                if (attempt1.length == 5) {
                  setState(() {
                    attemptCtr++;
                  });
                  _clearInput();
                }
                break;
              case 1:
                if (attempt2.length == 5) {
                  setState(() {
                    attemptCtr++;
                  });
                  _clearInput();
                }
                break;
              case 2:
                if (attempt3.length == 5) {
                  setState(() {
                    attemptCtr++;
                  });
                  _clearInput();
                }
                break;
              case 3:
                if (attempt4.length == 5) {
                  setState(() {
                    attemptCtr++;
                  });
                  _clearInput();
                }
                break;
              case 4:
                if (attempt5.length == 5) {
                  setState(() {
                    attemptCtr++;
                  });
                  _clearInput();
                }
                break;
              case 5:
                if (attempt6.length == 5) {
                  setState(() {
                    // last attempt requires different handling
                  });
                  _clearInput();
                }
                break;
              default:
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wordle Türkçe"),
        centerTitle: true,
      ),
      body: _buildGameBody(),
    );
  }
}
