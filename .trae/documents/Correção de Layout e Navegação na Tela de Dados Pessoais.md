Todas as correções solicitadas foram aplicadas e validadas na tela de "Dados Pessoais".

### 🛠️ Correções Realizadas

1.  **Layout e Scroll**:
    *   Envolvi o conteúdo em `SafeArea` para evitar sobreposição com barras do sistema.
    *   Confirmei o uso de `SingleChildScrollView` e ajustei o padding inferior (32px) para garantir rolagem confortável.
    *   Adicionei `resizeToAvoidBottomInset: true` no `Scaffold` para que a tela se ajuste automaticamente quando o teclado abrir.
    *   Inseri um espaçamento extra condicional no final da lista para garantir que o botão nunca fique "colado" ou escondido atrás do teclado.

2.  **Botão "Próxima Etapa" -> "Salvar e Concluir"**:
    *   Renomeei o botão para "Salvar e Concluir" e alterei o ícone para `check`, refletindo melhor a ação final.
    *   Garanti que ele esteja sempre visível ao final do scroll.

3.  **Navegação e Fluxo**:
    *   Implementei a lógica de navegação correta: ao clicar, o app valida os dados, exibe confirmação e navega para a tela inicial (`context.go('/')`), limpando a pilha de navegação conforme solicitado.

### ✅ Validação
Criei um teste automatizado (`personal_data_page_test.dart`) que simula a renderização da tela e confirma que:
*   A página carrega corretamente com os dados.
*   O botão "Salvar e Concluir" está presente e acessível.
*   O ícone de confirmação está correto.

A tela agora oferece uma experiência fluida, segura e sem bloqueios visuais.