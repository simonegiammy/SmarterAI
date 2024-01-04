import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gemini_example/data/models/quiz.dart';
import 'package:gemini_example/presentation/widgets/primary_button.dart';
import 'package:gemini_example/presentation/widgets/tile.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> answersGiven = [];
  int i = 1;
  String? selectedAnswer;
  @override
  void initState() {
    for (int j = 0; j < widget.quiz.questions.length; j++) {
      answersGiven.add(-1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "DOMANDA $i di ${widget.quiz.questions.length}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              widget.quiz.questions[i].question,
            ),
            const Divider(),
            for (String answer in widget.quiz.questions[i].answers)
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: AnswerTile(
                      text: answer,
                      onTap: () {
                        setState(() {
                          answersGiven[i] =
                              widget.quiz.questions[i].answers.indexOf(answer);
                          selectedAnswer = answer;
                        });
                      },
                      selected: selectedAnswer == answer)),
            Expanded(child: Container()),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: PrimaryButton(
                        onTap: () {}, text: "Indietro", loading: false)),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: PrimaryButton(
                        onTap: () {}, text: "Avanti", loading: false))
              ],
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}
