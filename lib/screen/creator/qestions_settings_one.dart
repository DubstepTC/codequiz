import 'dart:io';
import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/widget/create/answer/answer_list.dart';
import 'package:codequiz/widget/create/question/button_pop_qestion.dart';
import 'package:codequiz/widget/create/question/image_question.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/create/text_input.dart';
import 'package:codequiz/widget/create/question/type_question.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/text_place.dart';

class QuestionSettingsFirst extends StatefulWidget {
  final List answers;
  final String questionText;
  final bool type;
  final File? path;

  QuestionSettingsFirst({Key? key, required this.path, required this.questionText, required this.type, required this.answers}) : super(key: key);

  @override
  _QuestionSettingsFirstState createState() => _QuestionSettingsFirstState();
}

class _QuestionSettingsFirstState extends State<QuestionSettingsFirst> {
  final TextEditingController _questionController = TextEditingController();
  bool isChecked = false;

  
  @override
  void initState() {
    super.initState();
    if(widget.questionText != "...") {
      _questionController.text = widget.questionText;
    }
    isChecked = widget.type;
  }

 void dispose() {
    _questionController.dispose();
    super.dispose();
  }

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
                              controller: _questionController,
                              onChange: (value){
                                setState(() {
                                  _questionController.text = value;
                                });
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
                        ImageUploadWidgetQuestion(height: 0.4, width: 0.8, path: widget.path,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextPlace(
                              txt: "Определите тип вопроса",
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
                        SwitchWidget(
                          height: 0.105,
                          width: 0.9,
                          isChecked:
                              isChecked, // Передаем значение isChecked в SwitchWidget
                          onToggle: (bool newValue) {
                            setState(() {
                              isChecked =
                                  newValue; // Обновляем значение isChecked при изменении переключателя
                            });
                          },
                        ),
                        isChecked
                            ? const Column(children: [
                                Row(
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
                                      colortxt:
                                          Color.fromRGBO(54, 79, 107, 100),
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
                                      lines: 1,
                                      height: 0.08,
                                      colortxt: Colors.grey,
                                      mode: false,
                                      hinttxt: "Введите ответ на вопрос",
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50,)
                              ])
                            : Column(children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextPlace(
                                      txt: "Введите варианты ответов на вопрос",
                                      font: "Source Sans Pro",
                                      align: TextAlign.center,
                                      st: FontWeight.bold,
                                      width: 0.9,
                                      height: 0.05,
                                      backgroundColor: Colors.transparent,
                                      colortxt:
                                          Color.fromRGBO(54, 79, 107, 100),
                                      size: 20,
                                    ),
                                  ],
                                ),
                                  SizedBox(
                                    width: double
                                        .infinity, // Set the width constraints as per your layout needs
                                    height:
                                        200, // Set the height constraints as per your layout needs
                                    child:
                                        AnswerList(), // Include the AnswerList widget as a child
                                  )
                                ])
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
              ButtonPopQestion(
                isEnabled: true,
                txt: "Сохранить",
                size: 16,
                answers: widget.answers,
                path: AppConstants.image,
                questionText: _questionController.text,
                type: isChecked,
                width: 0.5,
                height: 0.05,
                backgroundColor: const Color.fromRGBO(220, 113, 127, 100),
                colortxt: Colors.white,
              ),
            ])));
  }
}
