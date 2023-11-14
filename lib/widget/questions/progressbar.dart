import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/main_screen.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  final int progress;

  ProgressBarWidget(this.progress);

  // Функция для прогрессбара


  @override
  Widget build(BuildContext context) {
    double result = progress / AppConstants.numberOfQuestion * 100;
    int roundedResult = result.round();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.04,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(220, 113, 127, 1.0),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Stack(
        children: [
            FractionallySizedBox(
              widthFactor: progress / AppConstants.numberOfQuestion,
              child: Container(
                decoration: const BoxDecoration(
                  color:  Color.fromRGBO(78, 203, 113, 1.0),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                ),
              ),
            ),
            Center(
              child: Text(
                '$roundedResult%',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
            right: 10,
            top: -5,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Color.fromRGBO(54, 79, 107, 100)),
              iconSize: 30, 
              onPressed: () {
                 AppConstants.numberScreenQuestion = -1;
                 AppConstants.numberOfQuestion = 0;
                 AppConstants.correctAnswer = 0;
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}