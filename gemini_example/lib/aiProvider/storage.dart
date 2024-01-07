import 'dart:convert';

import 'package:SmarterAI/data/models/quiz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static void saveQuiz(Quiz quiz) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String quizJson = jsonEncode(quiz.toJson());

    String uniqueKey =
        "${quiz.title}-${DateTime.now().hour - DateTime.now().minute}";
    sp.setString(uniqueKey, quizJson);
  }

  static Future<void> deleteQuiz(Quiz quiz) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var keys = sp.getKeys().toList();
    for (String key in keys) {
      if (key.contains(quiz.title)) {
        Quiz q = Quiz.fromJson(jsonDecode((sp.getString(key)!)));
        if (q.title == quiz.title && q.tag == quiz.tag) {
          sp.remove(key);
          return;
        }
      }
    }
  }

  static Future<List<Quiz>> getAllQuiz() async {
    List<Quiz> quizes = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> keys = sp.getKeys().toList();

    try {
      for (String key in keys) {
        quizes.add(Quiz.fromJson(jsonDecode(sp.getString(key)!)));
      }
    } catch (e) {
      debugPrint(
          "Il recupero dei quiz dallo storage si è fermato per il seguente motivo: $e");
    }
    return quizes;
  }
}
