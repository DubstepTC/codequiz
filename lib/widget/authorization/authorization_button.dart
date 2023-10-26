import 'package:flutter/material.dart';


class AuthorizationButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Function(bool isSelected) onSelected;

  AuthorizationButton({
    required this.text,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<AuthorizationButton> {
  void _toggleSelection() {
    if (!widget.isSelected) {
      widget.onSelected(!widget.isSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        padding: EdgeInsets.only(bottom: widget.isSelected ? 2.0 : 0.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: widget.isSelected ? const Color.fromRGBO(78, 40, 197, 100) : Colors.transparent,
              width: 4.0,
            ),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Source sun pro",
          ),
        ),
      ),
    );
  }
}