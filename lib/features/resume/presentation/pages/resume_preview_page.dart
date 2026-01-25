import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../../core/services/pdf/pdf_generator_service.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../models/curriculo_model.dart';
import '../widgets/resume_customization_sheet.dart';

final draftModeProvider = StateProvider<bool>((ref) => false);

class ResumePreviewPage extends ConsumerWidget {
  const ResumePreviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(currentCurriculoServiceProvider);
    final pdfService = PdfGeneratorService();

    if (resume == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pré-visualização'),
        ),
        body: const Center(
          child: Text('Nenhum currículo selecionado para visualização.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pré-visualização'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showCustomizationSheet(context);
            },
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) => pdfService.generate(resume, format: format),
        canChangeOrientation: false,
        canChangePageFormat: false, // Keep it standard for now
        allowPrinting: true,
        allowSharing: true,
        loadingWidget: const Center(child: CircularProgressIndicator()),
        pdfFileName: 'curriculo.pdf',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCustomizationSheet(context),
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _showCustomizationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ResumeCustomizationSheet(),
    );
  }
}

