import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import '../../../../models/curriculo_model.dart';
import 'templates/resume_template.dart';
import 'templates/modern_template.dart';
import 'templates/classic_template.dart';
import 'templates/minimalist_template.dart';

class PdfGeneratorService {
  final Map<String, ResumeTemplate> _templates = {
    'modern': ModernTemplate(),
    'classic': ClassicTemplate(),
    'minimalist': MinimalistTemplate(),
  };

  List<ResumeTemplate> getAvailableTemplates() {
    return _templates.values.toList();
  }

  Future<Uint8List> generate(Resume resume, {PdfPageFormat format = PdfPageFormat.a4}) async {
    final templateId = resume.style.templateId;
    final template = _templates[templateId] ?? _templates['modern']!;
    return template.generate(resume, format);
  }
}
