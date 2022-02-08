import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wordle_turkce/models/wordle_model.dart';

class FileHelper {
  FileHelper._privateConstructor();
  static final FileHelper instance = FileHelper._privateConstructor();

  static File? _file;

  Future<File> get file async => _file ??= await _initFile();

  Future<File> _initFile() async {
    // init file if there is no file
    final directory = await getApplicationDocumentsDirectory();
    final file = File(join(directory.path, 'wordles.json'));
    if (!await file.exists()) {
      await file.create();
      await _onCreate('wordles.json');
    }
    return file;
  }

  Future _onCreate(String filePath) async {
    final String response = await rootBundle.loadString("assets/words.json");
    var wordsHashMap = await json.decode(response);
    var words = wordsHashMap["words"]!;
    var wordList = words.map((word) => word.toLowerCase()).toList();

    // shufle wordList and save it on a variable
    var shuffledWordList = wordList.toList();
    shuffledWordList.shuffle();

    // create wordle list from shuffledWordList
    var wordleList = <Map<String, dynamic>>[];
    for (var i = 0; i < 100; i++) {
      var word = shuffledWordList[i];
      var wordle = Wordle(
        word: word,
        index: i,
      );
      wordleList.add(wordle.toMap());
    }

    // insert json elements to file
    final directory = await getApplicationDocumentsDirectory();
    final file = File(join(directory.path, filePath));
    await file.writeAsString(json.encode(wordleList));
  }

  Future<List<Wordle>> getWordleList() async {
    final file = await this.file;
    final String content = await file.readAsString();
    final List<dynamic> wordleList = json.decode(content);
    return wordleList.map((wordle) => Wordle.fromMap(wordle)).toList();
  }

  Future<Wordle> getWordle(int index) async {
    var wordleList = await getWordleList();
    if (index >= wordleList.length) {
      await removeFile();
      await _initFile();
      var newWordleList = await getWordleList();
      return newWordleList[0];
    }

    return wordleList[index];
  }

  // remove file
  Future removeFile() async {
    final file = await this.file;
    await file.delete();
  }
}
