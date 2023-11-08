import 'package:flutter/material.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/create/image_input.dart';
import 'package:codequiz/widget/create/text_input.dart';
import 'package:codequiz/widget/create/type_question.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/text_place.dart';

class QuestionSettingsFirst extends StatefulWidget {
  @override
  _QuestionSettingsFirstState createState() => _QuestionSettingsFirstState();
}

class _QuestionSettingsFirstState extends State<QuestionSettingsFirst> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Color.fromRGBO(220, 113, 127, 1),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const ImageMain(
                        width: 0.2,
                        height: 0.1,
                        picture: "assets/images/logo.svg",
                      ),
                      const TextPlace(
                        font: "Source Sans Pro",
                        txt: "Студент Тест",
                        align: TextAlign.center,
                        st: FontWeight.bold,
                        width: 0.4,
                        height: 0.05,
                        backgroundColor: Colors.white,
                        colortxt: Colors.black,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextPlace(
                              txt: "Введите текст вопроса",
                              font: "Source Sans Pro",
                              align: TextAlign.center,
                              st: FontWeight.bold,
                              width: 0.9,
                              height: 0.05,
                              backgroundColor: Colors.transparent,
                              colortxt: const Color.fromRGBO(54, 79, 107, 100),
                              size: 20,
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextInput(
                              width: 0.9,
                              quantity: 250,
                              lines: 5,
                              height: 0.2,
                              colortxt: Colors.grey,
                              mode: false,
                              hinttxt: "Введите вопрос",
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextPlace(
                              txt: "Загрузите картинку (опционально)",
                              font: "Source Sans Pro",
                              align: TextAlign.center,
                              st: FontWeight.bold,
                              width: 0.9,
                              height: 0.05,
                              backgroundColor: Colors.transparent,
                              colortxt: const Color.fromRGBO(54, 79, 107, 100),
                              size: 20,
                            ),
                          ],
                        ),
                        ImageUploadWidget(height: 0.2, width: 0.6),
                        SwitchWidget(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextPlace(
                              txt: "Введите ответ на вопрос",
                              font: "Source Sans Pro",
                              align: TextAlign.center,
                              st: FontWeight.bold,
                              width: 0.9,
                              height: 0.05,
                              backgroundColor: Colors.transparent,
                              colortxt: const Color.fromRGBO(54, 79, 107, 100),
                              size: 20,
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextInput(
                              width: 0.9,
                              quantity: 250,
                              lines: 1,
                              height: 0.08,
                              colortxt: Colors.grey,
                              mode: false,
                              hinttxt: "Введите ответ на вопрос",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                    ButtonPush(
                      isEnabled: true,
                      txt: "Продолжить",
                      size: 16,
                      page: (context) => QuestionSettingsFirst(),
                      width: 0.5,
                      height: 0.05,
                      backgroundColor: const Color.fromRGBO(220, 113, 127, 100),
                      colortxt: Colors.white,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
