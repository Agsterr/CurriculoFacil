import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openForm(context),
          ),
        ],
      ),
      body: educations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma formação adicionada',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _openForm(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Formação'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: educations.length,
              itemBuilder: (context, index) {
                final education = educations[index];
                return _EducationCard(
                  education: education,
                  onEdit: () => _openForm(context, education: education),
                  onDelete: () => _confirmDelete(context, ref, education.id),
                );
              },
            ),
    );
  }

  void _openForm(BuildContext context, {Education? education}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EducationFormPage(education: education),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Formação?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(currentCurriculoServiceProvider.notifier).removeEducation(id);
              Navigator.pop(context);
            },
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final Education education;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EducationCard({
    required this.education,
    required this.onEdit,
    required this.onDelete,
  });

  String _formatDate(DateTime date) => DateFormat('yyyy', 'pt_BR').format(date);

  @override
  Widget build(BuildContext context) {
    final period =
        '${_formatDate(education.startDate)} - ${education.isCurrent ? 'Cursando' : education.endDate != null ? _formatDate(education.endDate!) : 'Atual'}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(Icons.school,
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        title: Text(
          education.institution,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${education.degree}${education.fieldOfStudy != null ? ' em ${education.fieldOfStudy}' : ''}'),
            const SizedBox(height: 4),
            Text(period, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
