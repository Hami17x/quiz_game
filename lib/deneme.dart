import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:quiz_game/game/model/question_model.dart';
import 'package:quiz_game/helper/privacy_policy.dart';

class deneme extends StatefulWidget {
  const deneme({Key? key}) : super(key: key);

  @override
  State<deneme> createState() => _denemeState();
}

class _denemeState extends State<deneme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Markdown(
          data: privacyPolicy,
        ),
      ),
    );
  }
}
