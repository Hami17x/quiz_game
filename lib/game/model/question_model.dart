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

final questions = [
  Question(
      option: Option(text: "a"),
      text: "a?",
      options: getOptions(Option(text: "a"), options)),
  Question(
      option: Option(text: "b"),
      text: "b?",
      options: getOptions(Option(text: "b"), options)),
  Question(
      option: Option(text: "c"),
      text: "c?",
      options: getOptions(Option(text: "c"), options)),
  Question(
      option: Option(text: "d"),
      text: "d?",
      options: getOptions(Option(text: "d"), options)),
  Question(
      option: Option(text: "e"),
      text: "e?",
      options: getOptions(Option(text: "e"), options)),
  Question(
      option: Option(text: "f"),
      text: "f?",
      options: getOptions(Option(text: "f"), options)),
];

final options = [
  Option(text: "a"),
  Option(text: "b"),
  Option(text: "c"),
  Option(text: "d"),
  Option(text: "e"),
  Option(text: "f"),
  Option(text: "g"),
];

getOptions(Option value, List<Option> options) {
  List<Option> list = options.toList()
    ..removeWhere((Option element) => element.text == value.text);
  list = list.take(4).toList()..add(value);
  list.shuffle();
  return list;
}

final games = [
  Game(
    questions: (questions.toList()..shuffle()).take(4).toList(),
    name: 'Quizz',
  ),
  Game(
    //questions: (questions..shuffle()).take(4).toList(),
    questions: (questions.toList()..shuffle()).take(4).toList(),
    name: 'Quizz2',
  ),
];

class Game {
  final List<Question> questions;
  final String name;

  Game({required this.name, required this.questions});
}
