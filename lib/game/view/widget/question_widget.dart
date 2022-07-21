import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_game/game/view/widget/options_widget.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/view_model/question_provider.dart';

import '../../model/question_model.dart';
import '../result_page.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.list}) : super(key: key);
  final List<Question> list;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
                "Question ${context.watch<QuestionProvider>().questionNumber}/${widget.list.length}"),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.amberAccent,
          ),
          Expanded(
            child: PageView.builder(
                controller: context.read<QuestionProvider>().controller,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  final _question = widget.list[index];
                  return buildQuestion(_question);
                }),
          ),
          context.watch<QuestionProvider>().isLocked
              ? buildElevatedButton()
              : SizedBox.shrink(),
          TimerWidget(list: widget.list),
        ],
      ),
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          child: Text(
            question.text,
            style: TextStyle(fontSize: 18),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: OptionsWidget(
              question: question,
              onClickedOption: (option) {
                //print(option.text);

                if (question.isLocked) {
                  return;
                } else {
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                  });
                  context
                      .read<QuestionProvider>()
                      .setIsLocked(question.isLocked);

                  if (question.selectedOption!.text == question.option.text) {
                    context.read<QuestionProvider>().incScore();
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
          if (context.read<QuestionProvider>().questionNumber <
              widget.list.length) {
            context.read<QuestionProvider>().controller.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
            context.read<QuestionProvider>().incQuestionNumber();
            context.read<QuestionProvider>().setIsLocked(false);
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultPage(
                        lenght: widget.list.length,
                        // score: _score
                        score: context.read<QuestionProvider>().score)));
          }
        },
        child: Text(
            context.read<QuestionProvider>().questionNumber < widget.list.length
                ? "Next question"
                : "See result"));
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.list}) : super(key: key);
  final List<Question> list;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int timeLeft = 10;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timeLeft = widget.list.length * 5;
    _startCountDown();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  void _startCountDown() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer?.cancel();

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(
                    lenght: widget.list.length,
                    score: context.read<QuestionProvider>().score)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          "$timeLeft",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
