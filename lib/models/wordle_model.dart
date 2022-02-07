class Wordle {
  final int? index;
  final String word;

  Wordle({this.index, required this.word});

  factory Wordle.fromMap(Map<String, dynamic> json) => Wordle(
      index: json['index'],
      word: json['word']);

  Map<String, dynamic> toMap() {
    return {"index": index, "word": word};
  }
}
