# Arquitetura do Projeto Currículo Fácil

Este projeto segue a **Clean Architecture** adaptada para Flutter, priorizando modularidade, testabilidade e escalabilidade.

## 📦 Estrutura de Pastas

```
lib/
├── config/             # Configurações globais (Rotas, Env)
├── core/               # Código compartilhado entre features
│   ├── constants/      # Strings, assets paths
│   ├── errors/         # Tratamento de erros (Failure classes)
│   ├── services/       # Serviços externos (Monetização, Analytics)
│   ├── theme/          # Estilos e Design System
│   └── utils/          # Funções auxiliares puras
├── features/           # Módulos funcionais (ex: resume, settings)
│   └── resume/         # Feature: Criação de Currículo
│       ├── data/       # Camada de Dados (Repos, DTOs, Datasources)
│       ├── domain/     # Camada de Domínio (Entities, Usecases)
│       └── presentation/ # Camada de UI (Pages, Widgets, Controllers)
├── shared/             # Widgets reutilizáveis em múltiplos módulos
└── main.dart           # Ponto de entrada
```

## 🛠 Tecnologias Principais

- **Gerenciamento de Estado:** `flutter_riverpod` + `riverpod_generator` (Moderno, seguro e sem boilerplate).
- **Navegação:** `go_router` (Deep linking e rotas declarativas).
- **Imutabilidade:** `freezed` + `json_serializable`.
- **Monetização:** Interface pronta em `core/services/monetization_service.dart`.
- **Segurança:** `flutter_dotenv` para chaves sensíveis.

## 🚀 Como Iniciar

1. **Configurar Ambiente:**
   - Copie `.env.example` para `.env`
   - Preencha as chaves (AdMob, etc).

2. **Gerar Código:**
   Execute o build runner para gerar providers e models:
   ```bash
   dart run build_runner build -d
   ```

3. **Rodar o App:**
   ```bash
   flutter run
   ```

## ⚠️ Notas Importantes

- **Package Name:** `com.focodevsistemas.curriculofacil` (Definitivo).
- **Segurança:** Nunca commite o arquivo `.env`.
- **Offline-First:** A arquitetura está preparada para repositórios locais (`sqflite` ou `isar`).
