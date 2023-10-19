import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final double width;
  final double height; 

  const Frame({required this.width, required this.height});

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
         decoration: const BoxDecoration(
         color: Colors.white, 
         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight:  Radius.circular(20)),
       ),
       
       child: Align(alignment: Alignment.center,
         child: Image.asset("assets/images/logo.png", fit: BoxFit.contain,)
    )
    );
  }
}