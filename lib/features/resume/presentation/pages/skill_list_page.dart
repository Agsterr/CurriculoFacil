import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/speech_text_field.dart';

class SkillListPage extends ConsumerStatefulWidget {
  const SkillListPage({super.key});

  @override
  ConsumerState<SkillListPage> createState() => _SkillListPageState();
}

class _SkillListPageState extends ConsumerState<SkillListPage> {
  final _controller = TextEditingController();

  void _addSkill() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final skill = Skill(
        id: const Uuid().v4(),
        name: text,
        proficiency: 1.0, 
      );
      ref.read(currentCurriculoServiceProvider.notifier).addSkill(skill);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final resume = ref.watch(currentCurriculoServiceProvider);
    final skills = resume?.skills ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habilidades'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SpeechTextField(
                    controller: _controller,
                    labelText: 'Nova Habilidade',
                    hintText: 'Ex: Flutter, Inglês, Liderança',
                    prefixIcon: Icons.star_outline,
                    onSubmitted: (_) => _addSkill(),
                  ),
                ),
                const SizedBox(width: 16),
                FloatingActionButton.small(
                  onPressed: _addSkill,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: skills.isEmpty
                ? Center(
                    child: Text(
                      'Adicione suas principais habilidades',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];
                      return ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(skill.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            ref
                                .read(currentCurriculoServiceProvider.notifier)
                                .removeSkill(skill.id);
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
