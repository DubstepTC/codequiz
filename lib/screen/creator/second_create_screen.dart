import 'dart:io';
import 'dart:math';
import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/main_screen.dart';
import 'package:codequiz/widget/authorization/reg_en_button.dart';
import 'package:codequiz/widget/create/question/question_list.dart';
import 'package:codequiz/widget/create/test_view.dart';
import 'package:supabase/supabase.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';

class SecondCreateScreen extends StatefulWidget {
  final String nickname;
  final String testname;
  final String descriptive; 
  final String? path;

   List<Map<dynamic, dynamic>>? receivedData;

   SecondCreateScreen({super.key, 
      this.receivedData,
      required this.nickname,
      required this.descriptive,
      required this.testname,
      required this.path,
    });
  @override
  _SecondCreateScreenState createState() => _SecondCreateScreenState();
}

class _SecondCreateScreenState extends State<SecondCreateScreen> {

  final supabase = SupabaseClient(
  "https://itcswmslhtagkazkjuit.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

 // Создание теста в бд

 // Создание теста 
  void createNewTests() async {
    final responseid = await supabase
    .from('Tests')
    .select()
    .execute();
    final count = responseid.data.length;
    final int newId = count + 1;

    print("Создание теста");
    final response = await supabase.from('Tests').insert([
        {
          'id': newId,
          'title': widget.testname,
          'description': widget.descriptive,
          'author_id': AppConstants.userID,
          'logo_image_link': AppConstants.url,
        }
      ]).execute();

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
 }
  // Загрузка картинки теста
  Future<void> saveImageToSupabase(File imageFile) async {
      Random random = Random();
      String randomNumber = random.nextInt(100000000).toString().padLeft(9, '0');
      String img = "img $randomNumber";

      // ignore: unused_local_variable
      final response = await supabase.storage
          .from('images')
          .upload('images/$img.jpg', imageFile);

      final imageUrl = supabase.storage
          .from('images')
          .getPublicUrl('images/$img.jpg');
          AppConstants.url = imageUrl.characters.string;
    }
 // Запись вопросов теста в бд 
 // Запись ответов на тест в бд 
 // Запись связей ответов и вопросов в бд 

  @override
  Widget build(BuildContext context) {
    print(widget.receivedData);
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
                        icon: Icon(Icons.arrow_back),
                        color: Color.fromRGBO(220, 113, 127, 1),
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
                        colortxt: const Color.fromRGBO(54, 79, 107, 100), 
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
                      check: () {
                        createNewTests();
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