O plano a seguir detalha a implementação da geração de currículo em PDF, atendendo aos requisitos de layout profissional, inclusão de foto e funcionalidades de download/compartilhamento.

### 1. Dependências
Adicionar as bibliotecas essenciais para manipulação de PDF e impressão no `pubspec.yaml`:
- `pdf`: Para criação programática do documento.
- `printing`: Para visualização, impressão e compartilhamento nativo.

### 2. Lógica de Negócio (Domain/Service)
Criar `lib/features/resume/domain/services/pdf_service.dart`:
- **Classe `PdfService`**: Responsável por converter o objeto `Resume` em um documento PDF.
- **Funcionalidades**:
  - Carregamento da imagem de perfil (file system).
  - Definição de layout profissional (Header, Colunas, Tipografia).
  - Seções: Cabeçalho (Foto + Dados), Objetivo, Experiência, Educação, Habilidades, Idiomas.
  - Uso de widgets do pacote `pdf` (`pw.MultiPage`, `pw.Column`, `pw.Row`, etc.) para garantir que o conteúdo flua corretamente entre páginas.

### 3. Gerenciamento de Estado (BLoC/Provider)
Criar `lib/features/resume/presentation/bloc/resume_provider.dart`:
- **Objetivo**: Agregar os dados dispersos (Dados Pessoais, Experiência, Educação, Skills) em um único objeto `Resume` atualizado em tempo real.
- Isso garantirá que o PDF gerado reflita sempre o estado atual dos formulários.

### 4. Interface de Usuário (Presentation)
Criar `lib/features/resume/presentation/pages/resume_preview_page.dart`:
- **Widget `ResumePreviewPage`**: Tela dedicada à visualização do PDF.
- **Componente `PdfPreview`**: Exibe o PDF gerado dinamicamente e fornece botões nativos para imprimir e compartilhar (que inclui salvar como arquivo).
- Integração com o `resumeProvider` para obter os dados.

### 5. Navegação e Rotas
Atualizar `lib/config/routes/app_router.dart`:
- Adicionar a rota `/preview` apontando para `ResumePreviewPage`.
- Inserir um ponto de acesso (botão "Visualizar PDF") na tela inicial ou no final do fluxo de edição para permitir o teste imediato da funcionalidade.
