import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageMain extends StatelessWidget {
  final String picture;
  final double width;
  final double height; 

  const ImageMain({required this.width, required this.height, required this.picture});

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
      height: rectangleHeight - 2,
      child: SvgPicture.asset(picture, fit: BoxFit.cover),
    );
  }
}