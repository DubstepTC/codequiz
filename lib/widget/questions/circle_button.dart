import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/questions/question_type_one.dart';
import 'package:codequiz/screen/questions/result.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  bool check;

  CircleButton(this.check, {super.key});
  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool isActivated = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          isActivated = !isActivated;
        });
        if(widget.check == true)
        {
          AppConstants.correctAnswer += 1 ;
        }
        if(AppConstants.numberScreenQuestion == AppConstants.numberOfQuestion - 1)
        {
          Navigator.push(
          context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        }
        else
        {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => FirstOption(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
        }
        AppConstants.numberScreenQuestion += 1;
      },
      child: Container(
        width: screenWidth * 0.1,
        height: screenHeight * 0.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActivated ? Colors.green : Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            color: isActivated ? Colors.white : Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
}