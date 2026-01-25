# Implementação de OCR e Importação de Currículo

## 1. Novas Dependências
Adicionar ao `pubspec.yaml`:
- `google_mlkit_text_recognition`: Para OCR offline robusto.
- `file_picker`: Para selecionar arquivos PDF/Imagens.
- `pdf_render`: Para converter páginas de PDF em imagens (necessário para o ML Kit processar PDFs).

## 2. Camada de Serviço (`lib/features/resume/data/services/`)
Criar `ResumeImportService` responsável por:
1.  **Entrada**: Receber `File` (Imagem ou PDF).
2.  **Pré-processamento**: Se PDF, renderizar a 1ª página como imagem de alta resolução.
3.  **Extração (OCR)**: Processar a imagem com `TextRecognizer` do ML Kit.
4.  **Parsing Inteligente (Heurística)**:
    -   **Contato**: Regex para e-mail e telefone. Identificar nome pelo destaque (primeiras linhas).
    -   **Seções**: Detectar palavras-chave ("Experiência", "Educação") para segmentar o texto.
    -   **Mapeamento**: Retornar um objeto `ResumeDraft` (DTO temporário) com os campos sugeridos.

## 3. Interface de Usuário (`lib/features/resume/presentation/`)
### Nova Página: `ResumeImportPage`
-   **Seleção**: Botões grandes "Tirar Foto" e "Anexar Arquivo".
-   **Loading**: Feedback visual durante o processamento (pode levar alguns segundos).
-   **Revisão (Crucial)**:
    -   Apresentar os dados extraídos em um formulário editável.
    -   Permitir que o usuário corrija erros de OCR antes de confirmar.
    -   Botão "Confirmar Importação" que salva no estado global (Riverpod) e redireciona para a edição completa.

## 4. Integração
-   Adicionar ponto de entrada na `HomePage` (ex: "Importar Currículo" ao lado de "Novo").
-   Atualizar `AppRouter`.

## Fluxo de Dados
1.  Usuário seleciona arquivo -> `ResumeImportService` processa.
2.  Retorna `Map<String, dynamic>` com dados sugeridos.
3.  Usuário revisa na `ResumeImportPage`.
4.  Ao salvar, popula os Providers (`PersonalDataNotifier`, `ExperienceList`, etc.).

## Perguntas de Validação
1.  Devo considerar apenas a primeira página do PDF/Imagem para simplificar o MVP? (Assumirei que **sim** para garantir performance e simplicidade inicial).
2.  O foco é mobile (Android/iOS), correto? (ML Kit não roda nativamente em Windows Desktop, então a funcionalidade será desabilitada ou mockada se rodar em desktop).
