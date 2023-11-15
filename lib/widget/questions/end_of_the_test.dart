import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedArcWidget extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;

  const AnimatedArcWidget(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedArcWidgetState createState() => _AnimatedArcWidgetState();
}

class _AnimatedArcWidgetState extends State<AnimatedArcWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    double percentageFilled =
        (widget.correctAnswers / widget.totalQuestions) * 100;
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Время анимации
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: percentageFilled).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward(); // Запускаем анимацию
  }

  @override
  void dispose() {
    _controller.dispose(); // Важно освободить ресурсы после использования
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Stack(
        children: [
          Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: CustomPaint(
                painter: _AnimatedArcPainter(_animation.value),
              ),
            ),
          ),
          Positioned(
            top: 90,
            right: screenWidth * 0.28,
            child: Center(
              child: 
                Text(
                  '${widget.correctAnswers} из ${widget.totalQuestions} \nверных ответов',
                  style: const TextStyle(
                      fontFamily: "Source Sans Pro",
                      fontSize: 24,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            )
          ),
        ],
      ),
    ]));
  }
}

class _AnimatedArcPainter extends CustomPainter {
  final double arcRatio;

  _AnimatedArcPainter(this.arcRatio);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = -pi / 2; // -90 градусов (в радианах)
    final sweepAngle =
        2 * pi * (arcRatio / 100); // Преобразуем процент в долю от 0 до 1

    Paint strokePaint = Paint()
      ..color = const Color.fromARGB(255, 213, 213, 213) // Цвет рамки круга
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    Paint fillPaint = Paint()
      ..color = Colors.green // Цвет заливки
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    // Сначала рисуем контур (рамку) круга
    canvas.drawArc(rect, startAngle, 2 * pi, false, strokePaint);

    // Затем рисуем заливку (часть круга)
    canvas.drawArc(rect, startAngle, sweepAngle, false, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
