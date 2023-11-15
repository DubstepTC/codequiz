import 'package:codequiz/widget/questions/circle_button.dart';
import 'package:flutter/material.dart';

class AnswerRowWidget extends StatelessWidget {
  final String answerText;
  final bool check;
  final String url;

  const AnswerRowWidget(this.answerText, this.check, this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: screenWidth * 0.1),
          CircleButton(check),
          SizedBox(width: screenWidth * 0.1),
          if (url == "")
            Text(answerText,
                style: const TextStyle(
                    color: Color.fromRGBO(54, 79, 107, 100), fontSize: 16))
          else
            Container(
              height: screenHeight * 0.32,
              width: screenWidth * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent, // замените на нужный вам цвет
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          SizedBox(width: screenWidth * 0.05),
        ],
      ),
      const Row
      (
        children: [
          SizedBox(height: 30,)
        ],
      )
    ]);
  }
}
