# Guia de Privacidade e Permissões (Play Store)

Este documento contém os textos e orientações para preencher as seções de "Conteúdo do App" e "Segurança dos Dados" no Google Play Console.

## 1. Permissões Sensíveis (App Content)

### Acesso à Câmera (Camera)
**Justificativa:**
"O aplicativo utiliza a câmera exclusivamente para permitir que o usuário capture uma foto para incluir em seu currículo. A imagem é processada localmente e não é compartilhada com terceiros."

### Acesso ao Microfone (Record Audio)
**Justificativa:**
"O aplicativo utiliza o microfone para o recurso de 'Ditado', permitindo que o usuário descreva suas experiências profissionais por voz, convertendo a fala em texto automaticamente. O áudio não é gravado permanentemente nem enviado para servidores proprietários, sendo processado pelo serviço de reconhecimento de voz do sistema operacional."

---

## 2. Segurança dos Dados (Data Safety)

Ao preencher o formulário de Segurança dos Dados:

### Coleta e Compartilhamento
*   **O app coleta ou compartilha dados?**
    *   Sim (devido ao uso de bibliotecas de terceiros como AdMob, se ativo, e serviços do sistema).
    *   *Nota:* Para Câmera e Microfone especificamente, se os dados não saem do dispositivo (ficam no SQLite local), você pode marcar que não são coletados "off-device" para fins de servidor próprio, mas o reconhecimento de voz do Google pode transmitir dados.
    *   **Recomendação Segura:** Declare que há "Coleta" (Ephemeral Processing) para funcionalidade do app.

### Tipos de Dados
1.  **Áudio (Voz):**
    *   **Coletado?** Sim (Ephemeral - processamento momentâneo).
    *   **Compartilhado?** Não (a menos que considere o envio para o motor de TTS do Google como compartilhamento, mas geralmente é "System Service").
    *   **Finalidade:** Funcionalidade do App (Preenchimento de formulário).
2.  **Fotos e Vídeos:**
    *   **Coletado?** Sim (Armazenamento Local).
    *   **Finalidade:** Funcionalidade do App (Foto de perfil).

---

## 3. Política de Privacidade (Texto Sugerido)

Adicione este parágrafo à sua política de privacidade (URL):

> **Uso da Câmera e Microfone**
> 
> **Câmera:** Nosso aplicativo solicita acesso à câmera do seu dispositivo com o único propósito de permitir que você capture e recorte uma foto para ser exibida em seu currículo gerado. Esta imagem é armazenada localmente no seu dispositivo e não é enviada para nossos servidores.
>
> **Microfone:** Solicitamos acesso ao microfone para habilitar a funcionalidade de "Digitação por Voz", facilitando o preenchimento de campos de texto longos (como descrição de experiências). O áudio capturado é processado pelo motor de reconhecimento de fala do seu sistema operacional e convertido em texto em tempo real. Não armazenamos gravações de áudio.

---

## 4. Checklist de Aprovação

- [x] **Manifesto Limpo:** Permissões de Bluetooth removidas e `uses-feature` adicionado.
- [x] **Justificativa Prévia (Rationale):** O app agora exibe um diálogo explicando o motivo *antes* de pedir a permissão do sistema (Câmera e Microfone).
- [x] **Tratamento de Negação:** Se o usuário negar permanentemente, o app orienta a ir nas configurações.
