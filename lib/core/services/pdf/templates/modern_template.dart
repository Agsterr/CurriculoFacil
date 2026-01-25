import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../models/curriculo_model.dart';
import 'resume_template.dart';

class ModernTemplate implements ResumeTemplate {
  @override
  String get id => 'modern';

  @override
  String get name => 'Moderno';

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
          child: pw.Stack(
            children: [
              child,
              pw.Positioned(
                right: 0,
                top: 0,
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  decoration: const pw.BoxDecoration(color: PdfColors.orange, shape: pw.BoxShape.circle),
                  child: pw.Text('?', style: const pw.TextStyle(fontSize: 6, color: PdfColors.white)),
                ),
              ),
            ],
          ),
        );
      }
      return child;
    }
    
    // Define theme
    final theme = pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
    );

    // Load photo
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

    final primaryColor = PdfColor.fromInt(resume.style.primaryColor);
    final sidebarColor = primaryColor;
    final onSidebarColor = PdfColors.white;

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: theme,
          pageFormat: format,
          margin: pw.EdgeInsets.zero, // Full page for sidebar
        ),
        build: (context) {
          return [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Sidebar
                pw.Container(
                  width: format.availableWidth * 0.35,
                  constraints: pw.BoxConstraints(minHeight: format.availableHeight),
                  color: sidebarColor,
                  padding: const pw.EdgeInsets.all(20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      if (profileImage != null)
                        pw.Container(
                          width: 100,
                          height: 100,
                          margin: const pw.EdgeInsets.only(bottom: 20),
                          decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            image: pw.DecorationImage(
                              image: profileImage,
                              fit: pw.BoxFit.cover,
                            ),
                            border: pw.Border.all(color: onSidebarColor, width: 2),
                          ),
                        ),
                      
                      pw.Text(
                        resume.personalData.fullName,
                        style: pw.TextStyle(
                          color: onSidebarColor,
                          fontSize: 22,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                      
                      pw.Divider(color: onSidebarColor, thickness: 1, height: 40),
                      
                      // Contact
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _buildContactItem(resume.personalData.email, onSidebarColor, label: 'E-mail:'),
                            _buildContactItem(resume.personalData.phone, onSidebarColor, label: 'Telefone:'),
                            if (_formatAddress(resume.personalData).isNotEmpty)
                              _buildContactItem(_formatAddress(resume.personalData), onSidebarColor, label: 'Endereço:'),
                            if (resume.personalData.linkedinUrl != null)
                              _buildContactItem(resume.personalData.linkedinUrl!, onSidebarColor, label: 'LinkedIn:'),
                          ],
                        ),
                      ),
                      
                      pw.SizedBox(height: 30),
                      
                      // Skills
                      if (resume.skills.isNotEmpty) ...[
                        pw.Text(
                          'HABILIDADES',
                          style: pw.TextStyle(
                            color: onSidebarColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: resume.skills.map((skill) => 
                            wrapIfDraft(
                            pw.Container(
                              padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                borderRadius: pw.BorderRadius.circular(4),
                              ),
                              child: pw.Text(
                                skill.name,
                                style: pw.TextStyle(
                                  color: sidebarColor, 
                                  fontSize: 10, 
                                  fontWeight: pw.FontWeight.bold
                                ),
                              ),
                            ), skill.isConfirmed)
                          ).toList(),
                        ),
                      ],
                      
                      pw.SizedBox(height: 30),
                      
                      // Languages
                      if (resume.languages.isNotEmpty) ...[
                        pw.Text(
                          'IDIOMAS',
                          style: pw.TextStyle(
                            color: onSidebarColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                         pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: resume.languages.map((lang) => 
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 4),
                              child: pw.Text(
                                '${lang.name} - ${lang.proficiency.name}',
                                style: pw.TextStyle(color: onSidebarColor, fontSize: 10),
                              ),
                            )
                          ).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Main Content
                pw.Expanded(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(30),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (resume.professionalObjective.isNotEmpty) ...[
                          _buildSectionTitle('OBJETIVO', primaryColor),
                          pw.Text(
                            resume.professionalObjective,
                            style: const pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
                            textAlign: pw.TextAlign.justify,
                          ),
                          pw.SizedBox(height: 20),
                        ],
                        
                        if (resume.experiences.isNotEmpty) ...[
                          _buildSectionTitle('EXPERIÊNCIA PROFISSIONAL', primaryColor),
                          ...resume.experiences.map((e) => wrapIfDraft(_buildExperience(e), e.isConfirmed)),
                          pw.SizedBox(height: 10),
                        ],
                        
                        if (resume.education.isNotEmpty) ...[
                          _buildSectionTitle('FORMAÇÃO ACADÊMICA', primaryColor),
                          ...resume.education.map((e) => wrapIfDraft(_buildEducation(e), e.isConfirmed)),
                        ],
                      ],
                    ),
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

  pw.Widget _buildContactItem(String text, PdfColor color, {String? label}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (label != null)
            pw.Text(
              label,
              style: pw.TextStyle(color: color, fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
          pw.Text(
            text,
            style: pw.TextStyle(color: color, fontSize: 10),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildSectionTitle(String title, PdfColor color) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 15),
      padding: const pw.EdgeInsets.only(bottom: 5),
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: color, width: 2)),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  pw.Widget _buildExperience(Experience experience) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            experience.company,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                experience.role,
                style: pw.TextStyle(fontSize: 11, fontStyle: pw.FontStyle.italic),
              ),
              pw.Text(
                '${experience.startDate.year} - ${experience.isCurrent ? "Atual" : experience.endDate?.year ?? ""}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          ),
          if (experience.description != null)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 4),
              child: pw.Text(
                experience.description!,
                style: const pw.TextStyle(fontSize: 10, lineSpacing: 1.2),
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
          pw.Text(
            title,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                education.institution,
                style: pw.TextStyle(fontSize: 11, fontStyle: pw.FontStyle.italic),
              ),
              pw.Text(
                '${education.startDate.year} - ${education.isCurrent ? "Atual" : education.endDate?.year ?? ""}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAddress(PersonalData data) {
    final lines = <String>[];
    
    // Line 1: Street, Number - Neighborhood
    final line1Parts = <String>[];
    if (data.street != null && data.street!.isNotEmpty) line1Parts.add(data.street!);
    if (data.number != null && data.number!.isNotEmpty) line1Parts.add(data.number!);
    if (data.neighborhood != null && data.neighborhood!.isNotEmpty) line1Parts.add(data.neighborhood!);
    
    if (line1Parts.isNotEmpty) {
      // Custom join: "Rua X, 123 - Bairro"
      var l1 = line1Parts[0];
      if (line1Parts.length > 1) l1 += ', ${line1Parts[1]}';
      if (line1Parts.length > 2) l1 += ' - ${line1Parts[2]}';
      lines.add(l1);
    }

    // Line 2: City - State
    var cityState = '';
    if (data.city != null && data.city!.isNotEmpty) cityState += data.city!;
    if (data.state != null && data.state!.isNotEmpty) {
      if (cityState.isNotEmpty) cityState += ' - ';
      cityState += data.state!;
    }
    if (cityState.isNotEmpty) lines.add(cityState);

    // Line 3: ZIP
    if (data.zipCode != null && data.zipCode!.isNotEmpty) {
      lines.add('CEP: ${data.zipCode}');
    }

    // Fallback
    if (lines.isEmpty && data.address != null && data.address!.isNotEmpty) {
      return data.address!;
    }

    return lines.join('\n');
  }
}