import 'package:flutter/material.dart';

class ImageUrl extends StatelessWidget {
  final String picture;
  final double width;
  final double height; 

  const ImageUrl({required this.width, required this.height, required this.picture});

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

  
    return ClipOval(
      child: Container(
        width: rectangleWidth,
        height: rectangleHeight - 2,
        child: Image.network(picture, fit: BoxFit.cover),
      ),
    );
  }
}