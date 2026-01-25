import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../entities/resume.dart';

class PdfService {
  Future<Uint8List> generateResume(Resume resume) async {
    final pdf = pw.Document();

    // Carregar imagem de perfil se existir
    pw.MemoryImage? profileImage;
    if (resume.personalData.photoPath != null) {
      final file = File(resume.personalData.photoPath!);
      if (await file.exists()) {
        final imageBytes = await file.readAsBytes();
        profileImage = pw.MemoryImage(imageBytes);
      }
    }

    // Definição de Cores e Estilos
    final PdfColor primaryColor = PdfColors.blueGrey900;
    final PdfColor accentColor = PdfColors.blueGrey700;
    final PdfColor lightText = PdfColors.white;

    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: theme,
          margin: const pw.EdgeInsets.all(40),
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(
              // Opcional: Adicionar marca d'água ou fundo
            ),
          ),
        ),
        build: (pw.Context context) {
          return [
            // Header
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (profileImage != null)
                  pw.Container(
                    width: 100,
                    height: 100,
                    margin: const pw.EdgeInsets.only(right: 20),
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      image: pw.DecorationImage(
                        image: profileImage,
                        fit: pw.BoxFit.cover,
                      ),
                    ),
                  ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        resume.personalData.fullName.toUpperCase(),
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        resume.title,
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: accentColor,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Wrap(
                        spacing: 10,
                        runSpacing: 5,
                        children: [
                          _buildContactInfo(
                              resume.personalData.email, false),
                          _buildContactInfo(
                              resume.personalData.phone, false),
                          if (resume.personalData.linkedinUrl != null)
                            _buildContactInfo(
                                resume.personalData.linkedinUrl!, true),
                        ],
                      ),
                      if (resume.personalData.address != null)
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 5),
                          child: pw.Text(
                            resume.personalData.address!,
                            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            pw.Divider(color: PdfColors.grey400, thickness: 1, height: 40),

            // Professional Objective
            if (resume.professionalObjective.isNotEmpty) ...[
              _buildSectionTitle('Objetivo Profissional'),
              pw.Text(
                resume.professionalObjective,
                style: pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 20),
            ],

            // Experience
            if (resume.experiences.isNotEmpty) ...[
              _buildSectionTitle('Experiência Profissional'),
              ...resume.experiences.map((exp) {
                final dateFormat = DateFormat('MM/yyyy');
                final start = dateFormat.format(exp.startDate);
                final end = exp.endDate != null
                    ? dateFormat.format(exp.endDate!)
                    : 'Atual';
                
                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 15),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            exp.role,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          pw.Text(
                            '$start - $end',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      pw.Text(
                        exp.company,
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: accentColor,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        exp.description,
                        style: pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
                        textAlign: pw.TextAlign.justify,
                      ),
                    ],
                  ),
                );
              }).toList(),
              pw.SizedBox(height: 10),
            ],

            // Education
            if (resume.education.isNotEmpty) ...[
              _buildSectionTitle('Formação Acadêmica'),
              ...resume.education.map((edu) {
                 final dateFormat = DateFormat('MM/yyyy');
                final start = dateFormat.format(edu.startDate);
                final end = edu.endDate != null
                    ? dateFormat.format(edu.endDate!)
                    : 'Em andamento';

                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              edu.degree,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            pw.Text(
                              edu.institution,
                              style: pw.TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      pw.Text(
                        '$start - $end',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              pw.SizedBox(height: 20),
            ],

            // Skills & Languages (Side by Side if possible, or stacked)
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (resume.skills.isNotEmpty)
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Habilidades'),
                        pw.Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: resume.skills.map((skill) {
                            return pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.grey200,
                                borderRadius: pw.BorderRadius.circular(4),
                              ),
                              child: pw.Text(
                                skill.name, // Assuming Skill has a name property
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                if (resume.skills.isNotEmpty && resume.languages.isNotEmpty)
                  pw.SizedBox(width: 20),
                if (resume.languages.isNotEmpty)
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Idiomas'),
                        ...resume.languages.map((lang) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 4),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  lang.name, // Assuming Language has a name property
                                  style: pw.TextStyle(fontSize: 12),
                                ),
                                pw.Text(
                                  lang.proficiency.name.toUpperCase(),
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColors.grey700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
              ],
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildSectionTitle(String title) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      padding: const pw.EdgeInsets.only(bottom: 5),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.blueGrey900, width: 1),
        ),
      ),
      width: double.infinity,
      child: pw.Text(
        title.toUpperCase(),
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blueGrey900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  pw.Widget _buildContactInfo(String text, bool isLink) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 10,
        color: isLink ? PdfColors.blue : PdfColors.black,
        decoration: isLink ? pw.TextDecoration.underline : null,
      ),
    );
  }
}
