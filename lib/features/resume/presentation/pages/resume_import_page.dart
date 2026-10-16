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
import '../../../../shared/widgets/app_ui.dart';

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
      ref
          .read(currentCurriculoServiceProvider.notifier)
          .updatePersonalData(newPersonalData);

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
        ref
            .read(currentCurriculoServiceProvider.notifier)
            .addExperience(modelExp);
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
        ref
            .read(currentCurriculoServiceProvider.notifier)
            .addEducation(modelEdu);
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Dados importados com sucesso! Revise os detalhes.')),
    );

    context.pushReplacement('/personal-data'); // Go to first step to refine
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Importar Currículo')),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text('Lendo seu documento...',
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Isso pode levar alguns segundos.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                if (_draft == null) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.document_scanner_outlined,
                          size: 52, color: scheme.primary),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Aproveite seu currículo antigo',
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tire uma foto ou anexe um PDF e nós preenchemos os campos automaticamente para você revisar.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _SourceOption(
                    icon: Icons.photo_camera_outlined,
                    title: 'Tirar foto',
                    subtitle: 'Fotografe o currículo impresso',
                    onTap: () => _pickFile(true),
                  ),
                  const SizedBox(height: 12),
                  _SourceOption(
                    icon: Icons.upload_file_outlined,
                    title: 'Anexar arquivo',
                    subtitle: 'PDF, JPG ou PNG do seu aparelho',
                    onTap: () => _pickFile(false),
                  ),
                ] else ...[
                  FormSectionCard(
                    title: 'Revise os dados identificados',
                    icon: Icons.fact_check_outlined,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome Completo',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_draft!.experiences.isNotEmpty) ...[
                    _buildInfoCard(
                      'Experiências detectadas',
                      '${_draft!.experiences.length} item(s) encontrado(s). Será necessário detalhar datas e descrições.',
                      Icons.work_outline,
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (_draft!.education.isNotEmpty) ...[
                    _buildInfoCard(
                      'Formação detectada',
                      '${_draft!.education.length} item(s) encontrado(s).',
                      Icons.school_outlined,
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _confirmImport,
                    icon: const Icon(Icons.check),
                    label: const Text('Confirmar e Editar'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => setState(() => _draft = null),
                    child: const Text('Cancelar / Tentar Novamente'),
                  ),
                ],
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Card(
                      color: scheme.errorContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                color: scheme.onErrorContainer),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style:
                                    TextStyle(color: scheme.onErrorContainer),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, IconData icon) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.secondaryContainer.withValues(alpha: 0.6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: IconBadge(icon: icon, color: scheme.secondary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class _SourceOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SourceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconBadge(icon: icon, color: scheme.primary, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
