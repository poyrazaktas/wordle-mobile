import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle_turkce/constants/words.dart';
import 'package:wordle_turkce/helpers/file_helper.dart';
import 'package:wordle_turkce/models/wordle_model.dart';
import 'package:wordle_turkce/provider/color_blind_mode_provider.dart';
import 'package:wordle_turkce/widgets/how_to_play_widget.dart';
import 'package:wordle_turkce/widgets/settings_widget.dart';
import 'package:clipboard/clipboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int attemptCtr;

  late String attempt1, attempt2, attempt3, attempt4, attempt5, attempt6;
  bool isAttemptListLoading = true;

  var attempt1LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt2LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt3LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt4LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt5LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  var attempt6LetterStyles = List<Color>.filled(5, Colors.grey.shade800);

  final _defaultContainerColor = Colors.grey.shade800;

  final TextStyle _textStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);

  final _inputController = TextEditingController();
  final _inputFocusNode = FocusNode();

  final _scrollController = ScrollController();

  late ColorBlindModeProvider _colorBlindModeProvider;

  bool isWordleLoading = true;
  late String wordle;
  late Wordle wordleModel;

  @override
  void initState() {
    super.initState();
    initWordle();

    initContainerStyles();
  }

  void initWordle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt("wordleIndex")!;
    wordleModel = await FileHelper.instance.getWordle(index);
    wordle = wordleModel.word;
    setState(() {
      isWordleLoading = false;
    });
    initAttempts();
  }

  void initAttempts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var attemptList = prefs.getStringList("attemptList");
    if (attemptList != null) {
      attempt1 = attemptList[0];
      attempt2 = attemptList[1];
      attempt3 = attemptList[2];
      attempt4 = attemptList[3];
      attempt5 = attemptList[4];
      attempt6 = attemptList[5];
      attemptCtr = prefs.getInt("attemptCtr")!;
      if (attempt1.length == 5) {
        _handleAttemptLetterStyle(attempt1LetterStyles, attempt1);
      }
      if (attempt2.length == 5) {
        _handleAttemptLetterStyle(attempt2LetterStyles, attempt2);
      }
      if (attempt3.length == 5) {
        _handleAttemptLetterStyle(attempt3LetterStyles, attempt3);
      }
      if (attempt4.length == 5) {
        _handleAttemptLetterStyle(attempt4LetterStyles, attempt4);
      }
      if (attempt5.length == 5) {
        _handleAttemptLetterStyle(attempt5LetterStyles, attempt5);
      }
      if (attempt6.length == 5) {
        _handleAttemptLetterStyle(attempt6LetterStyles, attempt6);
      }

      if (attemptList.contains(wordle)) {
        _showResult(wordle, "Doğru Tahmin!");
      }

      if (attemptCtr == 6) {
        _showResult(attempt6, "Ehh.");
      }
      setState(() {
        isAttemptListLoading = false;
      });
    } else {
      attempt1 = "";
      attempt2 = "";
      attempt3 = "";
      attempt4 = "";
      attempt5 = "";
      attempt6 = "";
      attemptCtr = 0;
      setState(() {
        isAttemptListLoading = false;
      });
    }
  }

  void initContainerStyles() {
    _colorBlindModeProvider =
        Provider.of<ColorBlindModeProvider>(context, listen: false);
        // add listener to _colorBlindModeProvider
    _colorBlindModeProvider.addListener(() {
      setState(() {
        initContainerStyles();
        initAttempts();
      });
    });
  }

  void _showResult(String attempt, String successMessage) {
    var attempts = [attempt1, attempt2, attempt3, attempt4, attempt5, attempt6];

    var filteredAttempts = attempts.where((element) => element != "").toList();

    var mappedAttempts =
        filteredAttempts.map((element) => _maskLetters(element)).toList();
    if (attempt.toLowerCase() == wordle) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(successMessage),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actionsPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              actions: [
                GestureDetector(
                    child: const Icon(
                      Icons.share,
                      color: Colors.green,
                    ),
                    onTap: () {
                      FlutterClipboard.copy(mappedAttempts.join("\n"));
                    }),
                GestureDetector(
                  child: const Text("Tekrar Oyna"),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      resetWordleElements();
                      switchToNextWordle();
                    });
                  },
                )
              ],
            );
          });
    } else if (attempt.toLowerCase() != wordle && attemptCtr == 6) {
      // it denotes there is no more attempts left
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Kaybettiniz"),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actionsPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              content: Text("Wordle : $wordle"),
              actions: [
                GestureDetector(
                    child: const Icon(
                      Icons.share,
                      color: Colors.green,
                    ),
                    onTap: () {
                      FlutterClipboard.copy(mappedAttempts.join("\n"));
                    }),
                GestureDetector(
                  child: const Text("Tekrar Oyna"),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      resetWordleElements();
                      switchToNextWordle();
                    });
                  },
                )
              ],
            );
          });
    }
  }

  String _maskLetters(attempt) {
    // default container color : ⬛
    // correct container color : 🟩
    // wrong container color : 🟨
    var attemptHash = List.filled(5, false);
    var tempWordle = List.from(wordle.characters);
    List<String> attemptMask = List.filled(5, "⬛");

    for (var i = 0; i < wordle.length; i++) {
      if (wordle[i] == attempt[i]) {
        attemptMask[i] = "🟩";
        attemptHash[i] = true;
        tempWordle[i] = "";
      }
    }

    for (var i = 0; i < wordle.length; i++) {
      if (attemptHash[i] != true && tempWordle.contains(attempt[i])) {
        attemptMask[i] = "🟨";
        tempWordle[tempWordle.indexOf(attempt[i])] = "";
      }
    }
    return attemptMask.join("");
  }

  void resetWordleElements() async {
    attemptCtr = 0;
    attempt1 = "";
    attempt2 = "";
    attempt3 = "";
    attempt4 = "";
    attempt5 = "";
    attempt6 = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("attemptList",
        [attempt1, attempt2, attempt3, attempt4, attempt5, attempt6]);
    prefs.setInt("attemptCtr", attemptCtr);

    attempt1LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
    attempt2LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
    attempt3LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
    attempt4LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
    attempt5LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
    attempt6LetterStyles = List<Color>.filled(5, Colors.grey.shade800);
  }

  void switchToNextWordle() async {
    setState(() {
      isWordleLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int newIndex = wordleModel.index! + 1;

    wordleModel = await FileHelper.instance.getWordle(newIndex);
    wordle = wordleModel.word;
    prefs.setInt("wordleIndex", wordleModel.index!);

    setState(() {
      isWordleLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.help),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => HowToPlay()),
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
        body: (isWordleLoading || isAttemptListLoading)
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 5.0,
              ))
            : _buildGameBody());
  }

  Widget _buildGameBody() {
    return Column(
      children: [
        Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(right: 50, left: 50, top: 20),
            child: LinearProgressIndicator(
              value: wordleModel.index! / 100,
              backgroundColor: _defaultContainerColor,
              minHeight: 8,
              color: _colorBlindModeProvider
                  .colorBlindMode.correctSpotContainerColor,
            )),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
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
              controller: _inputController,
              focusNode: _inputFocusNode,
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
                      if (Words.words.contains(attempt1)) {
                        setState(() {
                          attemptCtr++;
                          _handleAttemptLetterStyle(
                              attempt1LetterStyles, attempt1);
                        });
                        _handleAttempts();
                        _showResult(value, "Dahisin!");
                        _clearInput();
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Text(
                                  "$attempt1 doğru bir 5 harfli kelime değil!");
                            });
                      }
                    }
                    break;
                  case 1:
                    if (attempt2.length == 5) {
                      if (Words.words.contains(attempt2)) {
                        setState(() {
                          attemptCtr++;
                          _handleAttemptLetterStyle(
                              attempt2LetterStyles, attempt2);
                        });
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent / 2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                        _handleAttempts();
                        _showResult(value, "Harika!");
                        _clearInput();
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Text(
                                  "$attempt2 doğru bir 5 harfli kelime değil!");
                            });
                      }
                    }
                    break;
                  case 2:
                    if (attempt3.length == 5) {
                      if (Words.words.contains(attempt3)) {
                        setState(() {
                          attemptCtr++;
                          _handleAttemptLetterStyle(
                              attempt3LetterStyles, attempt3);
                        });
                        _handleAttempts();
                        _showResult(value, "Etkileyici!");
                        _clearInput();
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Text(
                                  "$attempt3 doğru bir 5 harfli kelime değil!");
                            });
                      }
                    }
                    break;
                  case 3:
                    if (attempt4.length == 5) {
                      if (Words.words.contains(attempt4)) {
                        setState(() {
                          attemptCtr++;
                          _handleAttemptLetterStyle(
                              attempt4LetterStyles, attempt4);
                        });
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                        _handleAttempts();
                        _showResult(value, "Çok iyi!");
                        _clearInput();
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Text(
                                  "$attempt4 doğru bir 5 harfli kelime değil!");
                            });
                      }
                    }
                    break;
                  case 4:
                    if (attempt5.length == 5) {
                      if (Words.words.contains(attempt5)) {
                        setState(() {
                          attemptCtr++;
                          _handleAttemptLetterStyle(
                              attempt5LetterStyles, attempt5);
                        });
                        _handleAttempts();
                        _showResult(value, "İyi deneme!");
                        _clearInput();
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Text(
                                  "$attempt5 doğru bir 5 harfli kelime değil!");
                            });
                      }
                    }
                    break;
                  case 5:
                    if (attempt6.length == 5) {
                      if (Words.words.contains(attempt6)) {
                        setState(() {
                          attemptCtr++;
                          _handleAttemptLetterStyle(
                              attempt6LetterStyles, attempt6);
                        });
                        _handleAttempts();
                        _showResult(value, "Ehh...!");
                        _clearInput();
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Text(
                                  "$attempt6 doğru bir 5 harfli kelime değil!");
                            });
                      }
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

  String _createLetter(String attempt, index) {
    try {
      return attempt[index].replaceAll("i", "İ").toUpperCase();
    } catch (e) {
      return "";
    }
  }

  void _handleAttempts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("attemptList",
        [attempt1, attempt2, attempt3, attempt4, attempt5, attempt6]);
    prefs.setInt("attemptCtr", attemptCtr);
  }

  void _handleAttemptLetterStyle(
      List<Color> attemptLetterStyles, String attempt) {
    var attemptHash = List.filled(5, false);
    var tempWordle = List.from(wordle.characters);
    for (var i = 0; i < wordle.length; i++) {
      if (wordle[i] == attempt[i]) {
        attemptLetterStyles[i] =
            _colorBlindModeProvider.colorBlindMode.correctSpotContainerColor;
        attemptHash[i] = true;
        tempWordle[i] = "";
      }
    }

    for (var i = 0; i < wordle.length; i++) {
      if (attemptHash[i] != true && tempWordle.contains(attempt[i])) {
        attemptLetterStyles[i] =
            _colorBlindModeProvider.colorBlindMode.wrongSpotContainerColor;
        tempWordle[tempWordle.indexOf(attempt[i])] = "";
      }
    }
  }

  void _clearInput() {
    _inputController.clear();
    //focus to inputController
    _inputFocusNode.requestFocus();
  }
}
