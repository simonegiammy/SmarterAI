import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gemini_example/aiProvider/storage.dart';
import 'package:gemini_example/data/models/quiz.dart';
import 'package:gemini_example/presentation/screens/quiz_screen.dart';

class QuizListView extends StatefulWidget {
  final String title;

  const QuizListView({super.key, required this.title});

  @override
  State<QuizListView> createState() => _QuizListViewState();
}

class _QuizListViewState extends State<QuizListView> {
  bool selected = false;
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
                          child: Icon(selected
                              ? Icons.keyboard_arrow_down
                              : Icons.arrow_forward_ios))
                    ],
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
                            for (Quiz quiz in filteredQuiz) QuizTile(quiz: quiz)
                          ],
                        );
                      },
                    )
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class QuizTile extends StatelessWidget {
  final Quiz quiz;
  const QuizTile({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff3A3030)),
      child: Row(
        children: [
          Expanded(child: Text(quiz.title)),
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
              child: const Icon(Icons.play_arrow),
            ),
          )
        ],
      ),
    );
  }
}
