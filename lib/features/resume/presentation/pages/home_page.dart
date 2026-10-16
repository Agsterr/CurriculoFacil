import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(currentCurriculoServiceProvider);

    if (resume == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Editor')),
        body: EmptyState(
          icon: Icons.description_outlined,
          title: 'Nenhum currículo selecionado',
          message: 'Volte para a lista e escolha ou crie um currículo.',
          actionLabel: 'Meus Currículos',
          onAction: () => context.go('/'),
        ),
      );
    }

    final sections = _buildSections(resume);
    final completed = sections.where((s) => s.done).length;
    final progress = completed / sections.length;
    final nextSection = sections.where((s) => !s.done).firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          resume.title.isNotEmpty ? resume.title : 'Novo Currículo',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: 'Renomear',
            icon: const Icon(Icons.drive_file_rename_outline),
            onPressed: () => _editTitle(context, ref, resume.title),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              _ProgressHeader(
                name: resume.personalData.fullName,
                progress: progress,
                completed: completed,
                total: sections.length,
                nextStep: nextSection?.title,
              ),
              const SizedBox(height: 16),
              _ImportBanner(onTap: () => context.push('/import')),
              const SectionTitle(
                'Seções do currículo',
                padding: EdgeInsets.only(top: 24, bottom: 12, left: 4),
              ),
              for (final section in sections) ...[
                _SectionTile(
                  section: section,
                  onTap: () => context.push(section.route),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: FilledButton.icon(
          onPressed: () => context.push('/preview'),
          icon: const Icon(Icons.picture_as_pdf_outlined),
          label: const Text('Visualizar e Exportar PDF'),
        ),
      ),
    );
  }

  List<_Section> _buildSections(Resume resume) {
    final data = resume.personalData;
    final personalDone = data.fullName.trim().isNotEmpty &&
        data.email.trim().isNotEmpty &&
        data.phone.trim().isNotEmpty;

    String countLabel(int n, String singular, String plural, String empty) {
      if (n == 0) return empty;
      return n == 1 ? '1 $singular' : '$n $plural';
    }

    return [
      _Section(
        title: 'Dados Pessoais',
        subtitle:
            personalDone ? data.fullName : 'Nome, contato, endereço e objetivo',
        icon: Icons.person_outline,
        color: const Color(0xFF1E5EFF),
        route: '/personal-data',
        done: personalDone,
      ),
      _Section(
        title: 'Experiência',
        subtitle: countLabel(resume.experiences.length, 'experiência',
            'experiências', 'Empregos, estágios e trabalhos'),
        icon: Icons.work_outline,
        color: const Color(0xFFF57C00),
        route: '/experience',
        done: resume.experiences.isNotEmpty,
      ),
      _Section(
        title: 'Formação',
        subtitle: countLabel(resume.education.length, 'formação', 'formações',
            'Cursos, graduação e certificados'),
        icon: Icons.school_outlined,
        color: const Color(0xFF2E7D32),
        route: '/education',
        done: resume.education.isNotEmpty,
      ),
      _Section(
        title: 'Habilidades',
        subtitle: countLabel(resume.skills.length, 'habilidade', 'habilidades',
            'Competências técnicas e pessoais'),
        icon: Icons.auto_awesome_outlined,
        color: const Color(0xFF7B1FA2),
        route: '/skills',
        done: resume.skills.isNotEmpty,
      ),
      _Section(
        title: 'Idiomas',
        subtitle: countLabel(resume.languages.length, 'idioma', 'idiomas',
            'Línguas e nível de proficiência'),
        icon: Icons.translate,
        color: const Color(0xFF00838F),
        route: '/languages',
        done: resume.languages.isNotEmpty,
      ),
    ];
  }

  Future<void> _editTitle(
      BuildContext context, WidgetRef ref, String? currentTitle) async {
    final controller = TextEditingController(text: currentTitle);
    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.drive_file_rename_outline),
        title: const Text('Renomear Currículo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Título',
            hintText: 'Ex: Currículo 2025',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(64, 40)),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context, controller.text.trim());
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (newTitle != null && newTitle.isNotEmpty) {
      final currentResume = ref.read(currentCurriculoServiceProvider);
      if (currentResume != null) {
        final updatedResume = currentResume.copyWith(title: newTitle);
        ref
            .read(currentCurriculoServiceProvider.notifier)
            .updateResume(updatedResume);
      }
    }
  }
}

class _Section {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;
  final bool done;

  const _Section({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
    required this.done,
  });
}

class _ProgressHeader extends StatelessWidget {
  final String name;
  final double progress;
  final int completed;
  final int total;
  final String? nextStep;

  const _ProgressHeader({
    required this.name,
    required this.progress,
    required this.completed,
    required this.total,
    required this.nextStep,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final firstName = name.trim().split(' ').first;
    final onColor = scheme.onPrimary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary,
            Color.lerp(scheme.primary, const Color(0xFF00B4D8), 0.45)!,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            firstName.isNotEmpty
                ? 'Olá, $firstName!'
                : 'Vamos montar seu currículo',
            style: theme.textTheme.titleLarge?.copyWith(color: onColor),
          ),
          const SizedBox(height: 4),
          Text(
            nextStep == null
                ? 'Tudo preenchido! Seu currículo está pronto para exportar.'
                : 'Próximo passo: $nextStep',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: onColor.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: onColor.withValues(alpha: 0.25),
                    valueColor: AlwaysStoppedAnimation(onColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(progress * 100).round()}%',
                style: theme.textTheme.titleMedium?.copyWith(color: onColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '$completed de $total seções concluídas',
            style: theme.textTheme.labelMedium?.copyWith(
              color: onColor.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImportBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _ImportBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      color: scheme.secondaryContainer.withValues(alpha: 0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconBadge(
                  icon: Icons.document_scanner_outlined,
                  color: scheme.secondary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Já tem um currículo?',
                        style: theme.textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      'Importe uma foto ou PDF e preencha automaticamente.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSecondaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTile extends StatelessWidget {
  final _Section section;
  final VoidCallback onTap;

  const _SectionTile({required this.section, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              IconBadge(icon: section.icon, color: section.color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      section.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (section.done)
                Icon(Icons.check_circle, color: Colors.green.shade600, size: 22)
              else
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
