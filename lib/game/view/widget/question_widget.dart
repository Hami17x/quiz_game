import 'package:flutter/material.dart';
import 'package:quiz_game/game/view/widget/options_widget.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/view_model/question_provider.dart';

import '../../model/question_model.dart';
import '../result_page.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
              "Question ${context.watch<QuestionProvider>().questionNumber}/${questions.length}"),
          Divider(
            thickness: 2,
            color: Colors.amberAccent,
          ),
          Expanded(
              child: PageView.builder(
                  controller: context.read<QuestionProvider>().controller,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final _question = questions[index];
                    return buildQuestion(_question);
                  })),
          context.watch<QuestionProvider>().isLocked
              ? buildElevatedButton()
              : SizedBox.shrink(),
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
                  context
                      .read<QuestionProvider>()
                      .setIsLocked(question.isLocked);
                  //_isLocked = question.isLocked;
                  if (question.selectedOption!.isCorrect) {
                    //_score++;
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
              questions.length) {
            context.read<QuestionProvider>().controller.nextPage(
                duration: Duration(milliseconds: 150),
                curve: Curves.easeInExpo);
            context.read<QuestionProvider>().incQuestionNumber();
            context.read<QuestionProvider>().setIsLocked(false);
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultPage(
                        // score: _score
                        score: context.read<QuestionProvider>().score)));
          }
        },
        child: Text(
            context.read<QuestionProvider>().questionNumber < questions.length
                ? "Next question"
                : "See result"));
  }
}
