import 'package:flutter/material.dart';

import '../../model/question_model.dart';

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;
  const OptionsWidget(
      {Key? key, required this.question, required this.onClickedOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .toList()
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

  Widget buildOption(BuildContext context, option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
          height: 60,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              //color: Colors.grey,
              color: color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color)),
          child: Center(
            child: Text(
              option.text,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 16),
            ),
          )),
    );
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option.text == question.selectedOption?.text;
    if (question.isLocked) {
      if (isSelected) {
        return question.option.text == question.selectedOption?.text
            ? Colors.green
            : Colors.red;
      } else if (option.text == question.option.text) {
        return Colors.lightGreen;
      }
    }
    return Colors.grey;
  }
}
