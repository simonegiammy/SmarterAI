import 'package:SmarterAI/constants.dart';
import 'package:SmarterAI/presentation/screens/chat_screen.dart';
import 'package:SmarterAI/presentation/screens/new_quiz_screen.dart';
import 'package:SmarterAI/presentation/widgets/quiz_list.dart';
import 'package:flutter/material.dart';

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
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (String materia in GeminiCostants.materie)
                    QuizListView(title: materia)
                    , 
                    SizedBox(
                      height: 12,
                    ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) {
                      return ChatScreen();
                    },));
                  }, child: Text(
                    "Vai alla chat"
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
