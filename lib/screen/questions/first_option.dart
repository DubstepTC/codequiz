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
class FirstOption extends StatelessWidget {
  late List<Color> _sectionColors;

  FirstOption({super.key});

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

    return Scaffold(
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
                    ProgressBarWidget(17),
                    SizedBox(height: screenHeight * 0.05,),
                    const TextPlace(
                      font: "Roboto",
                        txt: "Текст Вопроса",
                        align: TextAlign.center,
                        st: FontWeight.bold,
                        width: 0.8,
                        height: 0.2,
                        backgroundColor: Color.fromRGBO(23, 24, 24, 0),
                        colortxt: Color.fromRGBO(54, 79, 107, 100),
                        size: 20),
                    Column(
                      children: [
                        AnswerRowWidget('Ответ 1'),
                        SizedBox(height: screenHeight * 0.005,),
                        AnswerRowWidget('Ответ 2'),
                        SizedBox(height: screenHeight * 0.005,),
                        AnswerRowWidget('Ответ 3'),
                        SizedBox(height: screenHeight * 0.005,),
                        AnswerRowWidget('Ответ 4'),
                        SizedBox(height: screenHeight * 0.005,),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonPush(
                            isEnabled: true,
                            txt: 'Пропустить',
                            size: 16,
                            page: (context) => FirstOption(),
                            width: 0.38,
                            height: 0.05,
                            backgroundColor: const Color.fromRGBO(
                                70, 110, 246, 100),
                            colortxt: Colors.white),
                        SizedBox(width: screenWidth * 0.1,),
                        ButtonPush(
                            isEnabled: true,
                            txt: 'Далее',
                            size: 16,
                            page: (context) => FirstOption(),
                            width: 0.38,
                            height: 0.05,
                            backgroundColor: const Color.fromRGBO(
                                220, 113, 127, 100),
                            colortxt: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildSectionWidgets(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}