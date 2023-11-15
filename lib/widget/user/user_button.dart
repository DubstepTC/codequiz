import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:supabase/supabase.dart';


class UserButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Function(bool isSelected) onSelected;
  final double width;
  final double height; 

  final supabase = SupabaseClient(
  "https://itcswmslhtagkazkjuit.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  UserButton({super.key, 
    required this.text,
    required this.isSelected,
    required this.onSelected,
    required this.height,
    required this.width,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<UserButton> {
  void _toggleSelection() {
    if (!widget.isSelected) {
      widget.onSelected(!widget.isSelected);
    }
  }

  @override
  Widget build(BuildContext context) {

    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        width: rectangleWidth,
        height: rectangleHeight,
        decoration: BoxDecoration(
          color: widget.isSelected ? const Color.fromRGBO(255, 255, 255, 100) : const Color.fromRGBO(220, 113, 127, 100),
        ),
        child: Center(
          child: Text(
          widget.text,
          textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Source sun pro",
              color: widget.isSelected ? const Color.fromRGBO(54, 79, 107, 100) : const Color.fromRGBO(255, 255, 255, 100),
            ),
          ),
        ),
      ),
    );
  }
}