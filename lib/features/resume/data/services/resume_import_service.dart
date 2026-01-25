import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pdf_render_maintained/pdf_render_maintained.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart';
import '../../domain/entities/resume_draft.dart';
import '../../domain/entities/personal_data.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/education.dart';
import '../../domain/entities/skill.dart';

class ResumeImportService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<ResumeDraft> processFile(File file) async {
    InputImage inputImage;

    if (file.path.toLowerCase().endsWith('.pdf')) {
      final imagePath = await _convertPdfToImage(file);
      inputImage = InputImage.fromFilePath(imagePath);
    } else {
      inputImage = InputImage.fromFile(file);
    }

    final RecognizedText recognizedText =
        await _textRecognizer.processImage(inputImage);
    
    return _parseText(recognizedText);
  }

  Future<String> _convertPdfToImage(File pdfFile) async {
    final doc = await PdfDocument.openFile(pdfFile.path);
    // Render only the first page for MVP simplicity
    final page = await doc.getPage(1);
    final pageImage = await page.render(
      width: page.width.toInt() * 2, // 2x scale for better OCR
      height: page.height.toInt() * 2,
    );
    
    final tempDir = await getTemporaryDirectory();
    final imagePath = '${tempDir.path}/pdf_page_1.png';
    final imageFile = File(imagePath);
    
    // Convert raw pixels to PNG using 'image' package
    final img.Image image = img.Image.fromBytes(
      width: pageImage.width,
      height: pageImage.height,
      bytes: pageImage.pixels.buffer,
      order: img.ChannelOrder.rgba,
    );

    final pngBytes = img.encodePng(image);
    await imageFile.writeAsBytes(pngBytes);
    
    return imagePath;
  }

  ResumeDraft _parseText(RecognizedText text) {
    String fullText = text.text;
    List<String> lines = fullText.split('\n');

    // 1. Extract Personal Data
    String fullName = '';
    String email = '';
    String phone = '';
    String? address;

    // Heuristic: Name is usually at the top, possibly capitalized
    for (int i = 0; i < lines.length && i < 5; i++) {
      final line = lines[i].trim();
      if (line.isNotEmpty && !line.toLowerCase().contains('curriculum') && line.length > 3) {
        // Simple assumption: First significant line is the name
        if (fullName.isEmpty) {
          fullName = line;
        }
      }
    }

    // Regex for Email & Phone
    final emailRegex = RegExp(r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}');
    final phoneRegex = RegExp(r'(\(?\d{2}\)?\s?)?9?\d{4}-?\d{4}');

    final emailMatch = emailRegex.firstMatch(fullText);
    if (emailMatch != null) email = emailMatch.group(0) ?? '';

    final phoneMatch = phoneRegex.firstMatch(fullText);
    if (phoneMatch != null) phone = phoneMatch.group(0) ?? '';

    // 2. Extract Sections (Simplified)
    List<Experience> experiences = [];
    List<Education> education = [];
    List<Skill> skills = [];

    // Very basic keyword search to find blocks
    // In a real app, we would use block positions (Rect) from ML Kit
    
    if (fullText.toLowerCase().contains('experiência') || fullText.toLowerCase().contains('profissional')) {
       // Placeholder: Add a generic experience draft
       experiences.add(Experience(
         id: const Uuid().v4(),
         company: 'Empresa Detectada (Revisar)',
         role: 'Cargo Detectado (Revisar)',
         startDate: DateTime.now(),
         description: 'Texto extraído requer revisão manual.',
         isCurrent: false,
       ));
    }

    if (fullText.toLowerCase().contains('educação') || fullText.toLowerCase().contains('formação')) {
       education.add(Education(
         id: const Uuid().v4(),
         institution: 'Instituição (Revisar)',
         degree: 'Curso (Revisar)',
         startDate: DateTime.now(),
         isCurrent: false,
       ));
    }

    return ResumeDraft(
      personalData: PersonalData(
        fullName: fullName,
        email: email,
        phone: phone,
        address: address,
      ),
      experiences: experiences,
      education: education,
      skills: skills,
    );
  }
  
  void dispose() {
    _textRecognizer.close();
  }
}
