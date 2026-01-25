# Implementação do Preview do Currículo em Tempo Real

## 1. Estrutura e Arquivos
- **Criar `resume_preview_page.dart`**: Será a tela principal de visualização.
- **Local**: `lib/features/resume/presentation/pages/resume_preview_page.dart`.
- **Gerenciamento de Estado**: Utilizar `ConsumerWidget` do Riverpod para ouvir `PersonalDataNotifier`, `EducationList`, `ExperienceList` e `SkillList`.

## 2. Layout "Fiel ao PDF" (A4 Design)
Para garantir a fidelidade visual sem usar WebView:
- **Container Principal**: Simular uma folha A4 com fundo branco (`Colors.white`), margens padronizadas (ex: 20px) e sombra suave (`BoxShadow`) para dar profundidade.
- **Tipografia**: Utilizar fontes padrão de impressão (ex: Roboto ou Open Sans) com tamanhos hierárquicos (H1 para Nome, H2 para Títulos de Seção).
- **Estrutura Visual**:
    - **Cabeçalho**: Foto (circular), Nome Completo, Título Profissional, Dados de Contato.
    - **Resumo**: Texto corrido do objetivo profissional.
    - **Experiência**: Lista vertical cronológica (Cargo, Empresa, Período, Descrição).
    - **Educação**: Lista vertical (Curso, Instituição, Ano).
    - **Habilidades**: Chips ou lista com marcadores.

## 3. Otimização e Performance
- **Scroll Vertical**: `SingleChildScrollView` envolvendo o container A4.
- **Reatividade Granular**: O Riverpod atualizará apenas os widgets necessários quando o estado mudar.
- **Widgets Constantes**: Extrair seções (Header, SectionTitle, ExperienceItem) para widgets menores e constantes para evitar rebuilds desnecessários.

## 4. Integração e Navegação
- **Atualizar Roteamento**: Adicionar a rota `/preview` no `app_router.dart`.
- **Acesso**: Adicionar um botão flutuante (`FloatingActionButton`) na `Home` ou um botão na `AppBar` para acessar o preview rapidamente.

## Perguntas para Validação
1. O currículo deve sempre ter fundo branco (estilo papel) mesmo se o app estiver em Dark Mode? (Assumirei que **sim**, pois é "fiel ao PDF").
2. Existe algum layout específico (ex: Coluna dupla vs Coluna única) desejado? (Implementarei **Coluna Única Clássica** por ser mais robusta para MVP).
