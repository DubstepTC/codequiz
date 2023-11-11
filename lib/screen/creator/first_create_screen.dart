import 'dart:io';

import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/creator/second_create_screen.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/create/image_input.dart';
import 'package:codequiz/widget/create/text_input.dart';
import 'package:supabase/supabase.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstCreateScreen extends StatefulWidget {
  @override
  _FirstCreateScreenState createState() => _FirstCreateScreenState();
}

class _FirstCreateScreenState extends State<FirstCreateScreen> {
  bool _isCompletion = false;
  final TextEditingController _testController = TextEditingController();
  final TextEditingController _opController = TextEditingController();

  String? nickname;

  String? _selectedImagePath = "";

  void _onImageSelected(String imagePath) {
    setState(() {
      _selectedImagePath = imagePath;
    });
    print('Выбрано изображение: $_selectedImagePath');
  }

  @override
  void initState() {
    super.initState();
    getNicknameById(AppConstants.userID);
  }

  void dispose() {
    _testController.dispose();
    _opController.dispose();
    super.dispose();
  }

  void _checkFieldsone() {
    setState(() {
      _isCompletion = _testController.text.isNotEmpty ||
          (_testController.text.isNotEmpty && _opController.text.isNotEmpty);
    });
  }

  final supabase = SupabaseClient(
    "https://itcswmslhtagkazkjuit.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  Future<void> getNicknameById(int userId) async {
    final response = await supabase
        .from('Users')
        .select('nickname')
        .eq('id', userId)
        .single()
        .execute();

    if (response.status != 200) {
      Fluttertoast.showToast(
        msg: "Ошибка определения id пользователя",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      setState(() {
        nickname = response.data['nickname'];
      });
    }
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
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextPlace(
                          txt: "Придумайте название для теста",
                          font: "Source Sans Pro",
                          align: TextAlign.left,
                          st: FontWeight.bold,
                          width: 0.8,
                          height: 0.04,
                          backgroundColor: Colors.transparent,
                          colortxt: Color.fromRGBO(54, 79, 107, 100),
                          size: 16),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextInput(
                        lines: 1,
                        width: 0.8,
                        height: 0.08,
                        colortxt: Colors.grey,
                        mode: false,
                        hinttxt: "Введите название",
                        quantity: 25,
                        onChange: (value) {
                          setState(() {
                            _testController.text = value;
                            _checkFieldsone();
                          });
                        },
                        controller: _testController,
                      )
                    ],
                  )
                ],
              )),
            ),
            Expanded(
                flex: 2,
                child: Center(
                    child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextPlace(
                            txt: "Придумайте краткое описание",
                            font: "Source Sans Pro",
                            align: TextAlign.left,
                            st: FontWeight.bold,
                            width: 0.8,
                            height: 0.04,
                            backgroundColor: Colors.transparent,
                            colortxt: Color.fromRGBO(54, 79, 107, 100),
                            size: 16),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextInput(
                          lines: 5,
                          width: 0.8,
                          height: 0.2,
                          colortxt: Colors.grey,
                          mode: false,
                          hinttxt: "Введите краткое описание",
                          quantity: 40,
                          onChange: (value) {
                            setState(() {
                              _opController.text = value;
                              _checkFieldsone();
                            });
                          },
                          controller: _opController,
                        ),
                      ],
                    )
                  ],
                ))),
            Expanded(
                flex: 3,
                child: Center(
                    child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextPlace(
                            txt: "Загрузите картинку(png)",
                            font: "Source Sans Pro",
                            align: TextAlign.left,
                            st: FontWeight.bold,
                            width: 0.8,
                            height: 0.05,
                            backgroundColor: Colors.transparent,
                            colortxt: Color.fromRGBO(54, 79, 107, 100),
                            size: 16)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageUploadWidget(
                          height: 0.31,
                          width: 0.8,
                          onImageSelected: _onImageSelected,
                        ),
                      ],
                    )
                  ],
                ))),
            Expanded(
                flex: 1,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isCompletion
                          ? ButtonPush(
                              isEnabled: true,
                              txt: "Продолжить",
                              size: 16,
                              page: (context) => SecondCreateScreen(nickname: nickname ?? '', descriptive: _opController.text, testname: _testController.text, path: _selectedImagePath),
                              width: 0.4,
                              height: 0.05,
                              backgroundColor: const Color.fromRGBO(220, 113, 127, 100),
                              colortxt: Colors.white)
                          : const SizedBox()
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}