import 'package:codequiz/screen/creator/qestions_settings_one.dart';
import 'package:flutter/material.dart';

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<String> questionTexts = ['...'];

  List<Map<dynamic, dynamic>> questionVariables = [
   {'questionText': '...', 'type': false, 'path': null, 'answers': null, 'answerText': '...'}
  ];

  Future<void> refreshList() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refreshList,
        child: ListView.builder(
          itemCount: questionTexts.length + 1,
          itemBuilder: (context, index) {
            if (index < questionTexts.length) {
              final question = questionVariables[index];
              var questionText = question['questionText'] ?? '...';
              final type = question['type'];
              var path = question['path'];
              var answers = question['answers'];
              var answerText = question['answerText'];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    questionTexts.removeAt(index);
                    questionVariables.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Вопрос удалён')),
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
                            questionText,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionSettingsFirst(
                            questionText: questionText,
                            type: type,
                            path: path,
                            answers: answers,
                            answerText: answerText,
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          questionVariables[index]['questionText'] = result['questionText'];
                          questionVariables[index]['type'] = result['type'];
                          questionVariables[index]['path'] = result['path'];
                          questionVariables[index]['answers'] = result['answers'];
                          questionVariables[index]['answerText'] = result['answerText'];
                        });
                      }
                    },
                  ),
                ),
              );
            } else {
              return ListTile(
                title: const Text('Добавить вопрос'),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      questionTexts.add('...');
                      questionVariables.add({
                        'questionText': '...',
                        'type': false,
                        'path': null,
                        'answers': null,
                        'answerText': '...',
                      });
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