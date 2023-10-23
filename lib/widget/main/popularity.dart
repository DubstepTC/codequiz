import 'package:flutter/material.dart';

class SwipeableContainerWidget extends StatefulWidget {
  @override
  _SwipeableContainerWidgetState createState() => _SwipeableContainerWidgetState();
}

class _SwipeableContainerWidgetState extends State<SwipeableContainerWidget> {
  List<String> containerData = [
    "Container 1",
    "Container 2",
    "Container 3",
    "Container 4",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: containerData.length,
      itemBuilder: (context, index) {
        final containerItem = containerData[index];

        return Dismissible(
          key: Key(containerItem),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onDismissed: (dismissDirection) {
            setState(() {
              containerData.removeAt(index);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.all(16.0),
            child: Text(containerItem),
          ),
        );
      },
    );
  }
}

