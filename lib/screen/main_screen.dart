import 'package:codequiz/widget/button.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/main/popularity.dart';
import 'package:codequiz/widget/questions/answer.dart';
import 'package:codequiz/widget/questions/progressbar.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white) ,
                  child:
                    const  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageMain(
                                    width: 0.2,
                                    height: 0.1,
                                    picture: "assets/images/logo_small.svg"
                        ),
                        TextPlace(
                          txt: "Студент Тест", 
                          align: TextAlign.center, 
                          st: FontWeight.bold, 
                          width: 0.5, 
                          height: 0.05, 
                          backgroundColor: Colors.white, 
                          colortxt: Colors.black, 
                          size: 24
                        ),
                        ImageMain(
                                    width: 0.15,
                                    height: 0.05,
                                    picture: "assets/images/search.svg"
                        ),
                        ImageMain(
                                    width: 0.15,
                                    height: 0.05,
                                    picture: "assets/images/user.svg"
                        ),
                      ],
                      )
                ),
              ),
            ),
             Expanded(
              child: SwipeableContainerWidget(),)
          ],
        ),
      ),
    );
  }
}