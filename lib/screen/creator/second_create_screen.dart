import 'dart:io';
import 'dart:math';
import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/main_screen.dart';
import 'package:codequiz/widget/authorization/reg_en_button.dart';
import 'package:codequiz/widget/create/question/question_list.dart';
import 'package:codequiz/widget/create/test_view.dart';
// ignore: depend_on_referenced_packages
import "package:supabase/supabase.dart";
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class SecondCreateScreen extends StatefulWidget {
  final String nickname;
  final String testname;
  final String descriptive; 
  final File? path;

  List<Map<dynamic, dynamic>>? receivedData;

  SecondCreateScreen({super.key, 
      this.receivedData,
      required this.nickname,
      required this.descriptive,
      required this.testname,
      required this.path,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SecondCreateScreenState createState() => _SecondCreateScreenState();
}

class _SecondCreateScreenState extends State<SecondCreateScreen> {

  final supabase = SupabaseClient(
  "https://itcswmslhtagkazkjuit.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

 // Создание теста в бд

 // Создание теста 
  Future<void> createNewTests() async {
    final responseid = await supabase
    .from('Tests')
    .select()
    // ignore: deprecated_member_use
    .execute();
    final count = responseid.data.length;
    final int newId = count + 1;
    AppConstants.testID = newId;

    // ignore: unused_local_variable
    final response = await supabase.from('Tests').insert([
        {
          'id': newId,
          'title': widget.testname,
          'description': widget.descriptive,
          'author_id': AppConstants.userID,
          'logo_image_link': AppConstants.urlTest,
        }
      // ignore: deprecated_member_use
      ]).execute();

 }
  // Загрузка картинки теста
  Future<void> saveImageTestToSupabase(File? imageFile) async {
      Random random = Random();
      String randomNumber = random.nextInt(100000000).toString().padLeft(9, '0');
      String img = "img $randomNumber";

      if(imageFile != null){
      // ignore: unused_local_variable
      final response = await supabase.storage
          .from('images')
          .upload('images/$img.jpg', imageFile);

      final imageUrl = supabase.storage
          .from('images')
          .getPublicUrl('images/$img.jpg');
      AppConstants.urlTest = imageUrl.characters.string;
      }
      else
      {
        AppConstants.urlTest = AppConstants.urlStandartTest;
      }
  }
 // Запись вопросов теста в бд 

 //вопрос
  Future<void> createNewQuestion() async { 
      final responseid = await supabase
      .from('Tests_question')
      .select()
      // ignore: deprecated_member_use
      .execute();
      final count = responseid.data.length;
      int newId = count + 1;

      //Загрузка картинок теста и перезапись пути в url
      for (int index = 0; index < widget.receivedData!.length; index++)
      {
        File? image = widget.receivedData![index]['path'];
        dynamic urlQestion = await saveImageQestionOrAnswerToSupabase(image);
        widget.receivedData![index]['path'] = urlQestion;
      }

      for (int index = 0; index < widget.receivedData!.length; index++, newId++){

        // ignore: unused_local_variable
        final response = await supabase.from('Tests_question').insert([
            {
              'id': newId,
              'question_title': widget.receivedData![index]['questionText'],
              'question_picture': widget.receivedData![index]['path'],
              'type': widget.receivedData![index]['type'],
              'test_id': AppConstants.testID,
            }
        // ignore: deprecated_member_use
        ]).execute();

        if(widget.receivedData![index]['type'] == false)
        {
          await createNewAnswers(widget.receivedData![index]['answers'], newId);
        }
        else
        {
          await createNewAnswer(newId, widget.receivedData![index]['answerText']);
        }

        //AppConstants.idQuestion?.add({'id': newId});
      }
      // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );  
  }

 //картинки вопроса  

   Future<String> saveImageQestionOrAnswerToSupabase(File? imageFile) async {
      Random random = Random();
      String randomNumber = random.nextInt(100000000).toString().padLeft(9, '0');
      String img = "img $randomNumber";
      if(imageFile != null){
        // ignore: unused_local_variable
        final response = await supabase.storage
            .from('images')
            .upload('images/$img.jpg', imageFile);

        final imageUrl = supabase.storage
            .from('images')
            .getPublicUrl('images/$img.jpg');
        return imageUrl.characters.string;
      }
      else
      {
        return "";
      }
  }

 // Запись ответов на тест в бд 

  Future<void> createNewAnswers(List<Map<dynamic, dynamic>> savedData, int questionId) async { 
      final responseid = await supabase
      .from('Tests_answers')
      .select()
      // ignore: deprecated_member_use
      .execute();
      final count = responseid.data.length;
      int newId = count + 1;

      //Загрузка картинок теста и перезапись пути в url
      for (int index = 0; index < savedData.length; index++)
      {
        File? image = savedData[index]['path'];
        dynamic urlQestion = await saveImageQestionOrAnswerToSupabase(image);
        savedData[index]['path'] = urlQestion;
      }

      for (int index = 0; index < savedData.length; index++, newId++){

        // ignore: unused_local_variable
        final response = await supabase.from('Tests_answers').insert([
            {
              'id': newId,
              'text_answer': savedData[index]['answerText'],
              'is_correct_answer': savedData[index]['isBoolean'],
              'picture_link': savedData[index]['path'],
              'question_id': questionId,
            }
        // ignore: deprecated_member_use
        ]).execute();
      }
  }

  // Запись одного ответа на тест в бд 

  Future<void> createNewAnswer(int questionId, String answer) async { 
      final responseid = await supabase
      .from('Tests_answers')
      .select()
      // ignore: deprecated_member_use
      .execute();
      final count = responseid.data.length;
      int newId = count + 1;


      // ignore: unused_local_variable
      final response = await supabase.from('Tests_answers').insert([
          {
            'id': newId,
            'text_answer': answer,
            'is_correct_answer': true,
            'picture_link': "",
            'question_id': questionId,
          }
      // ignore: deprecated_member_use
      ]).execute();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: const Color.fromRGBO(220, 113, 127, 1),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                     const ImageMain(
                          width: 0.2,
                          height: 0.1,
                          picture: "assets/images/logo.svg"
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
                        size: 24
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center (
                child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TetstView(
                        descriptive: widget.descriptive,
                        height: 0.2,
                        name: widget.testname,
                        nickname: widget.nickname,
                        width: 0.9,
                        path: widget.path,
                      )
                    ],
                  )
                ],
                )
              )
            ),
            const Expanded(
              flex: 1,
              child: Center (
                child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextPlace(
                        txt: "Список вопросов", 
                        font: "Source Sans Pro", 
                        align: TextAlign.center, 
                        st: FontWeight.bold, 
                        width: 0.8, 
                        height: 0.04, 
                        backgroundColor: Colors.transparent, 
                        colortxt: Color.fromRGBO(54, 79, 107, 100), 
                        size: 24
                      ),
                    ],
                  ),
                ],
                )
              )
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: QuestionList(
                  onDataReceived: (data){
                    setState(() {
                      widget.receivedData = data;
                    });
                  },
                ),
              ), 
            ),
            Expanded(
              flex: 1,
              child: Center (
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonEntry(
                      isEnabled: true, 
                      txt: "Создать тест", 
                      size: 16, 
                      check: () async {

                        if (widget.receivedData != null)
                        {
                        await saveImageTestToSupabase(widget.path);
                        await createNewTests();
                        await createNewQuestion();
                        }
                        else 
                        {
                          Fluttertoast.showToast(
                            msg: "Нет вопросов в тесте",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      width: 0.4, 
                      height: 0.05, 
                      backgroundColor: const Color.fromRGBO(220, 113, 127, 100), 
                      colortxt: Colors.white)
                  ],
                ),
              )
              )
          ],
        ),
      ),
    );
  }
}