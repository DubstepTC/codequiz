import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  @override 
  final double height;
  final double width;

  const CheckBoxWidget({
    required this.width, 
    required this.height,
  });


  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Row(
        children: [
          Container(
            width: rectangleWidth,
            height: rectangleHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: isChecked
                ? Icon(
                    Icons.check,
                    size: rectangleHeight - 6,
                    color: Colors.green,
                  )
                : null,
          ),
          const SizedBox(width: 8.0),
          const Text(
            'Ответ является правильным?',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "Source Sans Pro",
              color: Color.fromRGBO(54, 79, 107, 100)
            ),
          ),
        ],
      ),
    );
  }
}