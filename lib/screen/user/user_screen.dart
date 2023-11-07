import 'package:codequiz/screen/creator/first_create_screen.dart';
import 'package:codequiz/screen/user/settings.dart';
import 'package:codequiz/widget/authorization/reg_en_button.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/main/vertical_bar.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:codequiz/widget/user/nick.dart';
import 'package:codequiz/widget/user/profile_picture.dart';
import 'package:codequiz/widget/user/user_button.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  final int id;
  final int user_role;
  UserScreen({required this.id, required this.user_role});
  
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool isSignInSelected = true;

  @override
  void initState() {
    super.initState();
  }

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
                  decoration: BoxDecoration(color: Colors.white),
                  child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ImageMain(
                          width: 0.2,
                          height: 0.1,
                          picture: "assets/images/logo.svg"),
                      SizedBox(
                        width: screenWidth * 0.07,
                      ),
                      const  TextPlace(
                          font: "Source Sans Pro",
                          txt: "Студент Тест",
                          align: TextAlign.center,
                          st: FontWeight.bold,
                          width: 0.4,
                          height: 0.05,
                          backgroundColor: Colors.white,
                          colortxt: Colors.black,
                          size: 24),
                      SizedBox(
                        width: screenWidth * 0.13,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => SettingsScreen(id: widget.id), 
                            ),
                          );
                        },
                        child: const ImageMain(
                          width: 0.085,
                          height: 0.04,
                          picture: "assets/images/settings.svg",
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.06,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: CircleImageWidget(height: 0.5, width: 0.5,),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 32),
                  NicknameWidget(
                    userId: widget.id,
                    onEditPressed: (value) {
                      setState(() {
                        _nameController.text = value; 
                      });
                    },
                  ),
                ]
              ),
            ),
            Row(
              children: [ 
                if (widget.user_role == 1)
                  Expanded(
                    
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserButton(
                          height: 0.05,
                          width: 1,
                          text: 'Активность',
                          isSelected: isSignInSelected,
                          onSelected: (isSelected) {},
                        )
                      ],
                    ),
                  )
                else if (widget.user_role != 1)
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        UserButton(
                            height: 0.05,
                            width: 0.5,
                            text: 'Активность',
                            isSelected: isSignInSelected,
                            onSelected: (isSelected) {
                              setState(() {
                              isSignInSelected = isSelected;
                              });
                            },
                        ),
                        UserButton(
                            height: 0.05,
                            width: 0.5,
                            text: 'Мои тесты',
                            isSelected: !isSignInSelected,
                            onSelected: (isSelected) {
                              setState(() {
                              isSignInSelected = !isSelected;
                              });
                            },
                        ),        
                      ],
                    ),
                  ),
              ],
            ),
            isSignInSelected
            ?
            Expanded(
              flex: 6,
              child: VerticalScrollWidget(
                height: 0.1,
                width: 0.75,
                searchText: "",
              ),
            )
            :
            Expanded(
              flex: 6,
              child: Column(children: [
                Expanded(
                  flex: 1,
                  child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children:[
                      ButtonEntry(
                        backgroundColor: const Color.fromRGBO(220, 113, 127, 100),
                        width: 0.6,
                        txt: "Создать Тест",
                        size: 16,
                        isEnabled: true,
                        height: 0.05,
                        colortxt: Colors.white,
                        check: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FirstCreateScreen(userId: widget.id,)), // замените YourNextPage на ваш класс следующей страницы
                          );
                        },
                      )
                    ]
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: VerticalScrollWidget(
                    height: 0.1,
                    width: 0.75,
                    searchText: "",
                  ),
                )
              ],
              )
            )
          ],
        ),
      ),
    );
  }
}
