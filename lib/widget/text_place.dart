import 'package:flutter/material.dart';

class TextPlace extends StatelessWidget {
  final String txt;
  final Color backgroundColor;
  final double size;
  final double width;
  final double height; 
  final Color colortxt;
  final FontWeight st;
  final TextAlign align;
  final String font;

  const TextPlace({required this.txt,required this.font, required this.align, required this.st, required this.width, required this.height, required this.backgroundColor, required this.colortxt, required this.size,});

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

      return Container(
      width: rectangleWidth,
      height: rectangleHeight,
      decoration: BoxDecoration(
        color: backgroundColor, 
      ),
      child: Center(
        child: SizedBox(
          width: rectangleWidth,
          child: Text(
            txt,
            style: TextStyle(color: colortxt, fontSize: size, fontFamily: font, fontWeight: st, ),
            textAlign: align,
          ),
        ),
      ),
    );
  }
}