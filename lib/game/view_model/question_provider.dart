import 'package:flutter/widgets.dart';

import '../model/question_model.dart';

class QuestionProvider extends ChangeNotifier {
  late PageController controller;
  int questionNumber = 1;
  int score = 0;
  bool isLocked = false;

  QuestionProvider() {
    controller = PageController(initialPage: 0);
  }

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
    questions.forEach((element) {
      element.isLocked = false;
      element.selectedOption = null;
    });
  }
}
