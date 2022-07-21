import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../model/question_model.dart';
import '../model/word_model.dart';

class QuestionProvider extends ChangeNotifier {
  QuestionProvider(BuildContext context) {
    controller = PageController(initialPage: 0);
    initGames(context);
  }

  List<Game> games = [];

  void initGames(BuildContext context) async {
    List<Word> liste = await getDenemes(context);
    games.add(Game(
        name: "B1 Adverb",
        questions: liste
            .map((e) => Question(
                text: e.definition,
                options: getOptions(
                    e.value, liste.map((e) => Option(text: e.value)).toList()),
                option: Option(text: e.value)))
            .toList()));
    notifyListeners();
  }

  Future<List<Word>> getDenemes(BuildContext context) async {
    final assesBundle = DefaultAssetBundle.of(context);
    final data = await assesBundle.loadString("assets/question.json");
    final body = jsonDecode(data);
    return body.map<Word>(Word.fromJson).toList();
  }

  late PageController controller;
  int questionNumber = 1;
  int score = 0;
  bool isLocked = false;

  Future<void> initQuestions() async {}

  void setIsLocked(bool value) {
    isLocked = value;
    notifyListeners();
  }

  void incQuestionNumber() {
    questionNumber = questionNumber + 1;
    notifyListeners();
  }

  void incScore() {
    score++;
    notifyListeners();
  }

  void setScore(int value) {
    score = value;
  }

  void retry() {
    questionNumber = 1;
    isLocked = false;
    score = 0;

    for (int i = 0; i < games.length; i++) {
      games[i].questions.forEach((element) {
        element.isLocked = false;
        element.selectedOption = null;
      });
    }
  }

  void makeefault(List<Question> questions) {
    questions.forEach((element) {
      element.isLocked = false;
      element.selectedOption = null;
    });
  }
}
