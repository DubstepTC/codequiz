import 'dart:io';

import 'package:codequiz/screen/main_screen.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/create/table.dart';
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
   SecondCreateScreen({
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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     ImageMain(
                          width: 0.2,
                          height: 0.1,
                          picture: "assets/images/logo.svg"
                      ),                     
                      TextPlace(
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
                child: QuestionList(),
              ), 
            ),
            Expanded(
              flex: 1,
              child: Center (
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonPush(
                      isEnabled: true, 
                      txt: "Создать тест", 
                      size: 16, 
                      page: (context) => MainScreen(id: 1), 
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