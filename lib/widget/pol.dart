import 'package:flutter/material.dart';

class Pol extends StatefulWidget {
  final double width;
  final double height;
  final Color colortxt;
  final String labtext;
  final String hinttxt;
  final bool mode;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;

  const Pol(
      {required this.width,
      this.controller,
      this.onChange,
      required this.labtext,
      required this.height,
      required this.colortxt,
      required this.mode,
      required this.hinttxt});

      @override
  _PolState createState() => _PolState();
}

class _PolState extends State<Pol>{

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height - 4;

    return Container(
      width: rectangleWidth,
      height: rectangleHeight,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.controller != null && widget.controller!.text.isNotEmpty
                ? const Color.fromRGBO(220, 113, 127, 100)
                : Colors.black,
            width: 0.5,
          ),
        )
      ),
      child: Center(
        child: SizedBox(
          width: rectangleWidth - 16,
          child: DropdownButtonFormField<String>(
            value: null,
            onChanged: (String? newValue) {
              if (widget.onChange != null) {
                widget.onChange!(newValue!);
              }
            },
            items: ['Мужской', 'Женский'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: widget.labtext,
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: widget.hinttxt,
              hintStyle: TextStyle(color: widget.colortxt),
            ),
          ),
        ),
      ),
    );
  }
}