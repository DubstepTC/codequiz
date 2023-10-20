import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String txt;
  final Color backgroundColor;
  final double width;
  final double height; 
  final Color colortxt;
  final Widget Function(BuildContext) page;

  const ButtonText({required this.page, required this.txt, required this.width, required this.height, required this.backgroundColor, required this.colortxt});

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;


   
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: page, 
          ),
        );
        },
       child: Text(txt, textAlign: TextAlign.left, style: TextStyle(color: colortxt),), // Текст на кнопке
          style: TextButton.styleFrom(
          minimumSize: Size(rectangleWidth, rectangleHeight),
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
       ),
    );
  }
}