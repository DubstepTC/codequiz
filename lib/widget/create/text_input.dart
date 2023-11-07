import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final double width;
  final double height;
  final Color colortxt;
  final int quantity;
  final String hinttxt;
  final int lines;
  final bool mode;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;

  const TextInput(
      {required this.width,
      this.controller,
      this.onChange,
      required this.quantity,
      required this.lines,
      required this.height,
      required this.colortxt,
      required this.mode,
      required this.hinttxt});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height - 4;

    return Container(
      width: rectangleWidth,
      height: rectangleHeight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(156, 233, 229, 229),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: controller != null && controller!.text.isNotEmpty
              ? const Color.fromRGBO(220, 113, 127, 100)
              : const Color.fromARGB(156, 233, 229, 229),
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          onChanged: onChange,
          maxLength: quantity,
          maxLines: lines,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttxt,
            hintStyle: TextStyle(color: colortxt),
          ),
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
          obscureText: mode,
        ),
      ),
    );
  }
}