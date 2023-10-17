import 'package:flutter/material.dart';
import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/image.dart';
import 'package:flutter/services.dart';

class ZeroScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   ImageMain(width: 0.8, height: 0.55, picture: "assets/images/logo.png")
                  ],
                ),
                SizedBox(height: screenHeight * 0.001),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100, // Размер лоудера
                      height: 100,
                      child: 
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(220, 113, 127, 100)), // Цвет лоудера
                        strokeWidth: 7, // Толщина обводки
                      ),
                    )
                  ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}