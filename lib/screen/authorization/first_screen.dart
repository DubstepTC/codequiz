import 'package:codequiz/screen/main_screen.dart';
import 'package:codequiz/screen/authorization/second_screen.dart';
import 'package:codequiz/screen/questions/first_option.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/authorization_button.dart';
import 'package:codequiz/widget/field.dart';
import 'package:codequiz/widget/text_button.dart';
import 'package:codequiz/widget/button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatpasswordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isButtonEnabledTwo = false;
  bool isSignInSelected = true;

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
      _isButtonEnabledTwo = _nameController.text.isNotEmpty &&
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
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageMain(
                                    width: 0.8,
                                    height: 0.45,
                                    picture: 'assets/images/car.svg')
                              ]),
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
                                      width: 0.8,
                                      labtext: 'Email address/ Nickname',
                                      height: 0.1,
                                      colortxt: Colors.black,
                                      mode: false,
                                      hinttxt: '',
                                      onChange: (value) {
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
                                  ButtonPush(
                                    size: 16,
                                    isEnabled: _isButtonEnabled,
                                    backgroundColor: _isButtonEnabled
                                        ? const Color.fromARGB(
                                            92, 220, 113, 127)
                                        : const Color.fromRGBO(
                                            220, 113, 127, 100),
                                    colortxt: Colors.white,
                                    height: 0.09,
                                    page: (context) => MainScreen(),
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
                                      width: 0.8,
                                      labtext: 'Email address/ Nickname',
                                      height: 0.1,
                                      colortxt: Colors.black,
                                      mode: false,
                                      hinttxt: '',
                                      onChange: (value) {
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
                                    width: 0.8,
                                    labtext: 'Repeat password',
                                    height: 0.1,
                                    colortxt: Colors.black,
                                    mode: true,
                                    hinttxt: '',
                                    onChange: (value) {
                                      if (!isSignInSelected) {
                                        setState(() {
                                          _repeatpasswordController.text =
                                              value;
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
                                  ButtonPush(
                                    size: 16,
                                    isEnabled: _isButtonEnabledTwo,
                                    backgroundColor: _isButtonEnabledTwo
                                        ? const Color.fromARGB(
                                            92, 220, 113, 127)
                                        : const Color.fromRGBO(
                                            220, 113, 127, 100),
                                    colortxt: Colors.white,
                                    height: 0.09,
                                    page: (context) => SecondScreen(),
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
