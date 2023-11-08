import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          value: _isSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isSelected = newValue;
            });
          },
          activeColor: Colors.green,
        ),
        Text(
          _isSelected ? 'Вопрос с вариантами ответа' : 'Вопрос с текстовым полем в качестве ответа',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: const Color.fromRGBO(54, 79, 107, 100)),
        ),
      ],
    );
  }
}