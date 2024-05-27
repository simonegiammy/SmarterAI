import 'package:SmarterAI/aiProvider/gemini.dart';
import 'package:SmarterAI/aiProvider/storage.dart';
import 'package:SmarterAI/constants.dart';
import 'package:SmarterAI/data/models/question.dart';
import 'package:SmarterAI/data/models/quiz.dart';
import 'package:SmarterAI/presentation/widgets/add_new_button.dart';
import 'package:SmarterAI/presentation/widgets/primary_button.dart';
import 'package:SmarterAI/presentation/widgets/textfield.dart';
import 'package:SmarterAI/presentation/widgets/tile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewQuizScreen extends StatefulWidget {
  const NewQuizScreen({super.key});

  @override
  State<NewQuizScreen> createState() => _NewQuizScreenState();
}

class _NewQuizScreenState extends State<NewQuizScreen> {
  String? selectedMateria;
  TextEditingController controller = TextEditingController();
  List<PlatformFile> uploadedFiles = [];
  int numberQuestion = 5;
  bool penalty = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "CREA UN NUOVO QUIZ",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seleziona la materia:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 14,
              ),
              Wrap(
                children: [
                  for (String materia in GeminiCostants.materie)
                    Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: SubjectTile(
                            text: materia,
                            onTap: () {
                              setState(() {
                                selectedMateria = materia;
                              });
                            },
                            selected: materia == selectedMateria))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Inserisci il titolo del quiz: ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              GeminiTextField(controller: controller),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Inserisci il file da cui vuoi ripassare: ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              for (PlatformFile file in uploadedFiles)
                Row(
                  children: [
                    const Icon(
                      Icons.insert_drive_file_outlined,
                      color: Color(0xffD9D9D9),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      file.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            uploadedFiles.remove(file);
                          });
                        },
                        icon: const Icon(Icons.cancel_presentation))
                  ],
                ),
              if (uploadedFiles.isEmpty)
                AddNewButton(onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'png', 'jpg'],
                          allowMultiple: false);

                  setState(() {
                    uploadedFiles = result?.files ?? [];
                  });
                }),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Numero di domande: ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  NormalButton(
                      onTap: () {
                        if (numberQuestion > 5) {
                          setState(() {
                            numberQuestion--;
                          });
                        }
                      },
                      child: const Icon(Icons.remove)),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "$numberQuestion",
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                  NormalButton(
                      onTap: () {
                        if (numberQuestion < 30) {
                          setState(() {
                            numberQuestion++;
                          });
                        }
                      },
                      child: const Icon(Icons.add))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "Penalità:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Switch.adaptive(
                      value: penalty,
                      onChanged: (value) {
                        setState(() {
                          penalty = value;
                        });
                      })
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 14,
              ),
              Center(
                child: PrimaryButton(
                  loading: loading,
                  onTap: () async {
                    if (uploadedFiles.isNotEmpty &&
                        selectedMateria != null &&
                        controller.text.isNotEmpty) {
                      try {
                        setState(() {
                          loading = true;
                        });
                        List<Question> questions = [];

                        //Faccio elaborare a Gemini 5 domande alla volta per gestire il limite di token per output
                        while (numberQuestion > 0) {
                          List? lista;
                          if (numberQuestion >= 5) {
                            lista = await GeminiProvider.elaboraPdf(
                                uploadedFiles[0], 5);
                            numberQuestion -= 5;
                          } else {
                            lista = await GeminiProvider.elaboraPdf(
                                uploadedFiles[0], numberQuestion);
                            numberQuestion = 0;
                          }
                          if (lista != null) {
                            questions.addAll(lista
                                .map((e) => Question.fromJson(e))
                                .toList());
                          }
                        }
                        if (questions.isEmpty) {
                          setState(() {
                            loading = false;
                          });

                          return;
                        }
                        Quiz quiz = Quiz(
                            title: controller.text,
                            questions: questions,
                            tag: selectedMateria!,
                            penalty: penalty);

                        Storage.saveQuiz(quiz);

                        Navigator.pop(context, true);
                        //Ritorna alla home e visualizza tutti i quiz
                      } catch (e) {
                        debugPrint(e.toString(), wrapWidth: 1024);
                      }
                    }
                  },
                  text: "CREA NUOVO QUIZ",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
