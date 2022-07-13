import 'package:flutter/material.dart';
import 'package:quiz_game/game/view/game.dart';
import 'package:quiz_game/game/view/home.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/view_model/question_provider.dart';
import '../model/question_model.dart';

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
          child: Text("$score/$lenght"),
        ),

        /*
        ElevatedButton.icon(
            onPressed: ()  {
              context.read<QuestionProvider>().retry();

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GamePage(
                            game: games[0],
                          )));
            },
            icon: Icon(Icons.reply),
            label: Text("retry"))
            */

        ElevatedButton.icon(
            onPressed: () {
              context.read<QuestionProvider>().retry();

              Navigator.pop(context);
            },
            icon: Icon(Icons.home),
            label: Text("Home"))
      ],
    ));
  }
}
