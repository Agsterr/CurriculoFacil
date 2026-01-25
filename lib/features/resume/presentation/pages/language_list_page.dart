import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/speech_text_field.dart';

class LanguageListPage extends ConsumerStatefulWidget {
  const LanguageListPage({super.key});

  @override
  ConsumerState<LanguageListPage> createState() => _LanguageListPageState();
}

class _LanguageListPageState extends ConsumerState<LanguageListPage> {
  final _controller = TextEditingController();
  LanguageProficiency _selectedProficiency = LanguageProficiency.basic;

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
    final resume = ref.watch(currentCurriculoServiceProvider);
    final languages = resume?.languages ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Idiomas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SpeechTextField(
                        controller: _controller,
                        labelText: 'Novo Idioma',
                        hintText: 'Ex: Inglês, Espanhol',
                        prefixIcon: Icons.language,
                        onSubmitted: (_) => _addLanguage(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<LanguageProficiency>(
                  value: _selectedProficiency,
                  decoration: const InputDecoration(
                    labelText: 'Nível de Proficiência',
                    prefixIcon: Icon(Icons.show_chart),
                  ),
                  items: LanguageProficiency.values.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(_proficiencyLabel(p)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedProficiency = val);
                    }
                  },
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _addLanguage,
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Idioma'),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: languages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.translate, size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Adicione os idiomas que você domina',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          child: Text(
                            language.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(language.name),
                        subtitle: Text(_proficiencyLabel(language.proficiency)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            ref
                                .read(currentCurriculoServiceProvider.notifier)
                                .removeLanguage(language.id);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
