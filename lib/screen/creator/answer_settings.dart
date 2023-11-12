import 'dart:io';
import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/widget/create/answer/button_pop_answer.dart';
import 'package:codequiz/widget/create/answer/image_answer.dart';
import 'package:codequiz/widget/create/answer/type_answer.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/create/text_input.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/text_place.dart';

// ignore: must_be_immutable
class AnswerSettingsFirst extends StatefulWidget {
  final String answerText;
  final bool isBoolean;
  File? path;

  AnswerSettingsFirst({super.key, required this.path, required this.answerText, required this.isBoolean});

  @override
  // ignore: library_private_types_in_public_api
  _AnswerSettingsFirstState createState() => _AnswerSettingsFirstState();
}

class _AnswerSettingsFirstState extends State<AnswerSettingsFirst> {
  final TextEditingController _answerController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isBoolean;
    if(widget.answerText != "...") {
      _answerController.text = widget.answerText;
    }
  }

 @override
  void dispose() {
    _answerController.dispose();
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
                              hinttxt: "Введите ответ",
                              controller: _answerController,
                              onChange: (value){
                                setState(() {
                                  _answerController.text = value;
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
                        ImageUploadWidgetAnswer(
                          height: 0.4, 
                          width: 0.8, 
                          path: widget.path, 
                          onImageSelected: (file) {
                            setState(() {
                              widget.path = file;
                            });
                          },
                        ), 
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CheckBoxWidget(
                              cash: widget.isBoolean,
                              width: 0.1, 
                              height: 0.05, 
                              onChanged: (value) {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              }
                            )
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
              ButtonPopAnswer(
                answerText: _answerController.text,
                check: isChecked,
                path: widget.path,
                isEnabled: true,
                txt: "Сохранить",
                size: 16, 
                width: 0.5,
                height: 0.05,
                backgroundColor: const Color.fromRGBO(220, 113, 127, 100),
                colortxt: Colors.white,
              ),
            ])));
  }
}
