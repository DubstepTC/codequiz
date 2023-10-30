import 'package:codequiz/screen/authorization/first_screen.dart';
import 'package:codequiz/widget/authorization/reg_en_button.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/field.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:codequiz/widget/authorization/pol.dart';
import 'package:supabase/supabase.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
  final String dataFromControllerOne;
  final String dataFromControllerTwo;
  SecondScreen({required this.dataFromControllerOne, required this.dataFromControllerTwo});
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController _NickNameController = TextEditingController();
  final TextEditingController _educationalOrganizationController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _polController = TextEditingController();
  bool _isButtonEnabled = false;
  
  
  final supabase = SupabaseClient(
  "https://itcswmslhtagkazkjuit.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );
  

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
    
    void createNewUser() async {

    final responseid = await supabase
    .from('Users')
    .select()
    .execute();
    final count = responseid.data.length;

    final int newId = count + 1;

    final response = await supabase.from('Users').insert([{
      'id': newId,
      'first_name': '',
      'second_name': '',
      'third_name': '',
      'email': widget.dataFromControllerOne, 
      'password': widget.dataFromControllerTwo,
      'role': 1,
      'birthday': _birthdayController.text,
      'nickname': _NickNameController.text,
      'group': _groupController.text,
      'gender': _polController.text,
      'educational_organization': _educationalOrganizationController.text
      }
    ]).execute();

    if (response.status == 200) {
      Fluttertoast.showToast(
        msg: "Ошибка при создании пользователя",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Пользователь успешно создан!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
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
                      hinttxt: "гг.мм.дд",
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
                    ButtonEntry(
                        size: 16,
                        isEnabled: _isButtonEnabled,
                        backgroundColor: _isButtonEnabled
                                    ? const Color.fromARGB(92, 220, 113, 127)
                                    : const Color.fromRGBO(220, 113, 127, 100),
                        colortxt: Colors.white,
                        height: 0.09,
                        check: () {
                          createNewUser();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstScreen(), 
                            ),
                          );
                          Fluttertoast.showToast(
                            msg: "Войдите в аккаунт",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        txt: "Далее",
                        width: 0.8,
                    )
                  ],
                )
            ],
          ),
        )));
  }
}
