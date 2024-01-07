import 'dart:math';

import 'package:SmarterAI/aiProvider/gemini.dart';
import 'package:SmarterAI/data/models/quiz.dart';
import 'package:SmarterAI/presentation/widgets/primary_button.dart';
import 'package:SmarterAI/presentation/widgets/tile.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> answersGiven = [];
  int i = 0;
  String? selectedAnswer;
  bool loading = false;
  bool showAnswer = false;
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
          "DOMANDA ${i + 1} di ${widget.quiz.questions.length}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              widget.quiz.questions[i].question,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(height: 1.2),
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
                      selected: answersGiven[i] ==
                          widget.quiz.questions[i].answers.indexOf(answer))),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Mostra la risposta corretta",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            showAnswer = !showAnswer;
                          });
                        },
                        child: Transform.rotate(
                          angle: showAnswer ? pi / 2 : 0,
                          child: const Icon(Icons.arrow_forward_ios),
                        ))
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: showAnswer
                      ? Text(widget.quiz.questions[i].explanation)
                      : null,
                ),
              ],
            )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: PrimaryButton(
                        onTap: () {
                          if (i > 0) {
                            setState(() {
                              i--;
                            });
                          }
                        },
                        text: "Indietro",
                        loading: false)),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: PrimaryButton(
                        onTap: () async {
                          if (i < answersGiven.length - 1 &&
                              answersGiven[i] != -1) {
                            setState(() {
                              i++;
                              showAnswer = false;
                            });
                          } else if (answersGiven[i] != -1) {
                            double punteggio =
                                _calcolaPunteggio(answersGiven, widget.quiz);
                            setState(() => loading = true);
                            String explanation = await GeminiProvider.chat(
                                "Scrivi un commento di massimo 50 caratteri per una persona che in un quiz ha totalizzato un punteggio di $punteggio su 30");
                            setState(() => loading = false);
                            Navigator.popUntil(
                                context, (route) => route.isFirst);

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    content: FinishQuizDialog(
                                  punteggio: punteggio,
                                  explanation: explanation,
                                ));
                              },
                            );
                          }
                        },
                        text: "Avanti",
                        loading: loading))
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

double _calcolaPunteggio(List<int> answers, Quiz quiz) {
  double p = 0;
  for (int i = 0; i < answers.length; i++) {
    if (answers[i] == quiz.questions[i].correct) {
      p++;
    }
  }

  return (p / answers.length) * 30;
}

class FinishQuizDialog extends StatelessWidget {
  final double punteggio;
  final String explanation;
  const FinishQuizDialog(
      {super.key, required this.punteggio, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Hai totalizzato un punteggio di:",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          "${punteggio.toStringAsFixed(2)}/30",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          explanation,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        PrimaryButton(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            text: "Torna alla home",
            loading: false)
      ],
    );
  }
}
