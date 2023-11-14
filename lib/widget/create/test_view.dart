import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TetstView extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final String nickname;
  final String descriptive;
  final File? path;

  final List<List<Color>> gradientColors = [
    [const Color(0xFFDC717F), const Color(0xCDE1E3FF)], // Градиент 1
    [
      const Color(0xFF7FE3DC),
      const Color.fromARGB(197, 209, 237, 246)
    ], // Градиент 2
    [
      const Color(0xFFC47FDC),
      const Color.fromARGB(197, 241, 223, 250)
    ], // Градиент 3
    [
      const Color(0xFF3EDC7F),
      const Color.fromARGB(197, 239, 246, 229)
    ], // Градиент 4
    [const Color(0xFFDC717F), const Color(0xCDE1E3FF)], // Градиент 5
  ];

  TetstView(
      {required this.width,
      required this.height,
      required this.name,
      required this.nickname,
      required this.path,
      required this.descriptive});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

    Random random = Random();
    int randomIndex = random.nextInt(gradientColors.length);

    return Container(
      width: rectangleWidth,
      height: rectangleHeight,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: gradientColors[
              randomIndex], // Используем цвета из списка для каждого индекса
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          Expanded(
           child: Container(
              width: rectangleWidth / 3,
              height: rectangleHeight * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent, // замените на нужный вам цвет
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: path != null
                  ? Image.file(path!, fit: BoxFit.cover,)
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(54, 79, 107, 100)),
                    ),
                    Text(
                      descriptive,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(54, 79, 107, 100)),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Text(
                          "от $nickname",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(54, 79, 107, 100)),
                        ),
                        const SizedBox(width: 16,)
                        ],)
                        
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}