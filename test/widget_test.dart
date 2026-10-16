import 'package:curriculofacil/core/theme/app_theme.dart';
import 'package:curriculofacil/shared/widgets/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmptyState renders title, message and action', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: EmptyState(
            icon: Icons.description_outlined,
            title: 'Nada aqui',
            message: 'Mensagem de apoio',
            actionLabel: 'Criar',
            onAction: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Nada aqui'), findsOneWidget);
    expect(find.text('Mensagem de apoio'), findsOneWidget);

    await tester.tap(find.text('Criar'));
    expect(tapped, isTrue);
  });
}
