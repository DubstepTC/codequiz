import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/smtp_server.dart';
import 'package:supabase/supabase.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class FogetPassword extends StatefulWidget {
  final String txt;
  final Color backgroundColor;
  final double width;
  final double height; 
  final Color colortxt;
  final Widget Function(BuildContext) page;

  FogetPassword({super.key, required this.page,required this.txt, required this.width, required this.height, required this.backgroundColor, required this.colortxt});
  
  _FogetPasswordState createState() => _FogetPasswordState();
  
}
  class _FogetPasswordState extends State<FogetPassword> {
    
  final TextEditingController _emailController = TextEditingController();
  String? password;
  String? nickname;

final supabase = SupabaseClient(
  "https://itcswmslhtagkazkjuit.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  getUserPasswordByEmail() async {

    try {
    final response = await supabase
        .from('Users')
        .select('password')
        .eq('email', _emailController.text) 
        .single()
        .execute();

      password = response.data['password'] as String;
      await getUserNicnameEmail();
      sendPasswordViaEmail(_emailController.text, password!, nickname!);

       Fluttertoast.showToast(
          msg: "Пароль отправлен вам на почту",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
    }
    catch(error){
        Fluttertoast.showToast(
          msg: "Почты нету в базе данных",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
    }
  }
  getUserNicnameEmail() async {
    final response = await supabase
        .from('Users')
        .select('nickname')
        .eq('email', _emailController.text) 
        .single()
        .execute();

    nickname = response.data['nickname'] as String;
  }

  Future<void> sendPasswordViaEmail(String recipientEmail, String passwordUser, String nickname) async {
  String username = 'codequiz@mail.ru'; // Замените на ваше имя пользователя Gmail
  String password = 'Un0fNugPsJpQ9T045swz'; // Замените на ваш пароль Gmail

  final smtpServer = SmtpServer('smtp.mail.ru', // SMTP сервер для mail.ru
    port: 465, // Порт 465 для SSL
    ssl: true, // Используем SSL
    username: username, // Ваш адрес электронной почты mail.ru
    password: password); // Ваш пароль от почты mail.ru

  final message = Message()
    ..from = Address(username, 'CodeQuiz')
    ..recipients.add(recipientEmail) // Получатель
    ..subject = 'Ваш пароль' // Заголовок письма
    ..text = '- ˕ •マ\nВаш ник: $nickname\n- ˕ •マ\nВаш пароль: $passwordUser\n\n ╱|、\n(˚ˎ 。7\n|、˜〵\nじしˍ,)ノ'; // Текст письма

  try {
    final sendReport = await send(message, smtpServer);
    print('Письмо отправлено');
  } on MailerException {
    print('Письмо не отправлено');
  }
}

  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width; 
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Введите вашу почту', style: TextStyle(fontFamily: "Source Sans Pro"),),
              content: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'example@example.com'),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('Готово', style: TextStyle(color: Color.fromRGBO(220, 113, 127, 100), fontFamily: "Source Sans Pro", fontSize: 24),),
                      onPressed: () async {
                        await getUserPasswordByEmail();
                        // В этом месте ты можешь обработать введенную почту
                        Navigator.of(context).pop();
                      },
                    ),
                  ]
                )
              ],
            );
          },
        );
      },
      child: Text(widget.txt, textAlign: TextAlign.left, style: TextStyle(color: widget.colortxt),),
      style: TextButton.styleFrom(
        minimumSize: Size(rectangleWidth, rectangleHeight),
        backgroundColor: widget.backgroundColor,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}