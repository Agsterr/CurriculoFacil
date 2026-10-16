import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';
import '../../../../shared/widgets/entry_card.dart';
import 'education_form_page.dart';

class EducationListPage extends ConsumerWidget {
  const EducationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(currentCurriculoServiceProvider);
    final educations = resume?.education ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formação Acadêmica'),
      ),
      body: educations.isEmpty
          ? EmptyState(
              icon: Icons.school_outlined,
              title: 'Nenhuma formação ainda',
              message:
                  'Inclua ensino médio, técnico, graduação, pós ou cursos relevantes.',
              actionLabel: 'Adicionar Formação',
              onAction: () => _openForm(context),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 104),
              itemCount: educations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final education = educations[index];
                final field = education.fieldOfStudy;
                return EntryCard(
                  key: ValueKey(education.id),
                  icon: Icons.school_outlined,
                  color: const Color(0xFF2E7D32),
                  title: education.institution,
                  subtitle: field != null && field.isNotEmpty
                      ? '${education.degree} em $field'
                      : education.degree,
                  period: _period(education),
                  needsReview: !education.isConfirmed,
                  onEdit: () => _openForm(context, education: education),
                  onDelete: () => _confirmDelete(context, ref, education.id),
                );
              },
            ),
      floatingActionButton: educations.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _openForm(context),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar'),
            ),
    );
  }

  String _period(Education education) {
    String format(DateTime date) => DateFormat('yyyy', 'pt_BR').format(date);
    final end = education.isCurrent
        ? 'Cursando'
        : education.endDate != null
            ? format(education.endDate!)
            : 'Atual';
    return '${format(education.startDate)} – $end';
  }

  void _openForm(BuildContext context, {Education? education}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EducationFormPage(education: education),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, String id) async {
    if (await confirmDestructive(context,
        title: 'Remover formação?', confirmLabel: 'Remover')) {
      ref.read(currentCurriculoServiceProvider.notifier).removeEducation(id);
    }
  }
}
