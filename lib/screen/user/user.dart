import 'package:codequiz/widget/field.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/main/horizont_bar.dart';
import 'package:codequiz/widget/main/search.dart';
import 'package:codequiz/widget/main/vertical_bar.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:codequiz/widget/user/profile_picture.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

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
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ImageMain(
                          width: 0.2,
                          height: 0.1,
                          picture: "assets/images/logo.svg"),
                      SizedBox(width: screenWidth * 0.07,),
                      const TextPlace(
                          font: "Roboto",
                          txt: "Студент Тест",
                          align: TextAlign.center,
                          st: FontWeight.bold,
                          width: 0.4,
                          height: 0.05,
                          backgroundColor: Colors.white,
                          colortxt: Colors.black,
                          size: 24),
                      SizedBox(width: screenWidth * 0.13,),
                      InkWell(
                        onTap: () {
                          print("Hello");
                        },
                        child: const ImageMain(
                          width: 0.085,
                          height: 0.04,
                          picture: "assets/images/settings.svg",
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.06,),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: CircleImageWidget(height: 0.5, width: 0.5,)
            ),
            Expanded(
              flex: 1,
              child: Text("Кнопки")
            ),
            Expanded(
              flex: 7,
              child: VerticalScrollWidget(
                height: 0.1,
                width: 0.75,
                searchText: "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}