# Currículo Fácil

Aplicativo mobile profissional para **criar, editar e exportar currículos** direto do celular — com suporte offline, reconhecimento de texto e ditado por voz.

---

## O que faz

- Criação guiada de currículo (dados pessoais, experiência, formação, idiomas, habilidades)
- Pré-visualização em tempo real com personalização de estilo
- Exportação em **PDF** para compartilhar ou imprimir
- **OCR** — importar dados de um currículo existente via foto
- **Ditado por voz** — preencher campos falando
- Foto de perfil com recorte
- Múltiplos currículos salvos localmente
- Funciona **offline** (SQLite)

---

## Tecnologias

| Camada | Stack |
|--------|-------|
| Framework | Flutter 3 (Dart) |
| Estado | Riverpod |
| Navegação | go_router |
| Banco local | SQLite (sqflite) |
| PDF | pdf, printing |
| OCR | Google ML Kit |
| Voz | speech_to_text |
| Monetização | Google Mobile Ads, in-app purchase |

---

## Como rodar

### Pré-requisitos

- Flutter SDK 3.2+
- Android Studio ou VS Code com extensão Flutter

### Passos

```bash
git clone https://github.com/Agsterr/CurriculoFacil.git
cd CurriculoFacil
flutter pub get
flutter run
```

Crie um arquivo `.env` na raiz se necessário (veja dependência `flutter_dotenv` no `pubspec.yaml`).

---

## Build para release

```bash
# Android
flutter build apk --release

# Ou App Bundle para Play Store
flutter build appbundle --release
```

---

## Estrutura

```text
lib/
├── features/resume/     # Telas e lógica do currículo
├── models/              # Modelos de dados
├── services/            # Serviços de persistência
├── repositories/        # Repositórios
└── shared/widgets/      # Componentes reutilizáveis
```

---

## Autor

**Agster Junior da Costa Santos** — [GitHub](https://github.com/Agsterr)
