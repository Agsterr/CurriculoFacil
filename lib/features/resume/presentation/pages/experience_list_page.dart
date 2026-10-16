import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';
import '../../../../shared/widgets/entry_card.dart';
import 'experience_form_page.dart';

class ExperienceListPage extends ConsumerWidget {
  const ExperienceListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(currentCurriculoServiceProvider);
    final experiences = resume?.experiences ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiência Profissional'),
      ),
      body: experiences.isEmpty
          ? EmptyState(
              icon: Icons.work_outline,
              title: 'Nenhuma experiência ainda',
              message:
                  'Adicione empregos, estágios ou trabalhos voluntários, começando pelo mais recente.',
              actionLabel: 'Adicionar Experiência',
              onAction: () => _openForm(context),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 104),
              itemCount: experiences.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final experience = experiences[index];
                return EntryCard(
                  key: ValueKey(experience.id),
                  icon: Icons.business_outlined,
                  color: const Color(0xFFF57C00),
                  title: experience.role,
                  subtitle: experience.company,
                  period: _period(experience),
                  description: experience.description,
                  needsReview: !experience.isConfirmed,
                  onEdit: () => _openForm(context, experience: experience),
                  onDelete: () => _confirmDelete(context, ref, experience.id),
                );
              },
            ),
      floatingActionButton: experiences.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _openForm(context),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar'),
            ),
    );
  }

  String _period(Experience experience) {
    String format(DateTime date) =>
        DateFormat('MMM yyyy', 'pt_BR').format(date);
    final end = experience.isCurrent || experience.endDate == null
        ? 'Atual'
        : format(experience.endDate!);
    return '${format(experience.startDate)} – $end';
  }

  void _openForm(BuildContext context, {Experience? experience}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExperienceFormPage(experience: experience),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, String id) async {
    if (await confirmDestructive(context,
        title: 'Remover experiência?', confirmLabel: 'Remover')) {
      ref.read(currentCurriculoServiceProvider.notifier).removeExperience(id);
    }
  }
}
