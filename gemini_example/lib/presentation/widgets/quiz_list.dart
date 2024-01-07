import 'dart:math';
import 'package:SmarterAI/aiProvider/storage.dart';
import 'package:SmarterAI/data/models/quiz.dart';
import 'package:SmarterAI/presentation/screens/quiz_screen.dart';
import 'package:flutter/material.dart';

class QuizListView extends StatefulWidget {
  final String title;

  const QuizListView({super.key, required this.title});

  @override
  State<QuizListView> createState() => _QuizListViewState();
}

class _QuizListViewState extends State<QuizListView> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FutureBuilder(
          future: Storage.getAllQuiz(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = !selected;
                            });
                          },
                          child: Transform.rotate(
                            angle: selected ? pi / 2 : 0,
                            child: const Icon(Icons.arrow_forward_ios),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (selected)
                    Builder(
                      builder: (context) {
                        List<Quiz> filteredQuiz = snapshot.data!
                            .where((element) => element.tag == widget.title)
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (Quiz quiz in filteredQuiz)
                              QuizTile(
                                  quiz: quiz,
                                  onDelete: () async {
                                    await Storage.deleteQuiz(quiz)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  }),
                            if (filteredQuiz.isEmpty)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nessun quiz creato per questa materia",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider()
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class QuizTile extends StatefulWidget {
  final Quiz quiz;
  final Function() onDelete;
  const QuizTile({super.key, required this.quiz, required this.onDelete});

  @override
  State<QuizTile> createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  @override
  Widget build(BuildContext context) {
    Quiz quiz = widget.quiz;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff3A3030)),
      child: Row(
        children: [
          Expanded(
              child: Text(
            quiz.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          )),
          const SizedBox(
            width: 6,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return QuizScreen(quiz: quiz);
                },
              ));
            },
            child: Container(
              height: 27,
              width: 51,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffD9D9D9)),
              child: const Icon(
                Icons.play_arrow_outlined,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: widget.onDelete,
            child: Container(
              height: 27,
              width: 51,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffD9D9D9)),
              child: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
