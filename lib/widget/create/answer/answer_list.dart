import 'package:codequiz/screen/creator/answer_settings.dart';
import 'package:flutter/material.dart';

class AnswerList extends StatefulWidget {
  final Function(List<Map<dynamic, dynamic>>) onDataReceived;
  final List<Map<dynamic, dynamic>>? answers;

  const AnswerList({Key? key, required this.onDataReceived, required this.answers}) : super(key: key);
  @override
  _AnswerListState createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  List<dynamic> questions = ['...'];

  List<Map<dynamic, dynamic>> answerVariables = [
    {'answerText': '...', 'isBoolean': false, 'path': null}
  ];

  @override
  void initState() {
    super.initState();
    if (widget.answers != null) {
      // Если переменная answer не пустая, используем ее для инициализации списка ответов
      answerVariables = List.from(widget.answers!);
      savedData = List.from(widget.answers!);
    } 
  }

  // Добавляем новую переменную для хранения данных
  List<Map<dynamic, dynamic>> savedData = [
    {'answerText': '...', 'isBoolean': false, 'path': null}
  ];

  Future<void> refreshList() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      // Сохраняем данные в переменную savedData при обновлении списка
      savedData = List.from(answerVariables);
      widget.onDataReceived(savedData);
      _sendDataBack(savedData);
    });
  }

   void _sendDataBack(List<Map<dynamic, dynamic>> receivedData) {
    // отправляем данные обратно в родительский виджет
    widget.onDataReceived(receivedData);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshList(), // Обработчик обновления списка
      child: ListView.builder(
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index < questions.length) {
            final answer = answerVariables[index];
            var answerText = answer['answerText'] ?? '...';
            var path = answer['path'];
            final isBoolean = answer['isBoolean'];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  questions.removeAt(index);
                  answerVariables.removeAt(index);
                  savedData = List.from(answerVariables);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ответ был удалён')),
                );
              },
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white, size: 40),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Text('${index + 1}.', style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Center(
                        child: Text(
                          answerText,
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerSettingsFirst(
                          answerText: answerText,
                          isBoolean: isBoolean,
                          path: path, // Передача значения переменной url
                        ),
                      ),
                    ).then((result) {
                      if (result != null) {
                        setState(() {
                          // Обновить значения переменных после редактирования
                          answerVariables[index]['answerText'] =
                              result['answerText'];
                          answerVariables[index]['isBoolean'] =
                              result['isBoolean'];
                          answerVariables[index]['path'] =
                              result['path'];
                          _sendDataBack(savedData);
                        });
                      }
                    });
                  },
                ),
              ),
            );
          } else {
            return ListTile(
              title: Text('Добавить ответ'),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    questions.add('...');
                    answerVariables.add({
                      'answerText': '...',
                      'isBoolean': false,
                      'path': null,
                    }); 
                    savedData = List.from(answerVariables); // Добавление переменной url при создании нового ответа
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}