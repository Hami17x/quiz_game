import 'package:flutter/material.dart';

import '../model/question_model.dart';

class ResultPage extends StatelessWidget {
  final score;
  const ResultPage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("$score/${questions.length}"),
    ));
  }
}
