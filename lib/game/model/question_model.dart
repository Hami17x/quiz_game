class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question(
      {required this.text,
      required this.options,
      this.isLocked = false,
      this.selectedOption});
}

class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});
}

final questions = [
  Question(text: "2+3?", options: [
    Option(text: "1", isCorrect: false),
    Option(text: "5", isCorrect: true),
  ]),
  Question(text: "2+3?", options: [
    Option(text: "1", isCorrect: false),
    Option(text: "5", isCorrect: true),
  ]),
  Question(text: "2+3?", options: [
    Option(text: "1", isCorrect: false),
    Option(text: "5", isCorrect: true),
  ]),
  Question(text: "2+3?", options: [
    Option(text: "1", isCorrect: false),
    Option(text: "5", isCorrect: true),
  ]),
];
