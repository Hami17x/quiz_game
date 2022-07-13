class Question {
  final String text;
  final List<Option> options;
  Option option;
  bool isLocked;
  Option? selectedOption;

  Question(
      {required this.text,
      required this.options,
      this.isLocked = false,
      this.selectedOption,
      required this.option});
}

class Option {
  final String text;

  Option({required this.text});
}

getOptions(String value, List<Option> options) {
  List<Option> list = options.toList()
    ..removeWhere((Option element) => element.text == value);
  list.shuffle();
  list = list.take(3).toList()..add(Option(text: value));
  list.shuffle();
  return list;
}

class Game {
  final List<Question> questions;
  final String name;

  Game({required this.name, required this.questions});
}
