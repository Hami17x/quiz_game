import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/view_model/question_provider.dart';

class ResultPage extends StatelessWidget {
  final score, lenght;
  const ResultPage({Key? key, required this.lenght, required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          "$score/$lenght",
          style: TextStyle(fontSize: 20),
        )),
        Text(
          "SCORE",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
            onPressed: () {
              context.read<QuestionProvider>().retry();

              Navigator.pop(context);
            },
            icon: Icon(Icons.reply),
            label: Text("Home"))
      ],
    ));
  }
}
