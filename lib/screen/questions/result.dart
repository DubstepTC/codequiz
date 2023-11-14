import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/questions/answer.dart';
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
    AppConstants.numberScreenQuestion += 1;
    print(AppConstants.numberScreenQuestion);
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
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      ProgressBarWidget(AppConstants.numberScreenQuestion),
                      SizedBox(height: screenHeight * 0.05,),
                      const TextPlace(
                        font: "Roboto",
                          txt: "Ты прошел тест",
                          align: TextAlign.center,
                          st: FontWeight.bold,
                          width: 0.8,
                          height: 0.2,
                          backgroundColor: Color.fromRGBO(23, 24, 24, 0),
                          colortxt: Color.fromRGBO(54, 79, 107, 100),
                          size: 20),
                      
                      SizedBox(height: screenHeight * 0.1,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}