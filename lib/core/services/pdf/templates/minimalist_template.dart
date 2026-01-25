import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../models/curriculo_model.dart';
import 'resume_template.dart';
import 'minimalist_helpers.dart';

class MinimalistTemplate implements ResumeTemplate {
  @override
  String get id => 'minimalist';

  @override
  String get name => 'Minimalista';

  @override
  Future<Uint8List> generate(Resume resume, PdfPageFormat format, {bool showDraftIndications = false}) async {
    final pdf = pw.Document();

    // Helper to highlight unconfirmed fields
    pw.Widget wrapIfDraft(pw.Widget child, bool isConfirmed) {
      if (showDraftIndications && !isConfirmed) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.yellow100,
            border: pw.Border.all(color: PdfColors.orange, width: 1),
            borderRadius: pw.BorderRadius.circular(4),
          ),
          padding: const pw.EdgeInsets.all(4),
          margin: const pw.EdgeInsets.only(bottom: 4),
          child: child,
        );
      }
      return child;
    }

    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
    );

    final primaryColor = PdfColor.fromInt(resume.style.primaryColor);
    final secondaryColor = PdfColor.fromInt(resume.style.secondaryColor);

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: theme,
          pageFormat: format,
          margin: const pw.EdgeInsets.all(40),
          buildBackground: (context) {
             if (resume.style.frameType == 'box') {
               return pw.Container(
                 decoration: pw.BoxDecoration(
                   border: pw.Border.all(color: primaryColor, width: 2),
                 ),
               );
             }
             if (resume.style.frameType == 'side') {
                return pw.Row(
                  children: [
                    pw.Container(
                      width: 10,
                      color: primaryColor,
                    ),
                    pw.Expanded(child: pw.Container()),
                  ],
                );
             }
             if (resume.style.frameType == 'top_line') {
                return pw.Column(
                  children: [
                    pw.Container(
                      height: 10,
                      color: primaryColor,
                    ),
                    pw.Expanded(child: pw.Container()),
                  ],
                );
             }
             return pw.Container();
          },
        ),
        build: (context) {
          return [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
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
                          letterSpacing: 2,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      
                      // Contacts with labels
                      pw.Wrap(
                        spacing: 15,
                        runSpacing: 4,
                        children: [
                          buildContactItem('E-mail', resume.personalData.email),
                          buildContactItem('Telefone', resume.personalData.phone),
                          if (resume.personalData.linkedinUrl != null)
                             buildContactItem('LinkedIn', resume.personalData.linkedinUrl),
                        ],
                      ),
                      
                      if (formatAddress(resume.personalData).isNotEmpty) ...[
                        pw.SizedBox(height: 4),
                        buildContactItem('Endereço', formatAddress(resume.personalData)),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            
            pw.SizedBox(height: 30),

            // Objective
            if (resume.professionalObjective.isNotEmpty) ...[
              pw.Text(
                resume.professionalObjective,
                style: pw.TextStyle(fontSize: 11, lineSpacing: 1.5),
              ),
              pw.SizedBox(height: 30),
            ],

            // Experience
            if (resume.experiences.isNotEmpty) ...[
              buildSectionTitle('EXPERIÊNCIA', primaryColor),
              pw.SizedBox(height: 10),
              ...resume.experiences.map((e) => wrapIfDraft(buildExperience(e, secondaryColor), e.isConfirmed)),
              pw.SizedBox(height: 20),
            ],

            // Education
            if (resume.education.isNotEmpty) ...[
              buildSectionTitle('EDUCAÇÃO', primaryColor),
              pw.SizedBox(height: 10),
              ...resume.education.map((e) => wrapIfDraft(buildEducation(e, secondaryColor), e.isConfirmed)),
              pw.SizedBox(height: 20),
            ],
            
            // Skills & Languages (Side by side if space permits, or simpler list)
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (resume.skills.isNotEmpty) 
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        buildSectionTitle('SKILLS', primaryColor),
                        pw.SizedBox(height: 10),
                        pw.Wrap(
                          spacing: 10,
                          runSpacing: 5,
                          children: resume.skills.map((s) => wrapIfDraft(pw.Text(s.name, style: pw.TextStyle(fontSize: 10)), s.isConfirmed)).toList(),
                        ),
                      ],
                    ),
                  ),
                  
                if (resume.skills.isNotEmpty && resume.languages.isNotEmpty)
                  pw.SizedBox(width: 40),
                  
                if (resume.languages.isNotEmpty)
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        buildSectionTitle('IDIOMAS', primaryColor),
                        pw.SizedBox(height: 10),
                         pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: resume.languages.map((l) => wrapIfDraft(pw.Text('${l.name} (${l.proficiency.name})', style: pw.TextStyle(fontSize: 10)), l.isConfirmed)).toList(),
                        ),
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
}
