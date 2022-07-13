import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/view/widget/question_widget.dart';
import 'package:quiz_game/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/onboarding_page.dart';
import '../model/question_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.game}) : super(key: key);
  final Game game;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: QuestionWidget(list: widget.game.questions),
    );
  }
}
