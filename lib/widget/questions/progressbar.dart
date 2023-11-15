import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TestProgressWidget extends StatelessWidget {
  final double progress;

  TestProgressWidget(
    this.progress,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      LinearPercentIndicator(
        width: MediaQuery.of(context).size.width,
        lineHeight: MediaQuery.of(context).size.height * 0.055,
        clipLinearGradient: true,
        percent: progress,
        progressColor: Colors.green,
        backgroundColor: const Color.fromRGBO(220, 113, 127, 1.0),
        padding: const EdgeInsets.only(bottom: 10.0), // Добавляем отступ снизу
        center: Text(
          "${(progress * 100).toStringAsFixed(0)}%",
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontFamily: "Source Sans Pro"),
        ),
      ),
      Positioned(
          top: -4,
          right: 10,
          child: GestureDetector(
            onTap: () {
              AppConstants.numberScreenQuestion = 0;
              AppConstants.numberOfQuestion = 0;
              AppConstants.correctAnswer = 0;
              AppConstants.answersList = [];
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => MainScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.close, // Иконка крестика
                color: Colors.blueGrey,
                size: 30.0,
              ),
            ),
          ))
    ]);
  }
}
