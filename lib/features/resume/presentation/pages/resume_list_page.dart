import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../services/curriculo_service.dart';

class ResumeListPage extends ConsumerWidget {
  const ResumeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeListAsync = ref.watch(curriculoListServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Currículos'),
        centerTitle: true,
      ),
      body: resumeListAsync.when(
        data: (resumes) {
          if (resumes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.description_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Nenhum currículo encontrado',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _createNewResume(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Criar Primeiro Currículo'),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: resumes.length,
            itemBuilder: (context, index) {
              final resume = resumes[index];
              return Dismissible(
                key: Key(resume.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Excluir Currículo'),
                      content: const Text('Tem certeza que deseja excluir este currículo?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (_) {
                  ref.read(curriculoListServiceProvider.notifier).deleteResume(resume.id);
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.description, color: Colors.white),
                    ),
                    title: Text(
                      resume.title.isNotEmpty ? resume.title : 'Sem Título',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(resume.professionalObjective.isNotEmpty 
                            ? resume.professionalObjective 
                            : 'Sem objetivo definido',
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(
                          'Atualizado em: ${DateFormat('dd/MM/yyyy HH:mm').format(resume.updatedAt)}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          ref.read(currentCurriculoServiceProvider.notifier).setResume(resume);
                          context.push('/edit');
                        } else if (value == 'delete') {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Excluir Currículo'),
                              content: const Text('Tem certeza que deseja excluir este currículo?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(false),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(true),
                                  child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                          
                          if (confirm == true) {
                            await ref.read(curriculoListServiceProvider.notifier).deleteResume(resume.id);
                          }
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit, color: Colors.blue),
                            title: Text('Editar'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Excluir'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      ref.read(currentCurriculoServiceProvider.notifier).setResume(resume);
                      context.push('/edit');
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewResume(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _createNewResume(BuildContext context, WidgetRef ref) async {
    final titleController = TextEditingController();
    final String? title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Currículo'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Nome do Currículo (ex: Currículo 2025)',
            hintText: 'Digite um nome para identificar seu currículo',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
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
      await ref.read(currentCurriculoServiceProvider.notifier).createNew(title: title);
      if (context.mounted) {
        context.push('/edit');
      }
    }
  }
}
