# Implementação de Geração de PDF com OCR e Voz

Este plano detalha as etapas para implementar a geração de PDF com suporte a OCR, entrada de voz, foto de perfil e layout consistente.

## 1. Configuração e Dependências
- **Adicionar Dependência**: Incluir `google_mlkit_text_recognition` no `pubspec.yaml` para funcionalidade de OCR.
- **Verificar Dependências**: Confirmar se `speech_to_text`, `image_picker`, `pdf`, `printing` e `share_plus` estão corretamente configurados (já identificados).

## 2. Implementação do OCR
- **Criar Serviço**: Implementar `OCRService` em `lib/core/services/ocr/ocr_service.dart` para encapsular a lógica de reconhecimento de texto.
- **Criar Widget**: Desenvolver `OCRButton` ou integrar ao `SpeechTextField` para permitir escanear texto de imagens diretamente para os campos de formulário.

## 3. Refatoração e Entrada de Dados
- **Padronizar Voz**: Refatorar `ExperienceFormPage` para usar o widget reutilizável `SpeechTextField` em vez de lógica duplicada.
- **Integrar OCR**: Adicionar funcionalidade de OCR aos formulários de Experiência e Educação (úteis para digitalizar certificados ou documentos antigos).
- **Foto de Perfil**: Garantir que a `PersonalDataPage` salve corretamente o caminho da foto no `Resume`.

## 4. Aprimoramento da Geração de PDF
- **Template Clássico**: Atualizar `ClassicTemplate` para suportar a exibição de foto de perfil (atualmente ausente), respeitando a configuração `showPhoto`.
- **Validação de Template Moderno**: Confirmar o funcionamento da renderização de imagem no `ModernTemplate` (já implementado, mas validar consistência).

## 5. Validação
- **Testes Manuais**: Verificar o fluxo completo:
    1.  Entrada de dados por voz e OCR.
    2.  Seleção de foto.
    3.  Geração de PDF (Preview).
    4.  Download e Compartilhamento.
