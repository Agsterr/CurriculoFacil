import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const PermissionDialog({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String content,
    required IconData icon,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PermissionDialog(
        title: title,
        content: content,
        icon: icon,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(icon, size: 48, color: Theme.of(context).primaryColor),
      title: Text(title, textAlign: TextAlign.center),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Agora não'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Continuar'),
        ),
      ],
    );
  }
}
