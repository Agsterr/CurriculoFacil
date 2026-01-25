# Plano de Implementação: Dados Pessoais com Entrada de Voz

Vou aprimorar a tela de Dados Pessoais (`PersonalDataPage`) para suportar preenchimento automático via voz e manter a robustez do cadastro manual.

## 1. Dependências e Permissões
*   **Adicionar:** `speech_to_text` (para reconhecimento de fala).
*   **Permissões:** Adicionar `RECORD_AUDIO` no `AndroidManifest.xml`.

## 2. Lógica de Preenchimento por Voz (Smart Parser)
Implementarei um parser heurístico que processa o texto falado e extrai:
*   **E-mail:** Busca padrões como `texto@dominio.com` (tratando "arroba" se necessário, mas o STT do Google/iOS geralmente já converte).
*   **Telefone:** Busca sequências numéricas compatíveis com formatos BR (ex: 11 99999-9999).
*   **Nome:** Assume que o texto restante (removendo saudações como "Meu nome é...") corresponde ao nome do usuário.

## 3. Alterações na Interface (`PersonalDataPage`)
*   **Novo Componente:** Adicionar um botão de ação "Preencher por Voz" (ícone de microfone) no topo ou flutuante.
*   **Feedback Visual:** Indicador de "Ouvindo..." com animação ou texto simples.
*   **Integração:** Ao finalizar a fala, o parser roda e preenche os `TextFormField`s automaticamente.
*   **Fallback:** Os campos continuam editáveis manualmente para correções.

## 4. Imagem de Perfil
*   O componente `ProfileImagePicker` já existe e suporta Câmera/Galeria + Crop. Vou apenas garantir que ele esteja bem posicionado e funcional dentro do formulário.

## Roteiro de Execução
1.  Adicionar `speech_to_text` via `pub add`.
2.  Atualizar `AndroidManifest.xml`.
3.  Modificar `PersonalDataPage.dart`:
    *   Instanciar `SpeechToText`.
    *   Criar método `_listen()` e `_parseAndFill()`.
    *   Adicionar botão de microfone na UI.
    *   Conectar campos aos controladores para refletir as mudanças do preenchimento automático.
4.  Validar o fluxo (Manual + Voz + Foto).
