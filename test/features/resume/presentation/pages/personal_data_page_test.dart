import 'package:curriculofacil/models/curriculo_model.dart';
import 'package:curriculofacil/features/resume/presentation/pages/personal_data_page.dart';
import 'package:curriculofacil/services/curriculo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock simples para o estado
class MockCurrentCurriculoService extends CurrentCurriculoService {
  @override
  Resume? build() {
    return Resume(
      id: '1',
      title: 'Teste',
      professionalObjective: 'Objetivo teste',
      personalData: const PersonalData(
        fullName: 'Fulano',
        email: 'teste@teste.com',
        phone: '11999999999',
      ),
      style: const ResumeStyle(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

void main() {
  testWidgets('PersonalDataPage renders and has save button', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCurriculoServiceProvider.overrideWith(() => MockCurrentCurriculoService()),
        ],
        child: const MaterialApp(
          home: PersonalDataPage(),
        ),
      ),
    );

    // Verifica se o título está presente
    expect(find.text('Dados Pessoais'), findsOneWidget);

    // Verifica se os campos estão preenchidos com o mock
    expect(find.text('Fulano'), findsOneWidget);

    // Verifica se o botão existe com o novo texto
    expect(find.text('Salvar e Concluir'), findsOneWidget);
    
    // Verifica se o ícone mudou
    expect(find.byIcon(Icons.check), findsOneWidget);
  });
}
