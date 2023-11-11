import 'dart:io';

import 'package:flutter/material.dart';

class ButtonPopQestion extends StatelessWidget {
  final String txt;
  final Color backgroundColor;
  final double width;
  final double height; 
  final Color colortxt;
  final double size;
  final bool isEnabled;

  final String questionText;
  final bool type;
  final List answers;
  final File? path;

  const ButtonPopQestion({ 
    required this.isEnabled, 
    required this.txt, 
    required this.size,
    required this.width, 
    required this.height, 
    required this.backgroundColor, 
    required this.colortxt,
    required this.questionText,
    required this.type,
    required this.answers,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;


   
    return ElevatedButton(
        onPressed: isEnabled ?() {
         Navigator.pop(context, {
            'questionText': questionText,
            'type': type,
            'path': path,
            'answers': answers,
        });  
        print(questionText);
        print(type);
        print(path);
        print(answers);
       }: null,
        child: Text(txt, style: TextStyle(color: colortxt, fontSize: size)), // Текст на кнопке
          style:  ElevatedButton.styleFrom(
          minimumSize: Size(rectangleWidth, rectangleHeight),
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
       ),
    );
  }
}