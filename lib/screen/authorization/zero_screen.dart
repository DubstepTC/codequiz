import 'dart:async';
import 'package:codequiz/screen/authorization/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:codequiz/widget/image.dart';


class ZeroScreen extends StatefulWidget{
  const ZeroScreen({super.key});


@override
  // ignore: library_private_types_in_public_api
  _ZeroScreenState createState() => _ZeroScreenState();
}

class _ZeroScreenState extends State<ZeroScreen> {
  
   @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 2), () { 
      Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstScreen() ));
    });
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                   ImageMain(width: 0.8, height: 0.55, picture: "assets/images/logo.svg")
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
    );
  }
}