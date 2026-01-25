import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../models/curriculo_model.dart';
import 'resume_template.dart';

class ClassicTemplate implements ResumeTemplate {
  @override
  String get id => 'classic';

  @override
  String get name => 'Clássico';

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
    
    // Load photo (Optional in classic, but supported)
    pw.MemoryImage? profileImage;
    if (resume.style.showPhoto && resume.personalData.photoPath != null) {
      final file = File(resume.personalData.photoPath!);
      if (await file.exists()) {
        try {
          profileImage = pw.MemoryImage(await file.readAsBytes());
        } catch (e) {
          // Ignore error loading image
        }
      }
    }

    final theme = pw.ThemeData.withFont(
      base: pw.Font.times(),
      bold: pw.Font.timesBold(),
      italic: pw.Font.timesItalic(),
    );
    
    // Classic implies dark text, usually black or dark grey. 
    // We use primaryColor for titles/dividers only.
    final primaryColor = PdfColor.fromInt(resume.style.primaryColor);
    final contentColor = PdfColors.black;

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: theme,
          pageFormat: format,
          margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        ),
        build: (context) {
          return [
             // Header Section
             pw.Column(
               crossAxisAlignment: pw.CrossAxisAlignment.center,
               children: [
                 if (profileImage != null)
                   pw.Container(
                     width: 80,
                     height: 80,
                     margin: const pw.EdgeInsets.only(bottom: 10),
                     decoration: pw.BoxDecoration(
                       shape: pw.BoxShape.rectangle,
                       border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
                       image: pw.DecorationImage(image: profileImage, fit: pw.BoxFit.cover),
                     ),
                   ),
                 
                 pw.Text(
                   resume.personalData.fullName.toUpperCase(),
                   style: pw.TextStyle(
                     fontSize: 20,
                     fontWeight: pw.FontWeight.bold,
                     color: contentColor,
                     letterSpacing: 1.0,
                   ),
                   textAlign: pw.TextAlign.center,
                 ),
                 
                 pw.SizedBox(height: 8),
                 
                 // Contacts Line 1
                 pw.Wrap(
                   spacing: 12,
                   runSpacing: 4,
                   alignment: pw.WrapAlignment.center,
                   children: [
                     _buildContactItem('E-mail', resume.personalData.email),
                     _buildContactItem('Telefone', resume.personalData.phone),
                     if (resume.personalData.linkedinUrl != null)
                       _buildContactItem('LinkedIn', resume.personalData.linkedinUrl),
                   ],
                 ),
                 
                 // Address Line
                 if (_formatAddress(resume.personalData).isNotEmpty) ...[
                   pw.SizedBox(height: 4),
                   _buildContactItem('Endereço', _formatAddress(resume.personalData), centered: true),
                 ],
               ],
             ),

             pw.SizedBox(height: 20),
             pw.Divider(thickness: 1, color: primaryColor),
             pw.SizedBox(height: 20),

             // Professional Objective
             if (resume.professionalObjective.isNotEmpty) ...[
               _buildSectionTitle('Objetivo Profissional', primaryColor),
               pw.Text(
                 resume.professionalObjective, 
                 style: pw.TextStyle(fontSize: 11, lineSpacing: 1.5, color: contentColor),
                 textAlign: pw.TextAlign.justify,
               ),
               pw.SizedBox(height: 20),
             ],

             // Experience
             if (resume.experiences.isNotEmpty) ...[
               _buildSectionTitle('Experiência Profissional', primaryColor),
               ...resume.experiences.map((e) => wrapIfDraft(_buildExperience(e), e.isConfirmed)),
               pw.SizedBox(height: 10),
             ],

             // Education
             if (resume.education.isNotEmpty) ...[
               _buildSectionTitle('Formação Acadêmica', primaryColor),
               ...resume.education.map((e) => wrapIfDraft(_buildEducation(e), e.isConfirmed)),
               pw.SizedBox(height: 10),
             ],
             
             // Skills
             if (resume.skills.isNotEmpty) ...[
                _buildSectionTitle('Habilidades', primaryColor),
                pw.Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: resume.skills.map((s) => wrapIfDraft(
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey400),
                        borderRadius: pw.BorderRadius.circular(2),
                      ),
                      child: pw.Text(s.name, style: const pw.TextStyle(fontSize: 10)),
                    ), s.isConfirmed
                  )).toList(),
                ),
                pw.SizedBox(height: 20),
             ],
             
             // Languages
             if (resume.languages.isNotEmpty) ...[
                _buildSectionTitle('Idiomas', primaryColor),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: resume.languages.map((l) => wrapIfDraft(
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Row(
                        children: [
                          pw.Container(width: 4, height: 4, decoration: const pw.BoxDecoration(color: PdfColors.black, shape: pw.BoxShape.circle)),
                          pw.SizedBox(width: 6),
                          pw.Text('${l.name}: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                          pw.Text(l.proficiency.name, style: const pw.TextStyle(fontSize: 11)),
                        ],
                      )
                    ), l.isConfirmed
                  )).toList(),
                ),
             ]
          ];
        },
      ),
    );

    return pdf.save();
  }
  
  pw.Widget _buildContactItem(String label, String? value, {bool centered = false}) {
    if (value == null || value.isEmpty) return pw.Container();
    return pw.RichText(
      textAlign: centered ? pw.TextAlign.center : pw.TextAlign.left,
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '$label: ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, color: PdfColors.black),
          ),
          pw.TextSpan(
            text: value,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey800),
          ),
        ],
      ),
    );
  }

  String _formatAddress(PersonalData data) {
    final parts = <String>[];
    
    if (data.street != null && data.street!.isNotEmpty) {
      var streetPart = data.street!;
      if (data.number != null && data.number!.isNotEmpty) {
        streetPart += ', ${data.number}';
      }
      parts.add(streetPart);
    }
    
    if (data.neighborhood != null && data.neighborhood!.isNotEmpty) {
       parts.add(data.neighborhood!);
    }
    
    var cityState = '';
    if (data.city != null && data.city!.isNotEmpty) {
      cityState += data.city!;
    }
    if (data.state != null && data.state!.isNotEmpty) {
      if (cityState.isNotEmpty) cityState += ' - ';
      cityState += data.state!;
    }
    if (cityState.isNotEmpty) parts.add(cityState);
    
    if (data.zipCode != null && data.zipCode!.isNotEmpty) {
      parts.add('CEP: ${data.zipCode}');
    }
    
    if (parts.isEmpty && data.address != null && data.address!.isNotEmpty) {
      return data.address!;
    }
    
    return parts.join(', ');
  }

  pw.Widget _buildSectionTitle(String title, PdfColor color) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 15),
      padding: const pw.EdgeInsets.only(bottom: 4),
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(width: 1, color: color)),
      ),
      width: double.infinity,
      child: pw.Text(
        title.toUpperCase(),
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12, color: color, letterSpacing: 1.2),
      ),
    );
  }
  
  pw.Widget _buildExperience(Experience experience) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Expanded(
                child: pw.Text(
                  experience.company.toUpperCase(),
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
                ),
              ),
              pw.Text(
                '${experience.startDate.year} - ${experience.isCurrent ? "Atual" : experience.endDate?.year ?? ""}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            experience.role,
            style: pw.TextStyle(fontSize: 11, fontStyle: pw.FontStyle.italic, color: PdfColors.black),
          ),
          if (experience.description != null)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 4),
              child: pw.Text(
                experience.description!,
                style: const pw.TextStyle(fontSize: 11, lineSpacing: 1.4),
                textAlign: pw.TextAlign.justify,
              ),
            ),
        ],
      ),
    );
  }
  
  pw.Widget _buildEducation(Education education) {
    final title = education.fieldOfStudy != null && education.fieldOfStudy!.isNotEmpty
        ? '${education.fieldOfStudy} – ${education.degree}'
        : education.degree;

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Expanded(
                child: pw.Text(
                  title.toUpperCase(),
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
                ),
              ),
              pw.Text(
                '${education.startDate.year} - ${education.isCurrent ? "Atual" : education.endDate?.year ?? ""}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            education.institution,
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}