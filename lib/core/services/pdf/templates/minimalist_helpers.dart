import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../models/curriculo_model.dart';

pw.Widget buildContactItem(String label, String? value) {
  if (value == null || value.isEmpty) return pw.Container();
  return pw.RichText(
    text: pw.TextSpan(
      children: [
        pw.TextSpan(
          text: '$label: ',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9, color: PdfColors.grey800),
        ),
        pw.TextSpan(
          text: value,
          style: pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
        ),
      ],
    ),
  );
}

String formatAddress(PersonalData data) {
  final lines = <String>[];
  
  // Line 1: Street, Number - Neighborhood
  final line1Parts = <String>[];
  if (data.street != null && data.street!.isNotEmpty) line1Parts.add(data.street!);
  if (data.number != null && data.number!.isNotEmpty) line1Parts.add(data.number!);
  if (data.neighborhood != null && data.neighborhood!.isNotEmpty) line1Parts.add(data.neighborhood!);
  
  if (line1Parts.isNotEmpty) {
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

  return lines.join(', '); // Join with comma for minimalist layout (linear)
}

pw.Widget buildSectionTitle(String title, PdfColor color) {
  return pw.Text(
    title,
    style: pw.TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: pw.FontWeight.bold,
      letterSpacing: 2,
    ),
  );
}

pw.Widget buildExperience(Experience experience, PdfColor secondaryColor) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 15),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 80,
          child: pw.Text(
            '${experience.startDate.year} — ${experience.isCurrent ? "Pres" : experience.endDate?.year ?? ""}',
            style: pw.TextStyle(fontSize: 10, color: secondaryColor, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(width: 20),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                experience.company.toUpperCase(),
                style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                experience.role,
                style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic),
              ),
              if (experience.description != null) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  experience.description!,
                  style: pw.TextStyle(fontSize: 10, lineSpacing: 1.4),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

pw.Widget buildEducation(Education education, PdfColor secondaryColor) {
  final title = education.fieldOfStudy != null && education.fieldOfStudy!.isNotEmpty
      ? '${education.fieldOfStudy} – ${education.degree}'
      : education.degree;

  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 10),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 80,
          child: pw.Text(
            '${education.startDate.year} — ${education.isCurrent ? "Pres" : education.endDate?.year ?? ""}',
            style: pw.TextStyle(fontSize: 10, color: secondaryColor, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(width: 20),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title.toUpperCase(),
                style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                education.institution,
                style: pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
