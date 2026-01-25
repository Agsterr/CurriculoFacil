Vou implementar a funcionalidade de cadastro de experiências profissionais com suporte a ditado por voz, mantendo a edição manual e a atualização automática do preview.

### Roteiro de Implementação

1.  **Adicionar Dependências (`pubspec.yaml`)**
    *   Incluir `speech_to_text` para reconhecimento de voz.
    *   Incluir `permission_handler` para gerenciar permissões de microfone de forma robusta.

2.  **Configurar Permissões Android (`AndroidManifest.xml`)**
    *   Adicionar a permissão `android.permission.RECORD_AUDIO` necessária para o funcionamento do microfone.

3.  **Atualizar Interface de Cadastro (`experience_form_page.dart`)**
    *   Implementar a lógica do `SpeechToText` (inicialização, início e fim da escuta).
    *   Adicionar um botão de microfone ao campo "Descrição das atividades".
    *   Integrar o texto reconhecido ao `TextEditingController` existente, permitindo que o usuário fale e edite o texto livremente.
    *   Garantir feedback visual quando o app estiver "ouvindo".

4.  **Validação e Preview**
    *   O sistema de preview existente (baseado em Riverpod) já observa as mudanças na lista de experiências, garantindo que assim que a experiência for salva, o preview seja atualizado automaticamente.
    *   Testar o fluxo: Falar -> Texto aparece -> Editar -> Salvar -> Preview atualiza.

### Arquivos Afetados
*   `pubspec.yaml`
*   `android/app/src/main/AndroidManifest.xml`
*   `lib/features/resume/presentation/pages/experience_form_page.dart`
