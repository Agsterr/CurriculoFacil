# Plano de Adequação para Play Store (Permissões e Privacidade)

Este plano visa garantir a aprovação do app **Curriculo Facil** na Play Store, focando no uso correto e justificado de permissões sensíveis (Câmera e Microfone), além de limpar solicitações desnecessárias que podem causar rejeição.

## 1. Limpeza e Otimização do `AndroidManifest.xml`
O manifesto atual possui duplicações e permissões de alto risco (Bluetooth) que precisam ser revistas.
- **Remover Duplicatas:** A permissão `RECORD_AUDIO` aparece duas vezes.
- **Tratar Bluetooth:** As permissões `BLUETOOTH`, `BLUETOOTH_ADMIN` e `BLUETOOTH_CONNECT` são frequentemente motivo de rejeição se o app não for um utilitário de bluetooth. O pacote `speech_to_text` pode funcionar sem elas para uso básico. Sugiro removê-las ou torná-las opcionais, a menos que o suporte a fone Bluetooth seja crítico.
- **Adicionar `uses-feature`:** Declarar que o app usa câmera e microfone, mas (opcionalmente) não *exige* hardware se o app puder funcionar sem eles (evita restrição de dispositivos).

## 2. Implementação de "Rationale UI" (Justificativa Prévia)
O Google exige que o usuário saiba *por que* uma permissão é pedida *antes* do sistema exibir o pop-up padrão.
- **Ação:** Criar um `PermissionDialog` reutilizável.
- **Fluxo:** 
  1. Usuário clica no microfone.
  2. App verifica status.
  3. Se negado ou permanente negado -> Exibe Explicação ("Precisamos do microfone para preencher sua experiência por voz").
  4. Se aceito no Dialog -> Solicita ao sistema.

## 3. Refatoração da Lógica de Permissões
Atualmente, o `ExperienceFormPage.dart` inicializa o `speech_to_text` diretamente.
- **Ação:** Blindar a chamada do `_initSpeech` com uma verificação explícita do `permission_handler`.
- **OCR:** Como não encontrei código de OCR ativo, assumirei que é um uso futuro ou integrado à Câmera (foto de currículo antigo). A permissão de Câmera será tratada de forma similar ao Microfone.

## 4. Textos para Política de Privacidade e Play Console
Fornecerei os textos exatos para preencher o formulário "Acesso a apps" e "Segurança dos dados" no Google Play Console.

---

### Perguntas para Validação
1. **Bluetooth:** O uso de fones Bluetooth para o ditado é *essencial*? Se não, podemos remover as permissões de Bluetooth para facilitar a aprovação?
2. **OCR:** O recurso de OCR mencionado é apenas a captura da foto (para uso futuro) ou existe alguma lib específica que devo procurar? (No momento, só vejo `image_picker`).
3. **Versão Android:** O `minSdkVersion` não foi verificado, mas assumo que suportamos Android 6.0+ (API 23). Confere?
