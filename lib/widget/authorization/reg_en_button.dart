import 'package:flutter/material.dart';

class ButtonEntry extends StatelessWidget {
  final String txt;
  final Color backgroundColor;
  final double width;
  final double height; 
  final Color colortxt;
  final double size;
  final VoidCallback? check;
  final bool isEnabled;

 

  const ButtonEntry({super.key,  required this.isEnabled, required this.txt, required this.size, required this.check, required this.width, required this.height, required this.backgroundColor, required this.colortxt});

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
         check?.call();
        }: null, // Текст на кнопке
          style:  ElevatedButton.styleFrom(
          minimumSize: Size(rectangleWidth, rectangleHeight),
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
       ),
        child: Text(txt, style: TextStyle(color: colortxt, fontSize: size)),
    );
  }
}