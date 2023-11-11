import 'package:codequiz/screen/creator/answer_settings.dart';
import 'package:flutter/material.dart';

class AnswerList extends StatefulWidget {
  @override
  _AnswerListState createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  List<String> questions = ['...'];

  List<Map<String, dynamic>> answerVariables = [
    {'answerText': '...', 'isBoolean': false, 'url': '...'}
  ];

  Future<void> refreshList() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {});
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
            var url = answer['url'] ?? '...';
            final isBoolean = answer['isBoolean'];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  questions.removeAt(index);
                  answerVariables.removeAt(index);
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
                          url: url, // Передача значения переменной url
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
                          answerVariables[index]['url'] =
                              result['url']; // Обновление переменной url
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
                      'url': '...'
                    }); // Добавление переменной url при создании нового ответа
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
