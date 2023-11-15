import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/main_screen.dart';
import 'package:codequiz/widget/authorization/reg_en_button.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/questions/answer.dart';
import 'package:codequiz/widget/questions/end_of_the_test.dart';
import 'package:codequiz/widget/questions/progressbar.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';

  Color _getSectionColor(int index) {
  // Ваша логика для определения цвета фона каждой секции 
  // В зависимости от состояния вопроса
  if (index < 5) {
    return Colors.green;
  } else {
    return Colors.grey;
  }
}

// ignore: must_be_immutable
class ResultScreen extends StatelessWidget {
  late List<Color> _sectionColors;

  ResultScreen({super.key});

  List<Widget> _buildSectionWidgets() {
    return List<Widget>.generate(20, (index) {
      final sectionColor = _sectionColors[index];
      return Container(
        height: 60,
        width: 40,
        color: sectionColor,
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    _sectionColors = List<Color>.generate(20, (index) => _getSectionColor(index));

    return WillPopScope(
      onWillPop: () async {
        // Предотвращаем возврат на предыдущий экран
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      TestProgressWidget(AppConstants.numberScreenQuestion /AppConstants.numberOfQuestion),
                      SizedBox(height: screenHeight * 0.05,),
                      const TextPlace(
                          font: "Source Sans Pro",
                          txt: "Тест \nБыл завершён",
                          align: TextAlign.center,
                          st: FontWeight.bold,
                          width: 0.8,
                          height: 0.15,
                          backgroundColor: Color.fromRGBO(23, 24, 24, 0),
                          colortxt: Colors.blueGrey,
                          size: 40),
                    ],
                  ),
                ),
              ),
              Expanded
              (
                flex: 4,
                child: Center
                (
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedArcWidget(correctAnswers: AppConstants.correctAnswer, totalQuestions: AppConstants.numberOfQuestion),
                      SizedBox(height: screenHeight * 0.2,)
                    ],
                  )
                )
              ),
              Expanded
              (
                flex: 1,
                child: Center
                (
                  child: 
                  ButtonEntry(
                    isEnabled: true,
                    txt: "Вернуться на главную",
                    size: 16,
                    check: () {
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
                    width: 0.5,
                    height: 0.07,
                    backgroundColor: const Color.fromRGBO(220, 113, 127, 100),
                    colortxt: Colors.white)
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}