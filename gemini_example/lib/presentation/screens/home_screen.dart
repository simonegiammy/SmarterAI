import 'package:flutter/material.dart';
import 'package:gemini_example/constants.dart';
import 'package:gemini_example/presentation/screens/new_quiz_screen.dart';
import 'package:gemini_example/presentation/widgets/quiz_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "QUIZ CREATI PER TE",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var res = await Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const NewQuizScreen();
          },
        ));
        if (res is bool && res) {
          setState(() {});
        }
      }),
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (String materia in GeminiCostants.materie)
                  QuizListView(title: materia)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
