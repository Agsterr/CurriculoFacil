import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';

class ResumeListPage extends ConsumerWidget {
  const ResumeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeListAsync = ref.watch(curriculoListServiceProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: resumeListAsync.when(
        data: (resumes) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar.large(
                title: Text('Meus Currículos'),
                centerTitle: false,
              ),
              if (resumes.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyState(
                    icon: Icons.description_outlined,
                    title: 'Crie seu primeiro currículo',
                    message:
                        'Em poucos passos você monta um currículo profissional pronto para enviar em PDF.',
                    actionLabel: 'Criar Currículo',
                    onAction: () => _createNewResume(context, ref),
                  ),
                )
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      resumes.length == 1
                          ? '1 currículo salvo'
                          : '${resumes.length} currículos salvos',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 104),
                  sliver: SliverList.separated(
                    itemCount: resumes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final resume = resumes[index];
                      return Dismissible(
                        key: Key(resume.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(Icons.delete_outline,
                              color: theme.colorScheme.onError),
                        ),
                        confirmDismiss: (_) => _confirmDelete(context),
                        onDismissed: (_) {
                          ref
                              .read(curriculoListServiceProvider.notifier)
                              .deleteResume(resume.id);
                        },
                        child: _ResumeCard(
                          resume: resume,
                          onOpen: () => _openResume(context, ref, resume),
                          onDelete: () async {
                            if (await _confirmDelete(context)) {
                              await ref
                                  .read(curriculoListServiceProvider.notifier)
                                  .deleteResume(resume.id);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => EmptyState(
          icon: Icons.error_outline,
          title: 'Não foi possível carregar',
          message: '$err',
        ),
      ),
      floatingActionButton: resumeListAsync.valueOrNull?.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: () => _createNewResume(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Novo Currículo'),
            )
          : null,
    );
  }

  void _openResume(BuildContext context, WidgetRef ref, Resume resume) {
    ref.read(currentCurriculoServiceProvider.notifier).setResume(resume);
    context.push('/edit');
  }

  Future<bool> _confirmDelete(BuildContext context) {
    return confirmDestructive(
      context,
      title: 'Excluir currículo?',
      message: 'O currículo e todos os seus dados serão removidos.',
    );
  }

  Future<void> _createNewResume(BuildContext context, WidgetRef ref) async {
    final titleController = TextEditingController();
    final String? title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.note_add_outlined),
        title: const Text('Novo Currículo'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Nome do currículo',
            hintText: 'Ex: Currículo 2025',
          ),
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) Navigator.pop(context, value.trim());
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(64, 40)),
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                Navigator.pop(context, titleController.text.trim());
              }
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );

    if (title != null) {
      await ref
          .read(currentCurriculoServiceProvider.notifier)
          .createNew(title: title);
      if (context.mounted) {
        context.push('/edit');
      }
    }
  }
}

class _ResumeCard extends StatelessWidget {
  final Resume resume;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  const _ResumeCard({
    required this.resume,
    required this.onOpen,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = resume.personalData.fullName.trim();
    final objective = resume.personalData.professionalObjective.isNotEmpty
        ? resume.personalData.professionalObjective
        : resume.professionalObjective;
    final sections = resume.experiences.length +
        resume.education.length +
        resume.skills.length +
        resume.languages.length;

    return Card(
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      scheme.primary,
                      Color.lerp(
                          scheme.primary, const Color(0xFF00B4D8), 0.45)!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials(name.isNotEmpty ? name : resume.title),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resume.title.isNotEmpty ? resume.title : 'Sem título',
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (name.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        name,
                        style: theme.textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      objective.isNotEmpty
                          ? objective
                          : 'Sem objetivo definido',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        _Meta(
                          icon: Icons.schedule,
                          text:
                              DateFormat('dd/MM/yyyy').format(resume.updatedAt),
                        ),
                        _Meta(
                          icon: Icons.layers_outlined,
                          text: sections == 1 ? '1 item' : '$sections itens',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              EditDeleteMenu(onEdit: onOpen, onDelete: onDelete),
            ],
          ),
        ),
      ),
    );
  }

  String _initials(String text) {
    final parts = text.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return 'CV';
    final first = parts.first[0];
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: theme.textTheme.labelSmall?.copyWith(color: color)),
      ],
    );
  }
}
