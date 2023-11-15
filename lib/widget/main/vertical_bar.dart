import 'package:codequiz/AppConstants/constants.dart';
import 'package:codequiz/screen/questions/question_type_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:supabase/supabase.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';

class VerticalScrollWidget extends StatefulWidget {
  final double width;
  final double height;
  final String searchText;
  final List<List<Color>> gradientColors = [
    [const Color.fromARGB(255, 113, 152, 220), const Color(0xCDE1E3FF)], // Градиент 1
    [const Color.fromARGB(255, 212, 227, 127), const Color.fromARGB(197, 209, 237, 246)], // Градиент 2
    [const Color(0xFF3EDC7F), const Color.fromARGB(197, 239, 246, 229)], // Градиент 3
    [const Color(0xFFFFC952), const Color(0xB8FF696B)], // Градиент 4
    [const Color.fromARGB(255, 127, 153, 220), const Color(0xCDE1E3FF)], // Градиент 5
    [const Color(0xFFBFCD9E), const Color.fromARGB(232, 223, 212, 245)], // Градиент 6
    [const Color.fromARGB(255, 174, 208, 223), const Color(0xCDE1E3FF)], // Градиент 7
    [const Color.fromARGB(255, 211, 130, 196),const Color.fromARGB(197, 239, 246, 229)],  // Градиент 8
  ];

  VerticalScrollWidget({super.key, required this.width, required this.height, required this.searchText});

  @override
  // ignore: library_private_types_in_public_api
  _VerticalScrollWidgettState createState() => _VerticalScrollWidgettState();
}

  class _VerticalScrollWidgettState extends State<VerticalScrollWidget> {
  
  late Future<List<Map<String, dynamic>>> _dataFuture;

  final supabase = SupabaseClient(
    "https://itcswmslhtagkazkjuit.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  
  @override
  void initState() {
    super.initState();
    _dataFuture = fetchDataFromSupaBase();
  } 


  //Запрос на id теста 
  getTestId(testName, nickname) async {
    int authorId = 0;
    
    final response = await supabase
        .from('Users')
        .select('id')
        .eq('nickname', nickname) 
        .single()
        // ignore: deprecated_member_use
        .execute();

    if (response.status != 200) {
      Fluttertoast.showToast(
        msg: "Ошибка при загрузке тетста",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } 
    else 
    {
      authorId = response.data['id'] as int;
    }
  

    final respons = await supabase
        .from('Tests')
        .select('id')
        .eq('title', testName) 
        .eq('author_id', authorId)
        .single()
        // ignore: deprecated_member_use
        .execute();  

    await setupNumberOfQuestion(respons.data['id']);
  }

  setupNumberOfQuestion(idTest) async
  {
   final responseid = await supabase
      .from('Tests_question')
      .select()
      .eq('test_id', idTest)
      // ignore: deprecated_member_use
      .execute();
    final count = responseid.data.length;
    AppConstants.questionList = responseid.data;
    AppConstants.numberOfQuestion = count;
    // ignore: avoid_print
    print("Колличество вопросов в тесте - $count");

    for(int index = 0; index < responseid.data.length; index++)
    {
      await setupNumberOfAnswers(responseid.data[index]['id']);
    }

   
  }

  setupNumberOfAnswers(idQuestion) async
  {
   final responseid = await supabase
      .from('Tests_answers')
      .select()
      .eq('question_id', idQuestion)
      // ignore: deprecated_member_use
      .execute();
    AppConstants.answersList.add(responseid.data);
  }


  


  Future<List<Map<String, dynamic>>> fetchDataFromSupaBase() async {
    // Выполняем запрос к таблице "Tests"
    final response = await supabase
    .from('Tests')
    .select()
    .order('id', ascending: true)
    // ignore: deprecated_member_use
    .execute();

    if (response.status == 200) {
      // Возвращаем данные, если запрос выполнен успешно
      List<Map<String, dynamic>>? data = List<Map<String, dynamic>>.from(response.data ?? []);

      for (int i = 0; i < data.length; i++) {
      int creatorId = data[i]['author_id'];
      String creatorName = await getCreatorName(creatorId);
      data[i]['author_id'] = creatorName;
      }
      return data;
    } else {
        // Обрабатываем ошибку, если запрос завершился неудачно
        throw response.status;
    }
  }

  Future<String> getCreatorName(int creatorId) async {
  final response = await supabase
      .from('Users')
      .select('nickname')
      .eq('id', creatorId)
      // ignore: deprecated_member_use
      .execute();

  if (response.status == 200 && response.data != null) {
    return response.data[0]['nickname'] as String;
  } else {
    throw 'Ошибка при получении ника для id $creatorId';
  }
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else {
          final data = snapshot.data ?? [];
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                String title = data[index]['title'];
                if (widget.searchText.isNotEmpty && !title.toLowerCase().contains(widget.searchText.toLowerCase())) {
                  return Container();
                }
                return GestureDetector(
                  onTap: () async {

                    await getTestId(data[index]['title'], data[index]['author_id']);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const FirstOption(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              }
                      )
                    );
                  },
                  child: Container(
                      width: rectangleWidth,
                      height: rectangleHeight,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: widget.gradientColors[index % widget.gradientColors.length], // Используем цвета из списка для каждого индекса
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(children: <Widget>[
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            width: rectangleWidth / 5.5,
                            height: rectangleHeight * 0.7 ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors
                                  .transparent, // замените на нужный вам цвет
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: data[index]['logo_image_link'] != null
                                  ? Image.network(
                                      data[index]['logo_image_link'],
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset('assets/images/test.svg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                54, 79, 107, 100)),
                                      ),
                                      Text(
                                        data[index]['description'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(
                                                54, 79, 107, 100)),
                                        maxLines: 4,
                                        overflow: TextOverflow
                                            .ellipsis, // Показывать многоточие при обрезании текста
                                      ),
                                    ],
                                  )),
                              Expanded(
                                flex: 1,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "от ${data[index]['author_id']}",
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    54, 79, 107, 100)),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          )
                                        ],
                                      )
                                    ]),
                              )
                            ],
                          ),
                        )
                      ])),
                );
              });
        }
      },
    );
  }
}
