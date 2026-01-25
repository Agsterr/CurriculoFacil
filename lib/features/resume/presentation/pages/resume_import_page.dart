import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/resume_import_service.dart';
import '../../domain/entities/resume_draft.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../models/curriculo_model.dart' as model;

class ResumeImportPage extends ConsumerStatefulWidget {
  const ResumeImportPage({super.key});

  @override
  ConsumerState<ResumeImportPage> createState() => _ResumeImportPageState();
}

class _ResumeImportPageState extends ConsumerState<ResumeImportPage> {
  final _importService = ResumeImportService();
  bool _isLoading = false;
  ResumeDraft? _draft;
  String? _errorMessage;

  // Controllers for review
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _importService.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(bool fromCamera) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      File? file;
      
      if (fromCamera) {
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.camera);
        if (picked != null) file = File(picked.path);
      } else {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        );
        if (result != null && result.files.single.path != null) {
          file = File(result.files.single.path!);
        }
      }

      if (file != null) {
        final draft = await _importService.processFile(file);
        setState(() {
          _draft = draft;
          _nameController.text = draft.personalData.fullName;
          _emailController.text = draft.personalData.email;
          _phoneController.text = draft.personalData.phone;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao processar arquivo: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _confirmImport() {
    if (_draft == null) return;

    final currentResume = ref.read(currentCurriculoServiceProvider);
    
    if (currentResume != null) {
      // Update Providers
      final newPersonalData = currentResume.personalData.copyWith(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );
      ref.read(currentCurriculoServiceProvider.notifier).updatePersonalData(newPersonalData);

      // Add Collections (Simple addition for MVP)
      for (final exp in _draft!.experiences) {
        final modelExp = model.Experience(
          id: exp.id,
          company: exp.company,
          role: exp.role,
          startDate: exp.startDate,
          endDate: exp.endDate,
          isCurrent: exp.isCurrent,
          description: exp.description,
          isConfirmed: exp.isConfirmed,
        );
        ref.read(currentCurriculoServiceProvider.notifier).addExperience(modelExp);
      }
      
      for (final edu in _draft!.education) {
        final modelEdu = model.Education(
          id: edu.id,
          institution: edu.institution,
          degree: edu.degree,
          fieldOfStudy: edu.fieldOfStudy,
          startDate: edu.startDate,
          endDate: edu.endDate,
          isCurrent: edu.isCurrent,
          isConfirmed: edu.isConfirmed,
        );
        ref.read(currentCurriculoServiceProvider.notifier).addEducation(modelEdu);
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados importados com sucesso! Revise os detalhes.')),
    );

    context.go('/personal-data'); // Go to first step to refine
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Importar Currículo')),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Lendo documento com IA...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_draft == null) ...[
                    const Icon(Icons.document_scanner, size: 80, color: Colors.blue),
                    const SizedBox(height: 24),
                    const Text(
                      'Tire uma foto ou anexe um PDF do seu currículo antigo para preenchimento automático.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton.icon(
                      onPressed: () => _pickFile(true),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tirar Foto'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () => _pickFile(false),
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Anexar Arquivo (PDF/Img)'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Revise os dados identificados:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nome Completo'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Telefone'),
                    ),
                    const SizedBox(height: 24),
                    if (_draft!.experiences.isNotEmpty)
                      _buildInfoCard(
                        'Experiências Detectadas', 
                        '${_draft!.experiences.length} item(s) encontrado(s). Será necessário detalhar datas e descrições.',
                        Icons.work,
                      ),
                    const SizedBox(height: 16),
                    if (_draft!.education.isNotEmpty)
                      _buildInfoCard(
                        'Formação Detectada',
                        '${_draft!.education.length} item(s) encontrado(s).',
                        Icons.school,
                      ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: _confirmImport,
                      child: const Text('Confirmar e Editar'),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _draft = null),
                      child: const Text('Cancelar / Tentar Novamente'),
                    ),
                  ],
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, IconData icon) {
    return Card(
      color: Colors.blue.shade50,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
