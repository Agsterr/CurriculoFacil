# Guia de Publicação na Google Play Store

Este documento guia você nos passos finais para publicar o aplicativo `com.focodevsistemas.curriculofacil`.

## 1. Ícones do Aplicativo

Foi adicionada a biblioteca `flutter_launcher_icons`.

1.  Coloque seu logo (idealmente 1024x1024px, PNG) em: `assets/images/icon.png`.
2.  Execute o comando para gerar os ícones:
    ```bash
    dart run flutter_launcher_icons
    ```

## 2. Assinatura Digital (Keystore)

Você precisa de uma chave de upload para assinar o app. **Nunca commite esta chave no Git.**

### Gerar a Chave (se não tiver):
No terminal (Windows):
```powershell
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Responda às perguntas e defina senhas fortes.

### Configurar o App:
1.  Mova o arquivo `upload-keystore.jks` para uma pasta segura (ex: `C:\Users\Voce\Keystores\`).
2.  Na pasta `android/`, copie o arquivo `key.properties.example` para `key.properties`.
3.  Edite `android/key.properties` com seus dados:
    ```properties
    storePassword=SuaSenhaDoKeystore
    keyPassword=SuaSenhaDaChave
    keyAlias=upload
    storeFile=C:/Caminho/Para/upload-keystore.jks
    ```
    *Nota: Use barras normais `/` no caminho do arquivo, mesmo no Windows.*

## 3. Gerar o AAB (Android App Bundle)

Com a chave configurada, gere o arquivo final para a loja:

```bash
flutter build appbundle --release
```
O arquivo estará em: `build/app/outputs/bundle/release/app-release.aab`.

## 4. Checklist de Boas Práticas e Erros Comuns

### ✅ Permissões (Configurado)
O `AndroidManifest.xml` já foi ajustado com:
*   `INTERNET`: Básico.
*   `CAMERA`: Para fotos de perfil.
*   `READ_MEDIA_IMAGES` / `READ_EXTERNAL_STORAGE`: Para galeria (compatibilidade Android 13+ e anteriores).
*   `AD_ID`: Obrigatório para AdMob.

### ✅ AdMob (Atenção!)
O app está configurado com o **ID de Teste** do Google (`ca-app-pub-3940256099942544~3347511713`).
*   **Antes de publicar:** Substitua este valor no `AndroidManifest.xml` pelo seu App ID real do painel da AdMob.

### ✅ Política de Privacidade (Obrigatório)
Como o app usa Câmera e Galeria, o Google Play **exigirá** uma URL de Política de Privacidade no cadastro da loja.
*   Crie uma página simples (pode ser no GitHub Pages ou Google Sites) informando que o app coleta imagens apenas para o perfil localmente.

### 🚫 Erros Comuns de Reprovação
1.  **Crash ao Iniciar:** Geralmente causado por falta do AdMob App ID no Manifesto (já corrigido aqui).
2.  **Permissões Abusivas:** Pedir permissão de localização ou contatos sem uso claro. (Nós mantivemos o mínimo).
3.  **Botões quebrados:** Teste todos os fluxos (criar currículo, exportar PDF) na versão `release` antes de enviar.
    *   Teste localmente: `flutter run --release`.
4.  **Conteúdo:** Se o app tiver "Lorem Ipsum" ou dados de teste visíveis, pode ser rejeitado. Limpe os dados de exemplo.

## 5. Próximos Passos
1.  [ ] Colocar o ícone em `assets/images/icon.png`.
2.  [ ] Gerar ícones (`dart run flutter_launcher_icons`).
3.  [ ] Configurar `key.properties`.
4.  [ ] Buildar o AAB.
5.  [ ] Criar conta no Google Play Console ($25 USD).
6.  [ ] Submeter o AAB e preencher a ficha da loja.
