# Plano de Implementação: Sistema de Templates de Currículo

Vou implementar um sistema robusto de geração de currículos em PDF, utilizando o padrão **Strategy** para os templates, facilitando a adição futura de novos layouts.

## 1. Infraestrutura e Dependências
- Adicionar pacotes essenciais ao `pubspec.yaml`:
  - `pdf`: Para criação do documento e elementos gráficos.
  - `printing`: Para pré-visualização nativa e compartilhamento.

## 2. Domínio e Modelagem
- **Nova Entidade `ResumeStyle`**: Criar uma classe para armazenar as preferências visuais do currículo:
  - `templateId` (Identificador do layout)
  - `primaryColor` (Cor de destaque)
  - `fontFamily` (Tipografia escolhida)
- **Atualizar Entidade `Resume`**: Adicionar o campo `style` (do tipo `ResumeStyle`) à entidade principal para persistir as escolhas do usuário.

## 3. Motor de Templates (Strategy Pattern)
Criarei uma camada de serviço dedicada à geração de PDF (`lib/core/services/pdf/`), desacoplada da UI:
- **`ResumeTemplate` (Interface)**: Contrato que todos os templates devem seguir.
- **Implementações Iniciais**:
  - `ModernTemplate`: Layout com barra lateral colorida e foto em destaque.
  - `ClassicTemplate`: Layout tradicional, sóbrio e sem fotos grandes.
- **`PdfGeneratorService`**: Serviço que recebe os dados do currículo e o template escolhido para gerar o binário do PDF.

## 4. Interface de Usuário (Presentation)
- **`ResumePreviewPage`**: Nova tela com divisão funcional:
  - **Área de Preview**: Exibição do PDF em tempo real usando o widget `PdfPreview`.
  - **Painel de Controle**:
    - Seletor de Template (Carrossel ou Lista).
    - Seletor de Cores (Paleta pré-definida).
    - Toggle para exibir/ocultar foto.
- **Integração com Bloc/Riverpod**: Atualizar o estado do preview instantaneamente ao mudar as configurações.

## 5. Passos de Execução
1.  Instalar dependências (`pdf`, `printing`).
2.  Criar as classes de domínio (`ResumeStyle`) e atualizar `Resume`.
3.  Implementar a interface de templates e 2 layouts iniciais.
4.  Criar a página de Preview com os controles de personalização.
5.  Configurar a navegação no `app_router.dart`.
