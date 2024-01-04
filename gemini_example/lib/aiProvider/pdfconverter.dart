import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

Future<List<File>> convertPdfToImage(File pdfFile) async {
  List<File> imageFiles = [];

  // Carica il documento PDF
  final document = await PdfDocument.openFile(pdfFile.path);

  // Ottieni il numero di pagine
  final pageCount = document.pagesCount;

  for (int i = 1; i <= 16; i++) {
    //Gemini non accetta più di 16 immagini
    // Ottieni la pagina
    final page = await document.getPage(i);
    // Renderizza l'immagine della pagina
    final pageImage =
        await page.render(width: page.width, height: page.height, quality: 40);
    await page.close();

    // Ottieni il percorso della directory temporanea
    final directory = await getTemporaryDirectory();
    // Crea un file per l'immagine JPEG
    final imagePath = '${directory.path}/page_$i.jpeg';
    final imageFile = File(imagePath);

    // Salva l'immagine nel file
    final file = await imageFile.writeAsBytes(pageImage!.bytes);

    // Aggiungi il file immagine alla lista
    imageFiles.add(file);
    // Aggiungi il file immagine alla lista
  }

  return imageFiles;
}