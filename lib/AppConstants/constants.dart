import 'dart:io';

class AppConstants {
  static String url = "";
  static String urlTest = "";
  static int userRole = 1;
  static String nickname = "";
  static int userID = 0;
  static String urlStandartTest = 'https://itcswmslhtagkazkjuit.supabase.co/storage/v1/object/public/images/4819462-middle-transformed.png';
  static int testID = 0;
  static File? image;
  static List<Map<dynamic, dynamic>>? idQuestion;


  //Переменные для открытия теста
  static int numberOfQuestion = 0;
  static int numberScreenQuestion = -1;
  static int correctAnswer = 0;
  static List<dynamic>? questionList;
  // Другие общие переменные
}// TODO Implement this library.