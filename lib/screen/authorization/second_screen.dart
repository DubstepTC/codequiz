import 'package:codequiz/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/field.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:codequiz/widget/authorization/pol.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController _NickNameController = TextEditingController();
  final TextEditingController _educationalOrganizationController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _polController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _NickNameController.dispose();
    _educationalOrganizationController.dispose();
    _birthdayController.dispose();
    _groupController.dispose();
    _polController.dispose();
    super.dispose();
  }

  void _checkFieldsone() {
    setState(() {
      _isButtonEnabled = _NickNameController.text.isNotEmpty &&
          _educationalOrganizationController.text.isNotEmpty &&
          _birthdayController.text.isNotEmpty &&
          _groupController.text.isNotEmpty &&
          _polController.text.isNotEmpty ;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 229, 229),
        body: SingleChildScrollView(
            child: Center(
              child: Column(
              children: [
                  const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextPlace(
                      font: "Roboto",
                      txt: "Заполните анкету", 
                      align: TextAlign.center, 
                      st: FontWeight.bold, 
                      width: 0.8, 
                      height: 0.2, 
                      backgroundColor: Color.fromRGBO(12, 12, 324, 0), 
                      colortxt: Colors.black, 
                      size: 24)
                  ],
                ),
                SizedBox(height: screenHeight * 0.01,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyField(
                      type: TextInputType.text,
                      width: 0.8,
                      labtext: "Nickname", 
                      height: 0.1, 
                      colortxt: Colors.black, 
                      mode: false, 
                      hinttxt: "",
                      onChange: (value) {
                        setState(() {
                           _NickNameController.text = value; // Установка значения поля
                           _checkFieldsone();
                        });
                      },
                      controller: _NickNameController,)
                  ],
                ), 
                SizedBox(height: screenHeight * 0.05,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyField(
                      type: TextInputType.text,
                      width: 0.8,
                      labtext: "Образовательная организация", 
                      height: 0.1, 
                      colortxt: Colors.black, 
                      mode: false, 
                      hinttxt: "",
                      onChange: (value) {
                        setState(() {
                           _educationalOrganizationController.text = value; // Установка значения поля
                           _checkFieldsone();
                        });
                      },
                      controller: _educationalOrganizationController,)
                  ],
                ), 
                SizedBox(height: screenHeight * 0.05,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyField(
                      type: TextInputType.datetime,
                      width: 0.8,
                      labtext: "Дата рождения", 
                      height: 0.1, 
                      colortxt: Colors.black, 
                      mode: false, 
                      hinttxt: "",
                      onChange: (value) {
                        setState(() {
                           _birthdayController.text = value; // Установка значения поля
                           _checkFieldsone();
                        });
                      },
                      controller: _birthdayController,)
                  ],
                ), 
                SizedBox(height: screenHeight * 0.05,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyField(
                      type: TextInputType.text,
                      width: 0.8, 
                      labtext: "Группа", 
                      height: 0.1, 
                      colortxt: Colors.black, 
                      mode: false, 
                      hinttxt: "",
                      onChange: (value) {
                        setState(() {
                           _groupController.text = value; // Установка значения поля
                           _checkFieldsone();
                        });
                      },
                      controller: _groupController,)
                  ],
                ), 
                SizedBox(height: screenHeight * 0.05,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pol(
                      width: 0.8, 
                      labtext: "Пол", 
                      height: 0.1, 
                      colortxt: Colors.black, 
                      mode: false, 
                      hinttxt: "",
                      onChange: (value) {
                        setState(() {
                           _polController.text = value; // Установка значения поля
                           _checkFieldsone();
                        });
                      },
                      controller: _polController,
                      )
                  ],
                ),
                SizedBox(height: screenHeight * 0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonPush(
                      size: 16,
                      isEnabled: _isButtonEnabled,
                      backgroundColor: _isButtonEnabled
                              ? const Color.fromARGB(92, 220, 113, 127)
                              : const Color.fromRGBO(220, 113, 127, 100),
                      colortxt: Colors.white,
                      height: 0.09,
                      page: (context) => MainScreen(),
                      txt: "Зарегистрироваться",
                      width: 0.8,
                      )
                  ],
                )
            ],
          ),
        )));
  }
}
