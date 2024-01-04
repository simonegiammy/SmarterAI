import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_example/aiProvider/pdfconverter.dart';

class GeminiProvider {
  static final gemini = Gemini.instance;
  static void setup() {
    Gemini.init(apiKey: 'AIzaSyBjcEwu8T_pcfVnsrOE5NzFKon-73eTFQk');
  }

  static void chat(String text) {
    gemini.text(text).then((value) => print(value?.output));
  }

  static Future<List?> elaboraPdf(PlatformFile file) async {
    File pdfFile = File(file.path!);
    List<File> images = await convertPdfToImage(pdfFile);
    List<Uint8List> imagesGemini = [];
    for (File imageFile in images) {
      imagesGemini.add(imageFile.readAsBytesSync());
    }

    String output = (await gemini.textAndImage(
            text:
                """Elabora questo file e genera 2 domande a risposta multipla con una sola risposta corretta. Il tuo output deve essere in JSON con i caratteri d'escape necessari nel seguente formato:
                  [{ "question": "la tua domanda elaborata", "answers": "["domanda1", "domanda2", ...], "correct": intero che indica l'indice della domanda corretta,  "explanation": "spiegazione del perchè"},...]
                
                  """,

            /// text
            images: imagesGemini.sublist(0, 15)

            /// list of images
            ))!
        .output!;
    return jsonDecode(output);
  }
}
