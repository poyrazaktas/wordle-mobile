import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_turkce/provider/color_blind_mode_provider.dart';
import 'package:wordle_turkce/widgets/how_to_play_widget.dart';
import 'package:wordle_turkce/widgets/settings_widget.dart';

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

  final String wordle = "çeşni".toLowerCase();

  final TextStyle _textStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);

  final _defaultContainerColor = Colors.grey.shade800;
  late Color _wrongSpotContainerColor;
  late Color _correctSpotContainerColor;

  var attempt1LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt2LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt3LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt4LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt5LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt6LetterStyles = List<Color>.filled(5, Colors.grey.shade800);

  var wordleHash = <String, List<int>>{};

  final inputController = TextEditingController();

  void initContainerStyles() {
    var colorBlindModeProvider =
        Provider.of<ColorBlindModeProvider>(context, listen: false);

    _wrongSpotContainerColor =
        colorBlindModeProvider.colorBlindMode.wrongSpotContainerColor;
    _correctSpotContainerColor =
        colorBlindModeProvider.colorBlindMode.correctSpotContainerColor;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initContainerStyles();
    // initalize wordle as hash map
    for (var i = 0; i < wordle.length; i++) {
      if (!wordleHash.containsKey(wordle[i])) {
        wordleHash[wordle[i]] = [];
        wordleHash[wordle[i]]?.add(i);
      } else {
        wordleHash[wordle[i]]?.add(i);
      }
    }
  }

  void _clearInput() {
    inputController.clear();
  }

  void _showResult(String attempt, String successMessage) {
    if (attempt.toLowerCase() == wordle) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Stack(
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
                  Text(successMessage),
                ],
              ),
            );
          });
    }
  }

  String _createLetter(String attempt, index) {
    try {
      return attempt[index].replaceAll("i", "İ").toUpperCase();
    } catch (e) {
      return "";
    }
  }

  void _handleAttemptLetterStyle(
      List<Color> attemptLetterStyles, String attempt) {
    var attemptHash = List.filled(5, false);
    var tempWordle = List.from(wordle.characters);
    for (var i = 0; i < wordle.length; i++) {
      if (wordle[i] == attempt[i]) {
        attemptLetterStyles[i] = _correctSpotContainerColor;
        attemptHash[i] = true;
        tempWordle[i] = "";
      }
    }

    for (var i = 0; i < wordle.length; i++) {
      if (attemptHash[i] != true && tempWordle.contains(attempt[i])) {
        attemptLetterStyles[i] = _wrongSpotContainerColor;
        tempWordle[tempWordle.indexOf(attempt[i])] = "";
      }
      // print(tempWordle.join("").toString());
    }
  }

  Widget _buildGameBody() {
    return Column(
      children: [
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
              //attempt1
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt1LetterStyles[0]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt1LetterStyles[1]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt1LetterStyles[2]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt1LetterStyles[3]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt1, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt1LetterStyles[4]),
              //attempt2
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt2LetterStyles[0]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt2LetterStyles[1]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt2LetterStyles[2]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt2LetterStyles[3]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt2, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt2LetterStyles[4]),
              //attempt3
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt3LetterStyles[0]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt3LetterStyles[1]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt3LetterStyles[2]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt3LetterStyles[3]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt3, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt3LetterStyles[4]),
              //attempt4
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt4LetterStyles[0]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt4LetterStyles[1]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt4LetterStyles[2]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt4LetterStyles[3]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt4, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt4LetterStyles[4]),
              //attempt5
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt5LetterStyles[0]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt5LetterStyles[1]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt5LetterStyles[2]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt5LetterStyles[3]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt5, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt5LetterStyles[4]),
              //attempt6
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 0).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt6LetterStyles[0]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 1).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt6LetterStyles[1]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 2).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt6LetterStyles[2]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 3).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt6LetterStyles[3]),
              Container(
                  child: Center(
                      child: Text(
                    _createLetter(attempt6, 4).toUpperCase(),
                    style: _textStyle,
                  )),
                  color: attempt6LetterStyles[4]),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 30),
          child: Container(
            decoration: BoxDecoration(
                color: _defaultContainerColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.white)),
            child: TextField(
              controller: inputController,
              autofocus: true,
              maxLength: 5,
              onChanged: (value) {
                switch (attemptCtr) {
                  case 0:
                    setState(() {
                      attempt1 = value.toLowerCase();
                    });
                    break;
                  case 1:
                    setState(() {
                      attempt2 = value.toLowerCase();
                    });
                    break;
                  case 2:
                    setState(() {
                      attempt3 = value.toLowerCase();
                    });
                    break;
                  case 3:
                    setState(() {
                      attempt4 = value.toLowerCase();
                    });
                    break;
                  case 4:
                    setState(() {
                      attempt5 = value.toLowerCase();
                    });
                    break;
                  case 5:
                    setState(() {
                      attempt6 = value.toLowerCase();
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
                        _handleAttemptLetterStyle(
                            attempt1LetterStyles, attempt1);
                      });
                      _showResult(value, "Dahisin!");
                      _clearInput();
                    }
                    break;
                  case 1:
                    if (attempt2.length == 5) {
                      setState(() {
                        attemptCtr++;
                        _handleAttemptLetterStyle(
                            attempt2LetterStyles, attempt2);
                      });
                      _showResult(value, "Harika!");
                      _clearInput();
                    }
                    break;
                  case 2:
                    if (attempt3.length == 5) {
                      setState(() {
                        attemptCtr++;
                        _handleAttemptLetterStyle(
                            attempt3LetterStyles, attempt3);
                      });
                      _showResult(value, "Etkileyici!");
                      _clearInput();
                    }
                    break;
                  case 3:
                    if (attempt4.length == 5) {
                      setState(() {
                        attemptCtr++;
                        _handleAttemptLetterStyle(
                            attempt4LetterStyles, attempt4);
                      });
                      _showResult(value, "Parlak Zeka!");
                      _clearInput();
                    }
                    break;
                  case 4:
                    if (attempt5.length == 5) {
                      setState(() {
                        attemptCtr++;
                        _handleAttemptLetterStyle(
                            attempt5LetterStyles, attempt5);
                      });
                      _showResult(value, "Çok İyi!");
                      _clearInput();
                    }
                    break;
                  case 5:
                    if (attempt6.length == 5) {
                      setState(() {
                        // last attempt requires different handling
                        _handleAttemptLetterStyle(
                            attempt6LetterStyles, attempt6);
                      });
                      _showResult(value, "Ehh...!");
                      _clearInput();
                    }
                    break;
                  default:
                }
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.help),
          onTap: () => showDialog(
              context: context, builder: (BuildContext context) => HowToPlay()),
        ),
        title: const Text("WORDLE TÜRKÇE"),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: const Icon(Icons.settings),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => const Settings()),
          ),
        ],
      ),
      body: _buildGameBody(),
    );
  }
}
