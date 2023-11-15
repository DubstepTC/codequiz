import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/questions/result.dart';
import 'package:codequiz/widget/authorization/reg_en_button.dart';
import 'package:codequiz/widget/create/text_input.dart';
import 'package:codequiz/widget/questions/answer.dart';
import 'package:codequiz/widget/questions/progressbar.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FirstOption extends StatefulWidget {
  _FirstOptionState createState() => _FirstOptionState();
}

class _FirstOptionState extends State<FirstOption> {
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(AppConstants.numberScreenQuestion);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        // Предотвращаем возврат на предыдущий экран
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        TestProgressWidget(AppConstants.numberScreenQuestion / AppConstants.numberOfQuestion),
                        TextPlace(
                          font: "Source Sans Pro",
                          txt: AppConstants.questionList![AppConstants
                              .numberScreenQuestion]['question_title'],
                          align: TextAlign.center,
                          st: FontWeight.bold,
                          width: 0.8,
                          height: 0.25,
                          backgroundColor: const Color.fromRGBO(23, 24, 24, 0),
                          colortxt: const Color.fromRGBO(54, 79, 107, 100),
                          size: 20,
                        ),


                       

                      ],
                    ),
                  ),
                ),
                 Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          child: Column(children: [


                        if (AppConstants.questionList![AppConstants
                                .numberScreenQuestion]['question_picture'] !=
                            "")
                          Container(
                            height: screenHeight * 0.32,
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors
                                  .transparent, // замените на нужный вам цвет
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                AppConstants.questionList![AppConstants
                                    .numberScreenQuestion]['question_picture'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            height: screenHeight * 0,
                          ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        if (AppConstants.questionList![
                                AppConstants.numberScreenQuestion]['type'] ==
                            false)
                          Column(
                            children: [
                              for (int index = 0;
                                  index <
                                      AppConstants
                                          .answersList[
                                              AppConstants.numberScreenQuestion]
                                          .length;
                                  index++)
                                AnswerRowWidget(
                                    AppConstants.answersList[
                                            AppConstants.numberScreenQuestion]
                                        [index]['text_answer'],
                                    AppConstants.answersList[
                                            AppConstants.numberScreenQuestion]
                                        [index]['is_correct_answer'],
                                    AppConstants.answersList[
                                       AppConstants.numberScreenQuestion]
                                        [index]['picture_link']
                                    ),
                              SizedBox(width: screenHeight * 0.1),
                            ],
                          )
                        else
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextInput(
                                  width: 0.9,
                                  quantity: 250,
                                  lines: 3,
                                  height: 0.15,
                                  colortxt: Colors.grey,
                                  mode: false,
                                  hinttxt: "Введите ответ на вопрос",
                                  controller: _answerController,
                                  onChange: (value) {
                                    setState(() {
                                      _answerController.text = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.35,
                            ),
                          ])

                        ],)
                        )
                        )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if (AppConstants.questionList![AppConstants.numberScreenQuestion]['type'] == true)
                  ButtonEntry(
                      isEnabled: true,
                      txt: "Ответить на вопрос",
                      size: 16,
                      check: () {
                        if (_answerController.text ==
                            AppConstants.answersList[AppConstants
                                .numberScreenQuestion][0]['text_answer']) {
                          print("ответил");
                          AppConstants.correctAnswer += 1;
                        }
                        if (AppConstants.numberScreenQuestion ==
                            AppConstants.numberOfQuestion - 1) {
                          AppConstants.numberScreenQuestion += 1;
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ResultScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ),
                          );
                        } else {
                          AppConstants.numberScreenQuestion += 1;
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      FirstOption(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ),
                          );
                        }
                      },
                      width: 0.5,
                      height: 0.07,
                      backgroundColor: const Color.fromRGBO(220, 113, 127, 100),
                      colortxt: Colors.white)
              ]))),
    );
  }
}
