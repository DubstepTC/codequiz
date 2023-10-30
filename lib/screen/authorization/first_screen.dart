import 'package:codequiz/screen/authorization/second_screen.dart';
import 'package:codequiz/screen/main_screen.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:codequiz/screen/questions/first_option.dart';
import 'package:codequiz/widget/authorization/reg_en_button.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/authorization/authorization_button.dart';
import 'package:codequiz/widget/field.dart';
import 'package:codequiz/widget/text_button.dart';
import 'package:flutter/services.dart';
import 'package:supabase/supabase.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatpasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isButtonEnabledTwo = false;
  bool isSignInSelected = true;
  final supabase = SupabaseClient(
  "https://itcswmslhtagkazkjuit.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _repeatpasswordController.dispose();
    super.dispose();
  }

  void _checkFieldsone() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _checkFieldstwo() {
    setState(() {
      _isButtonEnabledTwo = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _repeatpasswordController.text.isNotEmpty &&
          _passwordController.text == _repeatpasswordController.text;
    });
  }
  

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 229, 229),
        body: SingleChildScrollView(
          child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.5,
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.07,), 
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageMain(
                                    width: 0.8,
                                    height: 0.25,
                                    picture: 'assets/images/logo.svg')
                              ]),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextPlace(
                                  font: 'GoodDog',
                                  txt: "Cтудент Тест", 
                                  align: TextAlign.center, 
                                  st: FontWeight.bold, 
                                  width: 0.7, 
                                  height: 0.07, 
                                  backgroundColor: Colors.white, 
                                  colortxt: Colors.black, 
                                  size: 36)
                              ]),
                          SizedBox(height: screenHeight * 0.06,), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.05,
                                child: AuthorizationButton(
                                  text: "Авторизация",
                                  isSelected: isSignInSelected,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      isSignInSelected = isSelected;
                                      _nameController.text = "";
                                      _repeatpasswordController.text = "";
                                      _passwordController.text = "";
                                      _isButtonEnabled = false;
                                      _isButtonEnabledTwo = false;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.08),
                              SizedBox(
                                height: screenHeight * 0.05,
                                child: AuthorizationButton(
                                  text: "Регистрация",
                                  isSelected: !isSignInSelected,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      isSignInSelected = !isSelected;
                                      _nameController.text = "";
                                      _repeatpasswordController.text = "";
                                      _passwordController.text = "";
                                      _isButtonEnabled = false;
                                      _isButtonEnabledTwo = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ])),
              ),
              SizedBox(
                height: screenHeight * 0.5,
                child: Container(
                  color: const Color.fromRGBO(250, 245, 245, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isSignInSelected
                          ? Column(children: [
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyField(
                                      type: TextInputType.text,
                                      width: 0.8,
                                      labtext: 'Email address/ Nickname',
                                      height: 0.1,
                                      colortxt: Colors.black,
                                      mode: false,
                                      hinttxt: '',
                                      onChange: (value)  {
                                        if (isSignInSelected) {
                                          setState(() {
                                            _nameController.text = value;
                                            _checkFieldsone();
                                          });
                                        } else {
                                          setState(() {
                                            _nameController.text = value;
                                            _checkFieldstwo();
                                          });
                                        }
                                      },
                                      controller: _nameController,
                                    ),
                                  ]),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyField(
                                    type: TextInputType.text,
                                    width: 0.8,
                                    labtext: 'Password',
                                    height: 0.1,
                                    colortxt: Colors.black,
                                    mode: true,
                                    hinttxt: '',
                                    onChange: (value) {
                                      if (isSignInSelected) {
                                        setState(() {
                                          _passwordController.text = value;
                                          _checkFieldsone();
                                        });
                                      } else {
                                        setState(() {
                                          _passwordController.text = value;
                                          _checkFieldstwo();
                                        });
                                      }
                                    },
                                    controller: _passwordController,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonText(
                                    backgroundColor:
                                        const Color.fromRGBO(100, 124, 234, 0),
                                    colortxt: const Color.fromRGBO(
                                        220, 113, 127, 100),
                                    height: 0.05,
                                    page: (context) => FirstOption(),
                                    txt: "Забыли пароль?",
                                    width: 0.2,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.45,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.0845,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonEntry(
                                    size: 16,
                                    isEnabled: _isButtonEnabled,
                                    backgroundColor: _isButtonEnabled
                                        ? const Color.fromARGB(
                                            92, 220, 113, 127)
                                        : const Color.fromRGBO(
                                            220, 113, 127, 100),
                                    colortxt: Colors.white,
                                    height: 0.09,
                                    check: () async {

                                      String username = _nameController.text;
                                      String password = _passwordController.text;

                                      try {
                                        var response = await supabase
                                            .from('Users')
                                            .select()
                                            .eq('nickname', username)
                                            .eq('password', password)
                                            .execute();

                                        if (response.status == 200) {
                                          var data = response.data;

                                          // Проверка, найдены ли пользователь и пароль в базе данных
                                          if (data.length > 0) {
                                            Fluttertoast.showToast(
                                              msg: "Вход в систему",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MainScreen(), 
                                              ),
                                            );
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: "Введены неправильные учетные данные",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                            );
                                          }
                                        } else {
                                          // Обработка ошибки, если запрос не удался
                                           throw Exception('Ошибка запроса к базе данных');
                                        }
                                        } catch (error) {
                                          // Обработка ошибки
                                          print(error.toString());
                                          Fluttertoast.showToast(
                                              msg: "Произошла ошибка: ${error.toString()}",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                          );
                                      }
                                    },
                                    txt: "Войти",
                                    width: 0.8,
                                  )
                                ],
                              ),
                            ])
                          : Column(children: [
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyField(
                                      type: TextInputType.emailAddress,
                                      width: 0.8,
                                      labtext: 'Email address',
                                      height: 0.1,
                                      colortxt: Colors.black,
                                      mode: false,
                                      hinttxt: '',
                                      onChange: (value) {
                                        if (isSignInSelected) {
                                          setState(() {
                                          _emailController.text =value;
                                          _checkFieldstwo();
                                          });
                                        }
                                      },
                                      controller: _emailController,
                                    ),
                                  ]),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyField(
                                    type: TextInputType.text,
                                    width: 0.8,
                                    labtext: 'Password',
                                    height: 0.1,
                                    colortxt: Colors.black,
                                    mode: true,
                                    hinttxt: '',
                                    onChange: (value) {
                                      if (isSignInSelected) {
                                        setState(() {
                                          _passwordController.text = value;
                                          _checkFieldsone();
                                        });
                                      } else {
                                        setState(() {
                                          _passwordController.text = value;
                                          _checkFieldstwo();
                                        });
                                      }
                                    },
                                    controller: _passwordController,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyField(
                                    type: TextInputType.text,
                                    width: 0.8,
                                    labtext: 'Repeat password',
                                    height: 0.1,
                                    colortxt: Colors.black,
                                    mode: true,
                                    hinttxt: '',
                                    onChange: (value) {
                                      if (!isSignInSelected) {
                                        setState(() {
                                          _repeatpasswordController.text =value;
                                          _checkFieldstwo();
                                        });
                                      }
                                    },
                                    controller: _repeatpasswordController,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.0625,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonEntry(
                                    size: 16,
                                    isEnabled: _isButtonEnabledTwo,
                                    backgroundColor: _isButtonEnabledTwo
                                        ? const Color.fromARGB(
                                            92, 220, 113, 127)
                                        : const Color.fromRGBO(
                                            220, 113, 127, 100),
                                    colortxt: Colors.white,
                                    height: 0.09,
                                    check: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                        builder: (context) => SecondScreen(
                                          dataFromControllerOne: _emailController.text,
                                          dataFromControllerTwo: _passwordController.text,
                                        ), 
                                        ),
                                      );
                                    },
                                    txt: "Далее",
                                    width: 0.8,
                                  )
                                ],
                              ),
                            ])
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
