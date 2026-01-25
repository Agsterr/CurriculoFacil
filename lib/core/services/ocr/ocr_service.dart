import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class OCRService {
  Future<String> recognizeText(String imagePath);
  Future<void> dispose();
}

class OCRServiceImpl implements OCRService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  @override
  Future<String> recognizeText(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      throw Exception('Falha ao reconhecer texto: $e');
    }
  }

  @override
  Future<void> dispose() async {
    await _textRecognizer.close();
  }
}
