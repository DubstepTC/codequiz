import 'package:flutter/material.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/authorization_button.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isSignInSelected = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

     return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 229, 229),
      body: Column(
        children: [
          Expanded(
            flex: 1,
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
                      ImageMain(width: 0.8, height: 0.451, picture: "assets/images/logo.png")
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthorizationButton(
                          text: "Авторизация",
                          isSelected: isSignInSelected,
                          onSelected: (isSelected) {
                            setState(() {
                              isSignInSelected = isSelected;
                            });
                          },
                        ),
                        SizedBox(width: 40),
                        AuthorizationButton(
                          text: "Регистрация",
                          isSelected: !isSignInSelected,
                          onSelected: (isSelected) {
                            setState(() {
                              isSignInSelected = !isSelected;
                            });
                          },
                        ),
                      ],
                    ),
                  ]
                )
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color:  const Color.fromRGBO(250, 245, 245, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("43guih3uigi3")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}