# Plano de Correção e Unificação dos Providers

A análise revelou que os erros (`The setter 'state' isn't defined`) ocorrem porque o arquivo gerado `resume_providers.g.dart` ainda não foi criado ou atualizado pelo `build_runner`. Além disso, identificamos um conflito potencial entre a implementação antiga (`resume_provider.dart`) e a nova (`resume_providers.dart`).

## Diagnóstico
1.  **Erro de Compilação:** A classe `CurrentResume` depende de `_$CurrentResume` (gerado automaticamente). Como o arquivo `.g.dart` está ausente ou desatualizado, o mixin não é aplicado, e a propriedade `state` fica indisponível.
2.  **Conflito de Nomes:** Existem dois arquivos definindo `currentResumeProvider`:
    *   `resume_provider.dart` (Legado): Define manualmente um `Provider<Resume>`.
    *   `resume_providers.dart` (Novo): Gera automaticamente um `AutoDisposeNotifierProvider<CurrentResume, Resume?>` (também nomeado `currentResumeProvider` pelo gerador).
3.  **Uso em `resume_preview_page.dart`:** A página de pré-visualização ainda importa o provider antigo.

## Perguntas para Validação
1.  O comando `build_runner` que está rodando no terminal apresentou algum erro específico ou apenas ainda não finalizou?
2.  Podemos remover o arquivo legado `resume_provider.dart` para evitar conflitos de importação?
3.  Devemos atualizar a `ResumePreviewPage` para utilizar o novo `CurrentResume` (que retorna `Resume?` e permite edição centralizada)?
4.  A intenção é que o `CurrentResume` substitua os providers individuais (como `personalDataNotifierProvider`) na gestão do estado de edição?

## Roteiro de Execução Proposto
1.  **Aguardar/Executar Build Runner:** Garantir que a geração de código complete com sucesso.
2.  **Remover Legado:** Excluir `lib/features/resume/presentation/bloc/resume_provider.dart`.
3.  **Refatorar Consumidores:**
    *   Atualizar `resume_preview_page.dart` para importar `resume_providers.dart`.
    *   Tratar o estado `null` do currículo (exibir "Carregando" ou mensagem de erro se nenhum currículo estiver selecionado).
4.  **Verificação:** Confirmar se os erros de `state` desapareceram e se a pré-visualização funciona.
