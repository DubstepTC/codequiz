import 'package:flutter/material.dart';

class VerticalScrollWidget extends StatelessWidget {
  final double width;
  final double height;
  final String searchText;
  final List<List<Color>> gradientColors = [
    [const Color(0xFFDC717F), const Color(0xCDE1E3FF)], // Градиент 1
    [const Color(0xFF7FE3DC), const Color.fromARGB(197, 209, 237, 246)], // Градиент 2
    [const Color(0xFFC47FDC), const Color.fromARGB(197, 241, 223, 250)], // Градиент 3
    [const Color(0xFF3EDC7F), const Color.fromARGB(197, 239, 246, 229)], // Градиент 4
    [const Color(0xFFDC717F), const Color(0xCDE1E3FF)], // Градиент 5
    [const Color(0xFFFFC952), const Color(0xB8FF696B)], // Градиент 6
    [const Color(0xFFBFCD9E), const Color.fromARGB(232, 223, 212, 245)], // Градиент 7
  ];

  VerticalScrollWidget({required this.width, required this.height, required this.searchText});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        String title = 'Заголовок $index';

        if (searchText.isNotEmpty && !title.toLowerCase().contains(searchText.toLowerCase())) {
          return Container();
        }

        return GestureDetector(
          onTap: () {
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
            child: Row(
              children: <Widget>[
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: width,
                    child: Image.asset('assets/images/check.png'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Описание $index',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}