import 'package:codequiz/screen/creator/qestions_settings_one.dart';
import 'package:codequiz/widget/create/type_answer.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/create/image_input.dart';
import 'package:codequiz/widget/create/text_input.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/text_place.dart';

class AnswerSettingsFirst extends StatefulWidget {
  String answerText;
  final bool isBoolean;
  final String url;

  AnswerSettingsFirst({super.key,required this.url, required this.answerText, required this.isBoolean });
  @override
  _AnswerSettingsFirstState createState() => _AnswerSettingsFirstState();
}

class _AnswerSettingsFirstState extends State<AnswerSettingsFirst> {
  final TextEditingController _answerController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                  child: SingleChildScrollView(
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
                        Row(
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
                              controller: _answerController,
                              onChange: (value){
                                _answerController.text = value;
                                widget.answerText = _answerController.text;
                              },
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
                        ImageUploadWidget(height: 0.4, width: 0.8), 
                        const SizedBox(height: 30,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CheckBoxWidget(width: 0.1, height: 0.05,)
                          ]
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            ])));
  }
}
