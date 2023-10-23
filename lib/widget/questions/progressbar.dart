import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  final int progress;

  ProgressBarWidget(this.progress);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.03,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(220, 113, 127, 1.0),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: progress / 100,
            child: Container(
              decoration: const BoxDecoration(
                color:  Color.fromRGBO(78, 203, 113, 1.0),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
              ),
            ),
          ),
          Center(
            child: Text(
              '$progress%',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}