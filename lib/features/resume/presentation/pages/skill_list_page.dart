import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';
import '../../../../shared/widgets/speech_text_field.dart';

class SkillListPage extends ConsumerStatefulWidget {
  const SkillListPage({super.key});

  @override
  ConsumerState<SkillListPage> createState() => _SkillListPageState();
}

class _SkillListPageState extends ConsumerState<SkillListPage> {
  final _controller = TextEditingController();

  static const _suggestions = [
    'Comunicação',
    'Trabalho em equipe',
    'Liderança',
    'Pacote Office',
    'Atendimento ao cliente',
    'Organização',
    'Resolução de problemas',
    'Proatividade',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addSkill([String? value]) {
    final text = (value ?? _controller.text).trim();
    if (text.isEmpty) return;

    final skills = ref.read(currentCurriculoServiceProvider)?.skills ?? [];
    final exists =
        skills.any((s) => s.name.toLowerCase() == text.toLowerCase());
    if (!exists) {
      ref.read(currentCurriculoServiceProvider.notifier).addSkill(
            Skill(id: const Uuid().v4(), name: text, proficiency: 1.0),
          );
    }
    if (value == null) _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final resume = ref.watch(currentCurriculoServiceProvider);
    final skills = resume?.skills ?? [];
    final names = skills.map((s) => s.name.toLowerCase()).toSet();
    final suggestions =
        _suggestions.where((s) => !names.contains(s.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habilidades'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          FormSectionCard(
            title: 'Adicionar habilidade',
            icon: Icons.add_circle_outline,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SpeechTextField(
                      controller: _controller,
                      labelText: 'Nova habilidade',
                      hintText: 'Ex: Flutter, Excel, Liderança',
                      prefixIcon: Icons.auto_awesome_outlined,
                      onSubmitted: (_) => _addSkill(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: _addSkill,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(56, 56),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              if (suggestions.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Sugestões',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final s in suggestions)
                      ActionChip(
                        avatar: const Icon(Icons.add, size: 18),
                        label: Text(s),
                        onPressed: () => _addSkill(s),
                      ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          if (skills.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: EmptyState(
                icon: Icons.auto_awesome_outlined,
                title: 'Nenhuma habilidade ainda',
                message:
                    'Digite acima ou toque em uma sugestão para adicionar.',
              ),
            )
          else
            FormSectionCard(
              title: 'Suas habilidades (${skills.length})',
              icon: Icons.check_circle_outline,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final skill in skills)
                      InputChip(
                        label: Text(skill.name),
                        backgroundColor:
                            scheme.primaryContainer.withValues(alpha: 0.5),
                        side: BorderSide.none,
                        deleteIcon: const Icon(Icons.close, size: 18),
                        deleteButtonTooltipMessage: 'Remover',
                        onDeleted: () => ref
                            .read(currentCurriculoServiceProvider.notifier)
                            .removeSkill(skill.id),
                      ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
