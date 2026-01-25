# Plano de Preparação para Google Play Store

Este plano visa preparar o aplicativo `com.focodevsistemas.curriculofacil` para publicação, cobrindo configuração de ícone, permissões, assinatura digital e geração do AAB.

## 1. Diagnóstico e Perguntas Prévias
Antes de alterar os arquivos, preciso confirmar alguns pontos cruciais:

1.  **Logotipo:** Você possui um arquivo de imagem (ex: `logo.png`, idealmente 1024x1024px) para ser usado como ícone do app? Se não, usarei um placeholder ou o ícone padrão do Flutter por enquanto.
2.  **AdMob ID:** Notei a dependência `google_mobile_ads`, mas o `AndroidManifest.xml` está sem o ID do AdMob (o que causa crash). Você tem o ID real do AdMob ou devo configurar com o ID de Teste do Google?
3.  **Assinatura (Keystore):** Você já possui um arquivo `.jks` (chave de upload) gerado? O plano incluirá a configuração para ler essa chave, mas não gerarei a chave em si (pois é um segredo).
4.  **Política de Privacidade:** Para apps que usam Câmera/Galeria, o Google exige uma URL de política de privacidade. Você já tem essa URL para inserirmos no cadastro da loja depois?

## 2. Implementação Técnica

### Fase 1: Branding e Identidade
*   **Ação:** Adicionar a dependência `flutter_launcher_icons` (dev_dependency).
*   **Ação:** Criar configuração no `pubspec.yaml` apontando para o ícone (assumindo `assets/images/icon.png` ou similar).
*   **Ação:** Rodar o gerador de ícones para substituir o ícone padrão do Android.

### Fase 2: Correção do Manifesto (AndroidManifest.xml)
*   **Correção Crítica:** Adicionar a tag `<meta-data>` com o ID do AdMob (obrigatório para apps com anúncios).
*   **Permissões:**
    *   Manter `CAMERA` e `INTERNET`.
    *   Adicionar permissões de leitura de galeria (`READ_MEDIA_IMAGES` para Android 13+ e `READ_EXTERNAL_STORAGE` para anteriores) para evitar problemas com o `image_picker` em alguns dispositivos.
    *   Adicionar `com.google.android.gms.permission.AD_ID` (necessário para anúncios).

### Fase 3: Configuração de Assinatura (Signing)
*   **Ação:** Modificar `android/app/build.gradle` para ler as configurações de assinatura de um arquivo `key.properties` (prática segura).
*   **Ação:** Configurar o `buildType` de `release` para usar essa configuração de assinatura em vez da `debug`.
*   **Ação:** Criar um arquivo `.env.example` ou `key.properties.example` para documentar o que é necessário.

### Fase 4: Otimização e Build
*   **Ação:** Habilitar `minifyEnabled true` e `shrinkResources true` no `build.gradle` para reduzir o tamanho do AAB e ofuscar o código (R8).
*   **Ação:** Executar o comando de build final: `flutter build appbundle`.

## 3. Entregáveis
1.  Aplicativo configurado com ícone e nome corretos.
2.  Arquivo AAB (`app-release.aab`) pronto para upload.
3.  Relatório de "Erros Comuns e Boas Práticas" (checklist para evitar reprovação).
