import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  String question;
  List<String> answers;
  int correct;
  String explanation;

  Question({
    required this.question,
    required this.answers,
    required this.correct,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
        correct: json["correct"],
        explanation: json["explanation"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x)),
        "correct": correct,
        "explanation": explanation,
      };
}
