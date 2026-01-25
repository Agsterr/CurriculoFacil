# Plano de Implementação: Sistema de Anexos

Implementarei um sistema para gerenciar anexos (foto de perfil e currículo antigo) com foco em armazenamento local seguro e permissões mínimas.

## 1. Infraestrutura e Dependências
- Adicionar `file_picker` ao `pubspec.yaml` para seleção de documentos (PDFs e imagens).
- Verificar e confirmar permissões no `AndroidManifest.xml` (já adequado para `READ_MEDIA_IMAGES` e `READ_EXTERNAL_STORAGE` legado).

## 2. Camada de Dados e Domínio
- **Atualizar Entidade `PersonalData`**: Adicionar campo `oldResumePath` (String?) para armazenar o caminho do currículo antigo.
- **Criar `FileStorageService`**: Serviço centralizado em `lib/core/services/storage/` para:
  - Salvar arquivos na pasta de documentos do app (`getApplicationDocumentsDirectory`).
  - Gerenciar nomes de arquivos únicos.
  - Excluir arquivos antigos quando substituídos.

## 3. Interface de Usuário (Presentation)
- **Nova Página `AttachmentsPage`**:
  - Acessível via novo botão "Anexos" na Home.
  - Seção **Foto de Perfil**: Reutilizar/Mover a lógica do `ProfileImagePicker` para cá ou mantê-la sincronizada.
  - Seção **Currículo Antigo**:
    - Botão "Anexar Currículo (PDF/Img)".
    - Preview do arquivo:
      - Se Imagem: Mostrar miniatura.
      - Se PDF: Mostrar ícone de PDF e nome do arquivo, com botão para abrir (usando `open_file` ou similar, ou apenas indicar que está salvo).
- **Atualizar `ProfileImagePicker`**: Refatorar para usar o novo `FileStorageService`.

## 4. Integração
- Atualizar `PersonalDataNotifier` para lidar com o novo campo `oldResumePath`.
- Adicionar rota `/attachments` no `app_router.dart`.
- Adicionar botão na Home Page.

## 5. Permissões
- O uso de `image_picker` e `file_picker` já lida com as permissões de tempo de execução necessárias. O foco será garantir que o app não peça permissões desnecessárias no manifesto.

## 6. Passos de Execução
1.  Adicionar dependência `file_picker`.
2.  Criar `FileStorageService`.
3.  Atualizar `PersonalData` e seu Provider.
4.  Criar `AttachmentsPage`.
5.  Configurar rota e botão na Home.
6.  Testar fluxo de anexo e persistência.
