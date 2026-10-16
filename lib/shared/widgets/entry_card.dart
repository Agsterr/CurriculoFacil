import 'package:flutter/material.dart';
import 'app_ui.dart';

/// Cartão de item de lista (experiência, formação...) com menu de ações
/// e destaque para itens importados que ainda precisam de revisão.
class EntryCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final String period;
  final String? description;
  final bool needsReview;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EntryCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    this.subtitle,
    required this.period,
    this.description,
    this.needsReview = false,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    const warning = Color(0xFFE65100);

    return Card(
      shape: needsReview
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: warning, width: 1.5),
            )
          : null,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBadge(icon: icon, color: needsReview ? warning : color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (needsReview)
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: warning.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Revisão necessária',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: warning,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    Text(
                      title.isNotEmpty ? title : 'Sem título',
                      style: theme.textTheme.titleMedium,
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: theme.textTheme.bodyMedium),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.event_outlined,
                            size: 14, color: scheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            period,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (description != null &&
                        description!.trim().isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        description!.trim(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              EditDeleteMenu(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}
