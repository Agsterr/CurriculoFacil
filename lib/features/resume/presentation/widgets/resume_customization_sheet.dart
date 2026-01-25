import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/curriculo_model.dart';
import '../../../../services/curriculo_service.dart';
import '../pages/resume_preview_page.dart'; // For draftModeProvider

class ResumeCustomizationSheet extends ConsumerWidget {
  const ResumeCustomizationSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(currentCurriculoServiceProvider);
    final notifier = ref.read(currentCurriculoServiceProvider.notifier);

    if (resume == null) return const SizedBox();
    final style = resume.style;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text('Personalizar Currículo', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              _buildSectionTitle('Layout'),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _TemplateOption(
                      label: 'Moderno',
                      icon: Icons.dashboard,
                      isSelected: style.templateId == 'modern',
                      onTap: () => notifier.updateStyle(style.copyWith(templateId: 'modern')),
                    ),
                    const SizedBox(width: 10),
                    _TemplateOption(
                      label: 'Clássico',
                      icon: Icons.article,
                      isSelected: style.templateId == 'classic',
                      onTap: () => notifier.updateStyle(style.copyWith(templateId: 'classic')),
                    ),
                    const SizedBox(width: 10),
                    _TemplateOption(
                      label: 'Minimalista',
                      icon: Icons.notes,
                      isSelected: style.templateId == 'minimalist',
                      onTap: () => notifier.updateStyle(style.copyWith(templateId: 'minimalist')),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              _buildSectionTitle('Cores'),
              const SizedBox(height: 10),
              const Text('Cor Principal', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 5),
              _ColorPickerRow(
                selectedColor: style.primaryColor,
                onColorSelected: (color) => notifier.updateStyle(style.copyWith(primaryColor: color)),
              ),
              const SizedBox(height: 10),
              const Text('Cor Secundária', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 5),
              _ColorPickerRow(
                selectedColor: style.secondaryColor,
                onColorSelected: (color) => notifier.updateStyle(style.copyWith(secondaryColor: color)),
              ),

              const SizedBox(height: 20),
              _buildSectionTitle('Estilo & Moldura'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _ChipOption(
                    label: 'Sem Moldura',
                    selected: style.frameType == 'none',
                    onSelected: (_) => notifier.updateStyle(style.copyWith(frameType: 'none')),
                  ),
                  _ChipOption(
                    label: 'Linha Lateral',
                    selected: style.frameType == 'side',
                    onSelected: (_) => notifier.updateStyle(style.copyWith(frameType: 'side')),
                  ),
                  _ChipOption(
                    label: 'Linha Superior',
                    selected: style.frameType == 'top_line',
                    onSelected: (_) => notifier.updateStyle(style.copyWith(frameType: 'top_line')),
                  ),
                  _ChipOption(
                    label: 'Caixa',
                    selected: style.frameType == 'box',
                    onSelected: (_) => notifier.updateStyle(style.copyWith(frameType: 'box')),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildSectionTitle('Opções de Visualização'),
              SwitchListTile(
                title: const Text('Exibir Foto'),
                value: style.showPhoto,
                onChanged: (val) => notifier.updateStyle(style.copyWith(showPhoto: val)),
              ),
              SwitchListTile(
                title: const Text('Destacar Itens Não Confirmados'),
                subtitle: const Text('Marca em amarelo campos que precisam de revisão'),
                value: ref.watch(draftModeProvider),
                onChanged: (val) => ref.read(draftModeProvider.notifier).state = val,
              ),
              
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Reset to default
                  notifier.updateStyle(const ResumeStyle());
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Restaurar Padrão'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        color: Colors.grey,
      ),
    );
  }
}

class _TemplateOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TemplateOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? colorScheme.primary : Colors.grey[600],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? colorScheme.primary : Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorPickerRow extends StatelessWidget {
  final int selectedColor;
  final ValueChanged<int> onColorSelected;

  const _ColorPickerRow({required this.selectedColor, required this.onColorSelected});

  static const List<int> _colors = [
    0xFF2196F3, // Blue
    0xFF1976D2, // Dark Blue
    0xFFF44336, // Red
    0xFFE91E63, // Pink
    0xFF4CAF50, // Green
    0xFF009688, // Teal
    0xFFFF9800, // Orange
    0xFF795548, // Brown
    0xFF9E9E9E, // Grey
    0xFF607D8B, // Blue Grey
    0xFF000000, // Black
    0xFF673AB7, // Deep Purple
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _colors.map((colorValue) {
          final isSelected = selectedColor == colorValue;
          return GestureDetector(
            onTap: () => onColorSelected(colorValue),
            child: Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(colorValue),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChipOption extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _ChipOption({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: selected ? Theme.of(context).colorScheme.primary : Colors.black,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }
}
