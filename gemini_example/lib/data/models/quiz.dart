import 'package:SmarterAI/data/models/question.dart';

class Quiz {
  String title;
  List<Question> questions;
  String tag;
  bool penalty;

  Quiz({
    required this.title,
    required this.questions,
    required this.tag,
    required this.penalty,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'questions': questions.map((question) => question.toJson()).toList(),
      'tag': tag,
      'penalty': penalty,
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      title: json['title'],
      questions: List<Question>.from(
        json['questions'].map(
          (questionJson) => Question.fromJson(questionJson),
        ),
      ),
      tag: json['tag'],
      penalty: json['penalty'],
    );
  }
}
