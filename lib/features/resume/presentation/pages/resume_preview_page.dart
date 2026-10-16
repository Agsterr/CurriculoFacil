import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../../core/services/pdf/pdf_generator_service.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';
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
        body: const EmptyState(
          icon: Icons.visibility_off_outlined,
          title: 'Nada para visualizar',
          message: 'Nenhum currículo selecionado para visualização.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pré-visualização'),
        actions: [
          IconButton(
            tooltip: 'Personalizar',
            icon: const Icon(Icons.tune),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCustomizationSheet(context),
        icon: const Icon(Icons.palette_outlined),
        label: const Text('Personalizar'),
      ),
    );
  }

  void _showCustomizationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ResumeCustomizationSheet(),
    );
  }
}
