import 'package:flutter/material.dart';class SwitchWidget extends StatefulWidget {
  final double width;
  final double height;
  final bool isChecked;
  final ValueChanged<bool> onToggle; 

  const SwitchWidget({
    required this.width,
    required this.height,
    required this.isChecked,
    required this.onToggle,
  });

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widget.width,
      height: MediaQuery.of(context).size.height * widget.height,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Transform.scale(
              scale: 1.5,
              child: Switch(
                value: _isSelected,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSelected = newValue;
                  });
                  widget.onToggle(newValue);
                },
                activeColor: const Color.fromRGBO(78, 203, 113, 100),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Flexible(
            child: Text(
              _isSelected ? 'Вопрос без вариантов ответа' : 'Вопрос с вариантами ответа',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20.0, color: const Color.fromRGBO(54, 79, 107, 100)),
            ),
          ),
        ],
      ),
    );
  }
}
