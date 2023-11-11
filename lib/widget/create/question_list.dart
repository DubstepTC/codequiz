import 'package:codequiz/screen/creator/qestions_settings_one.dart';
import 'package:flutter/material.dart';

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<String> questions = ['...'];

  Future<void> refreshList() async {
    // Ожидаем удаление элемента для обновления списка
    await Future.delayed(Duration(milliseconds: 300));

    setState(() {}); // Перерисовываем виджет полностью
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refreshList, // Обработчик обновления списка
        child: ListView.builder(
          itemCount: questions.length + 1,
          itemBuilder: (context, index) {
            if (index < questions.length) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  // Проверка индекса последнего вопроса
                  setState(() {
                    questions.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Вопрос был удалён')),
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
                            questions[index],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        print('создан вопрос: ${questions[index]}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionSettingsFirst(),
                          ),
                        );
                      });
                    },
                  ),
                ),
              );
            } else {
              return ListTile(
                title: Text('Добавить вопрос'),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      questions.add('...');
                    });
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}