import 'package:SmarterAI/aiProvider/storage.dart';
import 'package:SmarterAI/presentation/screens/new_quiz_screen.dart';
import 'package:SmarterAI/presentation/widgets/quiz_list.dart';
import 'package:SmarterAI/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> subjects = [];
  TextEditingController inputController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      subjects = await Storage.getAllSubjects();
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

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
                  for (String materia in subjects) QuizListView(title: materia),
                  Row(
                    children: [
                      Expanded(
                        child: GeminiTextField(
                          hint: "Inserisci nuova materia",
                          controller: inputController,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                          width: 48,
                          height: 48,
                          child: GestureDetector(
                            onTap: () async {
                              if (inputController.text.isNotEmpty) {
                                await Storage.saveNewSubject(
                                    inputController.text);
                                inputController.clear();
                                subjects = await Storage.getAllSubjects();
                                if (mounted) {
                                  setState(() {});
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: const Color(0xfff0f0f0).withOpacity(0.2),
                              ),
                              child: const Icon(Icons.add),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
