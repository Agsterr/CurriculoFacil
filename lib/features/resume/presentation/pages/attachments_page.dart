import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:open_file/open_file.dart';
import '../../../../core/services/storage/file_storage_service.dart';
import '../../../../services/curriculo_service.dart';
import '../widgets/profile_image_picker.dart';

class AttachmentsPage extends ConsumerStatefulWidget {
  const AttachmentsPage({super.key});

  @override
  ConsumerState<AttachmentsPage> createState() => _AttachmentsPageState();
}

class _AttachmentsPageState extends ConsumerState<AttachmentsPage> {
  final FileStorageService _storageService = FileStorageService();
  bool _isUploading = false;

  Future<void> _pickOldResume() async {
    try {
      setState(() => _isUploading = true);

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        final originalFile = File(result.files.single.path!);
        final savedPath = await _storageService.saveFile(originalFile, 'old_resumes');
        
        final currentResume = ref.read(currentCurriculoServiceProvider);
        if (currentResume != null) {
          final updatedData = currentResume.personalData.copyWith(oldResumePath: savedPath);
          ref.read(currentCurriculoServiceProvider.notifier).updatePersonalData(updatedData);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Currículo anexado com sucesso!')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao anexar arquivo: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _deleteOldResume(String path) async {
    try {
      await _storageService.deleteFile(path);
      
      final currentResume = ref.read(currentCurriculoServiceProvider);
      if (currentResume != null) {
        final updatedData = currentResume.personalData.copyWith(oldResumePath: null);
        ref.read(currentCurriculoServiceProvider.notifier).updatePersonalData(updatedData);
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
    }
  }

  void _openFile(String path) {
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    final currentResume = ref.watch(currentCurriculoServiceProvider);

    if (currentResume == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final personalData = currentResume.personalData;
    final oldResumePath = personalData.oldResumePath;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anexos e Arquivos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Foto de Perfil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Center(child: ProfileImagePicker()),
            const SizedBox(height: 8),
            const Text(
              'Essa foto será usada no destaque do seu currículo (templates modernos).',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            
            const Divider(height: 40),
            
            const Text(
              'Currículo Antigo / Referência',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Anexe seu currículo antigo (PDF ou Imagem) para usar como referência ou extrair dados futuramente.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            if (oldResumePath != null && oldResumePath.isNotEmpty)
              _buildAttachmentCard(oldResumePath)
            else
              _buildUploadButton(),
              
            if (_isUploading)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 2, style: BorderStyle.solid),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _pickOldResume,
          borderRadius: BorderRadius.circular(12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.blue),
              SizedBox(height: 8),
              Text(
                'Toque para anexar arquivo',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Text(
                'PDF, JPG ou PNG',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentCard(String path) {
    final isPdf = p.extension(path).toLowerCase() == '.pdf';
    final fileName = p.basename(path);
    final file = File(path);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isPdf ? Colors.red[50] : Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isPdf ? Icons.picture_as_pdf : Icons.image,
                    color: isPdf ? Colors.red : Colors.blue,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPdf ? 'Documento PDF' : 'Imagem de Referência',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        fileName,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    // Confirm dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Remover anexo?'),
                        content: const Text('O arquivo será excluído permanentemente.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Ideally we should delete file too, but let's keep it simple or call service
                              _deleteOldResume(path);
                            },
                            child: const Text('Remover'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (!isPdf && file.existsSync())
              GestureDetector(
                onTap: () => _openFile(path),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(file),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            if (isPdf)
              OutlinedButton.icon(
                onPressed: () => _openFile(path),
                icon: const Icon(Icons.visibility),
                label: const Text('Visualizar PDF'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
