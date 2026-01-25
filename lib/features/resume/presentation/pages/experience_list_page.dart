import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
              );
            },
          ),
        ],
      ),
      body: experiences.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_off_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma experiência adicionada',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ExperienceFormPage()),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Experiência'),
                  ),
                ],
              ),
            )
          : ReorderableListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: experiences.length,
              onReorder: (oldIndex, newIndex) {
                // TODO: Implement reorder in service if needed
              },
              itemBuilder: (context, index) {
                final experience = experiences[index];
                return _ExperienceCard(
                  key: ValueKey(experience.id),
                  experience: experience,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ExperienceFormPage(experience: experience),
                      ),
                    );
                  },
                  onDelete: () {
                    _confirmDelete(context, ref, experience.id);
                  },
                );
              },
            ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Experiência?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(currentCurriculoServiceProvider.notifier).removeExperience(id);
              Navigator.pop(context);
            },
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ExperienceCard({
    required Key key,
    required this.experience,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat('MMM yyyy', 'pt_BR').format(date); // Ex: Jan 2023
  }

  @override
  Widget build(BuildContext context) {
    final period =
        '${_formatDate(experience.startDate)} - ${experience.isCurrent ? 'Atual' : experience.endDate != null ? _formatDate(experience.endDate!) : 'Atual'}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      color: experience.isConfirmed ? null : Colors.orange.shade50,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: experience.isConfirmed 
              ? Theme.of(context).colorScheme.primaryContainer 
              : Colors.orange.shade100,
          child: Icon(
            Icons.business,
            color: experience.isConfirmed 
                ? Theme.of(context).colorScheme.onPrimaryContainer 
                : Colors.orange.shade800,
          ),
        ),
        title: Text(
          experience.role,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!experience.isConfirmed)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 16, color: Colors.orange.shade800),
                    const SizedBox(width: 4),
                    Text(
                      'Revisão Necessária',
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 4),
            Text(experience.company,
                style: const TextStyle(fontWeight: FontWeight.w500)),
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
              tooltip: 'Editar',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
              tooltip: 'Remover',
            ),
            const Icon(Icons.drag_handle, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
