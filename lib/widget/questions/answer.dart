import 'package:codequiz/widget/questions/circle_button.dart';
import 'package:flutter/material.dart';

class AnswerRowWidget extends StatelessWidget {
  final String answerText;

  AnswerRowWidget(this.answerText);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        SizedBox(width: screenWidth * 0.1),
        CircleButton(),
        SizedBox(width: screenWidth * 0.1),
        Text(answerText, style: const TextStyle(color: Color.fromRGBO(54, 79, 107, 100), fontSize: 16)),
      ],
    );
  }
}