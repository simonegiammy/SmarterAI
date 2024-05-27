import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:SmarterAI/aiProvider/pdfconverter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiProvider {
  static final String jsonMode = "Il tuo output deve essere in JSON, comincia direttamente con una parentesi quadra per indicare l'inizio della lista, con i caratteri d'escape necessari per evitare FormatExpection nel seguente formato:";

  static final gemini = Gemini.instance;
  static void setup() {
    Gemini.init(apiKey: 'AIzaSyBjcEwu8T_pcfVnsrOE5NzFKon-73eTFQk');
  }

  static Future<String> chat(String text, {bool jsonModeEnabled = false}) async {
    if (jsonModeEnabled){
      text = jsonMode + text;
    }
    String? rit = (await gemini.text(text))!.output;

    return rit ?? "";
  }

  static Future<List?> elaboraPdf(int number, String text) async {
    /*File pdfFile = File(file?.path!);
    List<File> images = await convertPdfToImage(pdfFile);
    List<Uint8List> imagesGemini = [];
    for (File imageFile in images) {
      imagesGemini.add(imageFile.readAsBytesSync());
    }
    if (imagesGemini.length > 16) {
      imagesGemini = imagesGemini.sublist(0, 15);
    }*/
    try {
      var value = await gemini.text(
      
              """ Sei un professore universitario, genera $number domande a risposta multipla sull'argomento $text  con una sola risposta corretta, le altre risposte devono essere SBAGLIATE rispetto alla domanda. Il tuo output deve essere in JSON, comincia direttamente con una parentesi quadra per indicare l'inizio della lista, con i caratteri d'escape necessari per evitare FormatExpection nel seguente formato:
                  [{ "question": "la tua domanda elaborata", "answers": "["risposta1", "risposta2", ...], "correct": intero che indica l'indice della risposta corretta,  "explanation": "spiegazione del perchè"},...]
                  """,

          /// text
          //images: imagesGemini

          /// list of images
          );
      if (value != null) {
        debugPrint(value.output!);
        return jsonDecode(value.output!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
