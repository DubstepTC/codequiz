import 'dart:ffi';

import 'package:codequiz/AppConstants/constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NicknameWidget extends StatelessWidget {
  final void Function(String)? onEditPressed;

  NicknameWidget({
    required this.onEditPressed,
  });

  final supabase = SupabaseClient(
    "https://itcswmslhtagkazkjuit.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );
  
  Future<String> getNicknameById(int userId) async {
    final response = await supabase
      .from('Users')
      .select('nickname')
      .eq('id', userId)
      .single()
      .execute();

    if (response.status != 200) {
      Fluttertoast.showToast(
        msg: "Ошибка определения id пользователя",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return ""; // Возвращаем пустую строку в случае ошибки.
    } else {
      String nickname = response.data['nickname'];
      return nickname;
    }
  }

  Future<void> updateNicknameById(int userId, String newNickname) async {
    final response = await supabase
        .from('Users')
        .update({'nickname': newNickname})
        .eq('id', userId)
        .execute();

    if (response.status == 200) {
      Fluttertoast.showToast(
        msg: "Ошибка при изменении никнейма",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Никнейм пользователя успешно обновлен!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String>(
      future: getNicknameById(AppConstants.userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Ошибка получения никнейма');
        } else {
          String nickname = snapshot.data ?? "";
          final TextEditingController _editController =
              TextEditingController(text: nickname);

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nickname,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                color: const Color(0xFFDC717F),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Изменить никнейм'),
                        content: TextField(
                          controller: _editController,
                          textAlign: TextAlign.left,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Отмена',
                              style: TextStyle(color: Color(0xFFDC717F)),
                            ),
                          ),
                          const SizedBox(width: 24),
                          TextButton(
                            onPressed: () {
                              updateNicknameById(AppConstants.userID, _editController.text);
                              Navigator.of(context).pop();
                              onEditPressed?.call(_editController.text);
                            },
                            child: const Text(
                              'Сохранить',
                              style: TextStyle(color: Color(0xFFDC717F)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}