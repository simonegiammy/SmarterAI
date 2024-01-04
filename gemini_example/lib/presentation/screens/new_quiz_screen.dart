import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gemini_example/aiProvider/gemini.dart';
import 'package:gemini_example/constants.dart';
import 'package:gemini_example/presentation/widgets/add_new_button.dart';
import 'package:gemini_example/presentation/widgets/file_tile.dart';
import 'package:gemini_example/presentation/widgets/primary_button.dart';
import 'package:gemini_example/presentation/widgets/textfield.dart';
import 'package:gemini_example/presentation/widgets/tile.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 72, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CREA UN NUOVO QUIZ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Seleziona la materia:",
                style: Theme.of(context).textTheme.bodyLarge,
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
                height: 14,
              ),
              Text(
                "Inserisci gli argomenti: ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              GeminiTextField(controller: controller),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Inserisci i file da cui vuoi ripassare: ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              for (PlatformFile file in uploadedFiles)
                FileTile(nomeFile: file.name),
              AddNewButton(onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'png', 'jpg'],
                    allowMultiple: true);

                setState(() {
                  uploadedFiles = result?.files ?? [];
                });
              }),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Numero di domande: ",
                style: Theme.of(context).textTheme.bodyLarge,
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
                      child: Text("$numberQuestion")),
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
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Penalità:",
                    style: Theme.of(context).textTheme.bodyLarge,
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
              Center(
                child: PrimaryButton(
                  onTap: () async {
                    if (uploadedFiles.isNotEmpty) {
                      print("elaboro file");
                      try {
                        List? lista =
                            await GeminiProvider.elaboraPdf(uploadedFiles[0]);

                        // print(rit);
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      print("elaboro chat");

                      GeminiProvider.chat(controller.text);
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
