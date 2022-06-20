import 'package:flutter/material.dart';
import 'package:quiz_game/game/view/home.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/view_model/question_provider.dart';
import '../model/question_model.dart';

class ResultPage extends StatelessWidget {
  final score;
  const ResultPage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("$score/${questions.length}"),
        ),
        ElevatedButton.icon(
            onPressed: () {
              context.read<QuestionProvider>().retry();

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(Icons.reply),
            label: Text("retry"))
      ],
    ));
  }
}
