import 'package:flutter/material.dart';
import 'package:quiz_game/game/view/widget/options_widget.dart';

import '../../model/question_model.dart';
import '../result_page.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late PageController _controller;

  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
          ),
          Text("Question $_questionNumber/${questions.length}"),
          Divider(
            thickness: 2,
            color: Colors.amberAccent,
          ),
          Expanded(
              child: PageView.builder(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final _question = questions[index];
                    return buildQuestion(_question);
                  })),
          _isLocked ? buildElevatedButton() : SizedBox.shrink(),
        ],
      ),
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: OptionsWidget(
              question: question,
              onClickedOption: (option) {
                if (question.isLocked) {
                  return;
                } else {
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                  });
                  _isLocked = question.isLocked;
                  if (question.selectedOption!.isCorrect) {
                    _score++;
                  }
                }
              }),
        ),
      ],
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          if (_questionNumber < questions.length) {
            _controller.nextPage(
                duration: Duration(milliseconds: 150),
                curve: Curves.easeInExpo);
            setState(() {
              _questionNumber++;
              _isLocked = false;
            });
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultPage(score: _score)));
          }
        },
        child: Text(_questionNumber < questions.length
            ? "Next question"
            : "See result"));
  }
}
