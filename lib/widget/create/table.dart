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
    return RefreshIndicator(
      onRefresh: refreshList, // Обработчик обновления списка
      child: ListView.builder(
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index < questions.length) {
            return Dismissible(
              key: Key(questions[index]),
              onDismissed: (direction) {
                if (index == questions.length - 1) { // Проверка индекса последнего вопроса
                  setState(() {
                    questions.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Вопрос был удалён')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Вы можете удалять только последний вопрос')),
                  );
                }
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
    );
  }
}
