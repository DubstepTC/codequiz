import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxWidget extends StatefulWidget {
  final double height;
  final double width;
  final ValueChanged<bool>? onChanged;
  bool cash;

  CheckBoxWidget({
    super.key,
    required this.width,
    required this.height,
    this.cash = false,
    this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.cash;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          if (widget.onChanged != null) {
            widget.onChanged!(isChecked);
          }
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
              color: Color.fromRGBO(54, 79, 107, 100),
            ),
          ),
        ],
      ),
    );
  }
}
