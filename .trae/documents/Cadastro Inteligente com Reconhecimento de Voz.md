A implementação das telas de cadastro com reconhecimento de voz seguirá os seguintes passos:

### 1. Configuração e Dependências
Adicionar `speech_to_text` ao projeto para habilitar o reconhecimento de voz nativo (Android/iOS).

### 2. Componente de Entrada por Voz (`SpeechTextField`)
Criar um widget reutilizável `SpeechTextField` que combina um campo de texto padrão com um botão de microfone.
- **Funcionalidade**: Ao tocar no microfone, o app captura a fala e transcreve em tempo real para o campo de texto.
- **Correção**: O usuário pode editar o texto manualmente a qualquer momento (durante ou após o reconhecimento), atendendo ao requisito de interface simples para correção.
- **Preview**: O texto aparece no campo enquanto é falado.

### 3. Gestão de Estado (Idiomas)
Como a funcionalidade de Idiomas ainda não existe na camada de apresentação:
- Criar `LanguageListProvider`: Para gerenciar a lista de idiomas (adicionar, remover).
- Atualizar `ResumeProvider`: Para incluir a lista de idiomas no objeto final do currículo.

### 4. Implementação das Telas
- **Formação Acadêmica (`EducationFormPage`)**: Atualizar o formulário existente substituindo os campos de texto comuns (Instituição, Curso) pelo novo `SpeechTextField`.
- **Habilidades (`SkillListPage`)**: Atualizar a tela de listagem para permitir a adição de habilidades via voz.
- **Idiomas (`LanguageListPage`)**: Criar uma nova tela para cadastro de idiomas, com entrada de nome (texto/voz) e seletor de nível de proficiência.

### 5. Navegação
Adicionar a rota `/languages` no `AppRouter` e um botão correspondente na tela inicial.
