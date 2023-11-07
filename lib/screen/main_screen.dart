import 'package:supabase/supabase.dart';
import 'package:codequiz/screen/user/user_screen.dart';
import 'package:codequiz/widget/field.dart';
import 'package:codequiz/widget/image.dart';
import 'package:codequiz/widget/main/horizont_bar.dart';
import 'package:codequiz/widget/main/vertical_bar.dart';
import 'package:codequiz/widget/text_place.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  final int id;
  MainScreen({required this.id});
  int user_role = 1;
}

class _MainScreenState extends State<MainScreen> {
  String searchText = '';
  bool isSignInSelected = true;
  TextEditingController searchController = TextEditingController();

  final supabase = SupabaseClient(
  "https://itcswmslhtagkazkjuit.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  void getUserRole() async {
      final response = await supabase
      .from('Users')
      .select('role')
      .eq('id', widget.id)
      .execute();

      if (response.status != 200) {
        print('Ошибка запроса');
        return;
      }
      final data = response.data;
      if (data.length > 0) {
        widget.user_role = data[0]['role'];
      }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    getUserRole();

    return Scaffold(
      resizeToAvoidBottomInset: false, 
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
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      isSignInSelected
                      ? const TextPlace(
                          font: "Source Sans Pro",
                          txt: "Студент Тест",
                          align: TextAlign.center,
                          st: FontWeight.bold,
                          width: 0.4,
                          height: 0.05,
                          backgroundColor: Colors.white,
                          colortxt: Colors.black,
                          size: 24)
                      : MyField(
                            type: TextInputType.text,
                            colortxt: Colors.black,
                            height: 0.05,
                            hinttxt: "Поиск",
                            mode: false,
                            labtext: "",
                            width: 0.4,
                            onChange: (value) {
                              setState(() {
                                searchText = value;
                              });
                            }, 
                            controller: searchController,
                          ),
                      SizedBox(width: screenWidth * 0.05,),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSignInSelected = !isSignInSelected;
                            searchText = searchController.text;
                          });
                        },
                        child: const ImageMain(
                          width: 0.085,
                          height: 0.04,
                          picture: "assets/images/search.svg",
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03,),
                      InkWell(
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserScreen(id: widget.id, user_role: widget.user_role,)), // замените YourNextPage на ваш класс следующей страницы
                          );
                        },
                        child: const ImageMain(
                          width: 0.085,
                          height: 0.04,
                          picture: "assets/images/user.svg",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: HorizontalScrollWidget(height: 0.8, width: 0.75),
            ),
            const Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextPlace(
                          txt: "Тесты",
                          font: "Source Sans Pro",
                          align: TextAlign.center,
                          st: FontWeight.bold,
                          width: 0.6,
                          height: 0.05,
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          colortxt: Color.fromRGBO(54, 79, 107, 100),
                          size: 24)
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: VerticalScrollWidget(
                height: 0.25,
                width: 0.75,
                searchText: searchText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}