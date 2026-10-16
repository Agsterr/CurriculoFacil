import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/speech_text_field.dart';
import '../../../../shared/widgets/app_ui.dart';
import '../../../../shared/widgets/ocr_button.dart';

class ExperienceFormPage extends ConsumerStatefulWidget {
  final Experience? experience;

  const ExperienceFormPage({super.key, this.experience});

  @override
  ConsumerState<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends ConsumerState<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _companyController;
  late TextEditingController _roleController;
  late TextEditingController _descriptionController;

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  @override
  void initState() {
    super.initState();
    final e = widget.experience;
    _companyController = TextEditingController(text: e?.company);
    _roleController = TextEditingController(text: e?.role);
    _descriptionController = TextEditingController(text: e?.description);
    _startDate = e?.startDate;
    _endDate = e?.endDate;
    _isCurrent = e?.isCurrent ?? false;
  }

  @override
  void dispose() {
    _companyController.dispose();
    _roleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isStart) async {
    final now = DateTime.now();
    final firstDate = DateTime(1950);

    DateTime initialDate = isStart ? (_startDate ?? now) : (_endDate ?? now);

    // Proteção: initialDate deve estar entre firstDate e lastDate
    if (initialDate.isAfter(now)) initialDate = now;
    if (initialDate.isBefore(firstDate)) initialDate = firstDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: now,
      locale: const Locale('pt', 'BR'),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione a data de início')),
        );
        return;
      }

      if (!_isCurrent && _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Selecione a data de término ou marque "Trabalho aqui atualmente"')),
        );
        return;
      }

      if (!_isCurrent && _endDate != null && _startDate!.isAfter(_endDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'A data de início não pode ser posterior à data de término')),
        );
        return;
      }

      final experience = Experience(
        id: widget.experience?.id ?? const Uuid().v4(),
        company: _companyController.text,
        role: _roleController.text,
        startDate: _startDate!,
        endDate: _isCurrent ? null : _endDate,
        isCurrent: _isCurrent,
        description: _descriptionController.text,
      );

      final notifier = ref.read(currentCurriculoServiceProvider.notifier);
      if (widget.experience != null) {
        notifier.updateExperience(experience);
      } else {
        notifier.addExperience(experience);
      }

      Navigator.pop(context);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Selecionar';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.experience != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Experiência' : 'Nova Experiência'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            FormSectionCard(
              title: 'Cargo e empresa',
              icon: Icons.work_outline,
              children: [
                SpeechTextField(
                  controller: _roleController,
                  labelText: 'Cargo *',
                  hintText: 'Ex: Assistente Administrativo',
                  prefixIcon: Icons.badge_outlined,
                  validator: (v) =>
                      v?.isEmpty == true ? 'Informe o cargo' : null,
                ),
                const SizedBox(height: 16),
                SpeechTextField(
                  controller: _companyController,
                  labelText: 'Empresa *',
                  prefixIcon: Icons.business_outlined,
                  validator: (v) =>
                      v?.isEmpty == true ? 'Informe a empresa' : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FormSectionCard(
              title: 'Período',
              icon: Icons.date_range_outlined,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DateField(
                        label: 'Início *',
                        value: _formatDate(_startDate),
                        onTap: () => _pickDate(true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DateField(
                        label: 'Término',
                        value: _isCurrent ? 'Atual' : _formatDate(_endDate),
                        enabled: !_isCurrent,
                        onTap: () => _pickDate(false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Trabalho aqui atualmente'),
                  value: _isCurrent,
                  onChanged: (val) {
                    setState(() {
                      _isCurrent = val;
                      if (_isCurrent) _endDate = null;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            FormSectionCard(
              title: 'Atividades',
              icon: Icons.notes_outlined,
              children: [
                SpeechTextField(
                  controller: _descriptionController,
                  labelText: 'Descrição das atividades *',
                  hintText: 'Principais responsabilidades e resultados',
                  prefixIcon: Icons.description_outlined,
                  validator: (v) =>
                      v?.isEmpty == true ? 'Descreva suas atividades' : null,
                  suffixAction: OCRButton(
                    onTextRecognized: (text) {
                      if (text.isNotEmpty) {
                        final current = _descriptionController.text;
                        _descriptionController.text =
                            current.isEmpty ? text : '$current\n$text';
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: FilledButton.icon(
          onPressed: _save,
          icon: const Icon(Icons.check),
          label:
              Text(isEditing ? 'Salvar Alterações' : 'Adicionar Experiência'),
        ),
      ),
    );
  }
}
