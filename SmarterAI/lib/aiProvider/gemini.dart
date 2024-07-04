import 'dart:convert';
import 'dart:io';
import 'package:SmarterAI/aiProvider/pdfconverter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProvider {
  static const String jsonMode =
      "Il tuo output deve essere in JSON, comincia direttamente con una parentesi quadra per indicare l'inizio della lista, con i caratteri d'escape necessari per evitare FormatExpection nel seguente formato:";
  static final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyBjcEwu8T_pcfVnsrOE5NzFKon-73eTFQk',
  );

  static Future<String> chat(String text,
      {bool jsonModeEnabled = false}) async {
    if (jsonModeEnabled) {
      text = jsonMode + text;
    }
    final content = [Content.text(text)];
    final response = await model.generateContent(content);
    return response.text ?? "";
  }

  static Future<List?> elaboraPdf(
      int number, String text, List<PlatformFile>? files) async {
    List<Uint8List> imagesGemini = [];
    if ((files ?? []).isNotEmpty) {
      File pdfFile = File(files![0].path!);
      List<File> images = await convertPdfToImage(pdfFile);

      for (File imageFile in images) {
        imagesGemini.add(imageFile.readAsBytesSync());
      }
      if (imagesGemini.length > 16) {
        imagesGemini = imagesGemini.sublist(0, 15);
      }
    }
    try {
      var prompt =
          '''Analizza il contenuto di eventuali immagini caricate e genera delle domande che mi aiutino a ripassare.
Sei un professore universitario, genera $number domande a risposta multipla sull'argomento $text  con una sola risposta corretta,
 le altre risposte devono essere SBAGLIATE rispetto alla domanda. 
 Il tuo output deve essere in JSON, comincia direttamente con una parentesi quadra per 
 indicare l'inizio della lista, con i caratteri d'escape necessari per evitare FormatExpection 
 nel seguente formato: [{ "question": "la tua domanda elaborata", "answers": "["risposta1", "risposta2", ...], "correct": intero che indica l'indice della risposta corretta,  "explanation": "spiegazione del perchè"},...]
                  ''';
      final contentPrompt = TextPart(prompt);

      final dataPrompt = [
        for (Uint8List u8 in imagesGemini ?? []) DataPart("image/jpeg", u8)
      ];
      final value = await model.generateContent([
        Content.multi([contentPrompt, ...dataPrompt])
      ],
          generationConfig:
              GenerationConfig(maxOutputTokens: 4000, temperature: 0.2));

      debugPrint(value.text!);
      return jsonDecode(value.text!);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
