import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import '../../../../../models/curriculo_model.dart';

abstract class ResumeTemplate {
  String get id;
  String get name;
  Future<Uint8List> generate(Resume resume, PdfPageFormat format);
}
