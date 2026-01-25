import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../../../../shared/widgets/speech_text_field.dart';
import '../../../../shared/widgets/ocr_button.dart';

class EducationFormPage extends ConsumerStatefulWidget {
  final Education? education;

  const EducationFormPage({super.key, this.education});

  @override
  ConsumerState<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends ConsumerState<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _institutionController;
  late TextEditingController _degreeController;
  late TextEditingController _fieldController;

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  @override
  void initState() {
    super.initState();
    final e = widget.education;
    _institutionController = TextEditingController(text: e?.institution);
    _degreeController = TextEditingController(text: e?.degree);
    _fieldController = TextEditingController(text: e?.fieldOfStudy);
    _startDate = e?.startDate;
    _endDate = e?.endDate;
    _isCurrent = e?.isCurrent ?? false;
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isStart) async {
    final now = DateTime.now();
    final firstDate = DateTime(1950);

    DateTime initialDate = isStart
        ? (_startDate ?? now)
        : (_endDate ?? now);

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

      final education = Education(
        id: widget.education?.id ?? const Uuid().v4(),
        institution: _institutionController.text,
        degree: _degreeController.text,
        fieldOfStudy: _fieldController.text.isEmpty ? null : _fieldController.text,
        startDate: _startDate!,
        endDate: _isCurrent ? null : _endDate,
        isCurrent: _isCurrent,
      );

      final notifier = ref.read(currentCurriculoServiceProvider.notifier);
      if (widget.education != null) {
        notifier.updateEducation(education);
      } else {
        notifier.addEducation(education);
      }

      Navigator.pop(context);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Selecionar Data';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.education != null ? 'Editar Formação' : 'Nova Formação'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SpeechTextField(
                controller: _institutionController,
                labelText: 'Instituição de Ensino *',
                prefixIcon: Icons.school_outlined,
                validator: (v) => v?.isEmpty == true ? 'Informe a instituição' : null,
                suffixAction: OCRButton(
                  onTextRecognized: (text) => _institutionController.text = text,
                ),
              ),
              const SizedBox(height: 16),

              SpeechTextField(
                controller: _degreeController,
                labelText: 'Tipo de Formação (Grau) *',
                hintText: 'Ex: Bacharelado, Técnico, Pós-graduação',
                prefixIcon: Icons.workspace_premium_outlined,
                validator: (v) => v?.isEmpty == true ? 'Informe o tipo de formação' : null,
              ),
              const SizedBox(height: 16),
              
              SpeechTextField(
                controller: _fieldController,
                labelText: 'Curso *',
                hintText: 'Ex: Engenharia de Software, Administração',
                prefixIcon: Icons.menu_book_outlined,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _pickDate(true),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Início *',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(_formatDate(_startDate)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _isCurrent ? null : () => _pickDate(false),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Término',
                          prefixIcon: const Icon(Icons.calendar_today),
                          enabled: !_isCurrent,
                        ),
                        child: Text(_isCurrent ? 'Cursando' : _formatDate(_endDate)),
                      ),
                    ),
                  ),
                ],
              ),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Estudo aqui atualmente'),
                value: _isCurrent,
                onChanged: (val) {
                  setState(() {
                    _isCurrent = val ?? false;
                    if (_isCurrent) _endDate = null;
                  });
                },
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check),
                  label: Text(widget.education != null ? 'Atualizar' : 'Adicionar'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
