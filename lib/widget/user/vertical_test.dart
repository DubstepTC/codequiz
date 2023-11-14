import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase/supabase.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerticalScrollWidgetUser extends StatelessWidget {
  final double width;
  final double height;
  final String searchText;
  final List<List<Color>> gradientColors = [
    [const Color.fromARGB(255, 113, 152, 220), const Color(0xCDE1E3FF)], // Градиент 1
    [const Color.fromARGB(255, 212, 227, 127), const Color.fromARGB(197, 209, 237, 246)], // Градиент 2
    [const Color(0xFF3EDC7F), const Color.fromARGB(197, 239, 246, 229)], // Градиент 3
    [Color.fromARGB(255, 127, 153, 220), const Color(0xCDE1E3FF)], // Градиент 4
    [const Color(0xFFFFC952), const Color(0xB8FF696B)], // Градиент 5
    [const Color(0xFFBFCD9E), const Color.fromARGB(232, 223, 212, 245)], // Градиент 6
    [Color.fromARGB(255, 174, 208, 223), const Color(0xCDE1E3FF)], // Градиент 7
  ];

  VerticalScrollWidgetUser({required this.width, required this.height, required this.searchText});

  final supabase = SupabaseClient(
    "https://itcswmslhtagkazkjuit.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  Future<List<Map<String, dynamic>>> fetchDataFromSupaBase() async {
    // Выполняем запрос к таблице "Tests"
    final response = await supabase.from('Tests').select().execute();

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
    double rectangleWidth = screenWidth * width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDataFromSupaBase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else {
          final data = snapshot.data ?? [];
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                String title = data[index]['author_id'];
                if (searchText.isNotEmpty && !title.toLowerCase().contains(searchText.toLowerCase())) {
                  return Container();
                }
                return GestureDetector(
                  onTap: () {
                    // Обработчик нажатия
                    print('Вы нажали на контейнер $index');
                  },
                  child: Container(
                      width: rectangleWidth,
                      height: rectangleHeight,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: gradientColors[index % gradientColors.length], // Используем цвета из списка для каждого индекса
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
