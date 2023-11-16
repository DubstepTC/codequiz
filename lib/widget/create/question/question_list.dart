import 'package:codequiz/screen/creator/qestions_settings_one.dart';
import 'package:flutter/material.dart';

class QuestionList extends StatefulWidget {
  final Function(List<Map<dynamic, dynamic>>) onDataReceived;

  const QuestionList({super.key, required this.onDataReceived});
  
  @override
  // ignore: library_private_types_in_public_api
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<String> questionTexts = ['...'];

  List<Map<dynamic, dynamic>> questionVariables = [
   {'questionText': '...', 'type': false, 'path': null, 'answers': null, 'answerText': '...'}
  ];

  List<Map<dynamic, dynamic>> savedata = [
   {'questionText': '...', 'type': false, 'path': null, 'answers': null, 'answerText': '...'}
  ];

  Future<void> refreshList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      savedata = List.from(questionVariables);
      widget.onDataReceived(savedata);
      _sendDataBack(savedata);
    });
  }

  void _sendDataBack(List<Map<dynamic, dynamic>> receivedData) {
    // отправляем данные обратно в родительский виджет
    widget.onDataReceived(receivedData);
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
                    savedata = List.from(questionVariables);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Вопрос удалён')),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white, size: 40),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text('${index + 1}.', style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Center(
                          child: Text(
                            questionText,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
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
                          _sendDataBack(savedata);
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
                      savedata = List.from(questionVariables);
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