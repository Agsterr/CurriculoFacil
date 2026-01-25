import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../services/curriculo_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(currentCurriculoServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _editTitle(context, ref, resume?.title),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  resume?.title ?? 'Novo Currículo',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.edit, size: 18),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMenuCard(
              context,
              'Dados Pessoais',
              Icons.person,
              '/personal-data',
              Colors.blue,
            ),
            _buildMenuCard(
              context,
              'Experiência',
              Icons.work,
              '/experience',
              Colors.orange,
            ),
            _buildMenuCard(
              context,
              'Educação',
              Icons.school,
              '/education',
              Colors.green,
            ),
            _buildMenuCard(
              context,
              'Habilidades',
              Icons.star,
              '/skills',
              Colors.purple,
            ),
            _buildMenuCard(
              context,
              'Importar (OCR)',
              Icons.document_scanner,
              '/import',
              Colors.teal,
            ),
            _buildMenuCard(
              context,
              'Visualizar Currículo',
              Icons.visibility,
              '/preview',
              Colors.red,
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editTitle(BuildContext context, WidgetRef ref, String? currentTitle) async {
    final controller = TextEditingController(text: currentTitle);
    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
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
          ElevatedButton(
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
        ref.read(currentCurriculoServiceProvider.notifier).updateResume(updatedResume);
      }
    }
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
    Color color, {
    bool isPrimary = false,
  }) {
    return Card(
      elevation: isPrimary ? 8 : 2,
      color: isPrimary ? color : Colors.white,
      child: InkWell(
        onTap: () => context.push(route),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: isPrimary ? Colors.white : color,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isPrimary ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
