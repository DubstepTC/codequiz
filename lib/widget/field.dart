import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  final double width;
  final double height;
  final Color colortxt;
  final String labtext;
  final String hinttxt;
  final bool mode;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;

  const Field({
    required this.width,
    required this.controller,
    required this.onChange,
    required this.labtext,
    required this.height,
    required this.colortxt,
    required this.mode,
    required this.hinttxt,
  });

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height - 4;

    return Container(
      width: rectangleWidth,
      height: rectangleHeight * 0.8,
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 233, 229, 0),
        border: Border(
          bottom: BorderSide(
            color: widget.controller != null && widget.controller!.text.isNotEmpty
                ? const Color.fromRGBO(78, 40, 197, 100)
                : Colors.black,
            width: 0.5,
          ),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: rectangleWidth - 16,
          child: TextField(
            onChanged: widget.onChange,
            controller: widget.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: widget.labtext,
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: widget.hinttxt,
              hintStyle: TextStyle(color: widget.colortxt),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.left,
            obscureText: widget.mode,
          ),
        ),
      ),
    );
  }
}