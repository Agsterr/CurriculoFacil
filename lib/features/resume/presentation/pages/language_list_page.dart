import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/app_ui.dart';
import '../../../../shared/widgets/speech_text_field.dart';

class LanguageListPage extends ConsumerStatefulWidget {
  const LanguageListPage({super.key});

  @override
  ConsumerState<LanguageListPage> createState() => _LanguageListPageState();
}

class _LanguageListPageState extends ConsumerState<LanguageListPage> {
  final _controller = TextEditingController();
  LanguageProficiency _selectedProficiency = LanguageProficiency.basic;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addLanguage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final language = Language(
        id: const Uuid().v4(),
        name: text,
        proficiency: _selectedProficiency,
      );
      ref.read(currentCurriculoServiceProvider.notifier).addLanguage(language);
      _controller.clear();
      setState(() {
        _selectedProficiency = LanguageProficiency.basic;
      });
    }
  }

  String _proficiencyLabel(LanguageProficiency p) {
    switch (p) {
      case LanguageProficiency.basic:
        return 'Básico';
      case LanguageProficiency.intermediate:
        return 'Intermediário';
      case LanguageProficiency.advanced:
        return 'Avançado';
      case LanguageProficiency.fluent:
        return 'Fluente';
      case LanguageProficiency.native:
        return 'Nativo';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final resume = ref.watch(currentCurriculoServiceProvider);
    final languages = resume?.languages ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Idiomas'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          FormSectionCard(
            title: 'Adicionar idioma',
            icon: Icons.add_circle_outline,
            children: [
              SpeechTextField(
                controller: _controller,
                labelText: 'Idioma',
                hintText: 'Ex: Inglês, Espanhol',
                prefixIcon: Icons.translate,
                onSubmitted: (_) => _addLanguage(),
              ),
              const SizedBox(height: 16),
              Text(
                'Nível de proficiência',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final p in LanguageProficiency.values)
                    ChoiceChip(
                      label: Text(_proficiencyLabel(p)),
                      selected: _selectedProficiency == p,
                      onSelected: (_) =>
                          setState(() => _selectedProficiency = p),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _addLanguage,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Idioma'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (languages.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: EmptyState(
                icon: Icons.translate,
                title: 'Nenhum idioma ainda',
                message: 'Adicione os idiomas que você domina e o seu nível.',
              ),
            )
          else ...[
            SectionTitle('Seus idiomas (${languages.length})',
                icon: Icons.check_circle_outline),
            for (final language in languages) ...[
              _LanguageCard(
                language: language,
                label: _proficiencyLabel(language.proficiency),
                onDelete: () => ref
                    .read(currentCurriculoServiceProvider.notifier)
                    .removeLanguage(language.id),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ],
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final Language language;
  final String label;
  final VoidCallback onDelete;

  const _LanguageCard({
    required this.language,
    required this.label,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final level = language.proficiency.index + 1;
    const total = 5;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: scheme.tertiaryContainer,
              child: Text(
                language.name.isNotEmpty
                    ? language.name.substring(0, 1).toUpperCase()
                    : '?',
                style: TextStyle(
                  color: scheme.onTertiaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language.name, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      for (var i = 0; i < total; i++)
                        Container(
                          width: 18,
                          height: 6,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: i < level
                                ? scheme.tertiary
                                : scheme.outlineVariant.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Remover',
              icon: Icon(Icons.delete_outline, color: scheme.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
