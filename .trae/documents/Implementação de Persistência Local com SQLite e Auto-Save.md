# Plano de Implementação: Sistema de Persistência Local (Offline-First)

Este plano visa implementar um sistema robusto de persistência local utilizando **SQLite**, garantindo que os dados sejam salvos automaticamente, suportem múltiplos currículos e persistam entre sessões.

## 1. Arquitetura de Dados (`lib/core` & `lib/features/resume/data`)
Implementaremos o padrão **Repository** para isolar a lógica de acesso a dados, facilitando a futura integração com backend.

### 1.1. Infraestrutura de Banco de Dados
*   Criar `lib/core/database/database_helper.dart`: Singleton responsável pela conexão com o SQLite.
*   **Esquema Relacional:**
    *   `resumes`: Tabela principal (ID, título, dados pessoais (JSON), estilo (JSON), datas).
    *   `educations`: Tabela filha (ID, resume_id (FK), instituição, curso, datas...).
    *   `experiences`: Tabela filha (ID, resume_id (FK), empresa, cargo, datas...).
    *   `skills`: Tabela filha (ID, resume_id (FK), nome, proficiência...).
    *   `languages`: Tabela filha (ID, resume_id (FK), nome, nível...).
    *   *Nota:* Dados aninhados simples (`PersonalData`, `Style`) serão armazenados como JSON na tabela pai para simplificar, enquanto listas (`Education`, `Experience`) terão tabelas próprias para facilitar edições granulares.

### 1.2. Camada de Dados (Data Layer)
*   **DataSource:** Criar `ResumeLocalDataSource` em `lib/features/resume/data/datasources/` para executar comandos SQL (CRUD).
*   **Repository Impl:** Criar `ResumeRepositoryImpl` em `lib/features/resume/data/repositories/` que implementa a interface do domínio.
*   **Mapeamento:** Utilizar os métodos `.toJson()` e `.fromJson()` já existentes nas entidades Freezed para serialização.

## 2. Camada de Domínio (`lib/features/resume/domain`)
*   **Interface:** Definir `IResumeRepository` em `lib/features/resume/domain/repositories/` com métodos:
    *   `Future<List<Resume>> getAllResumes()`
    *   `Future<Resume> getResume(String id)`
    *   `Future<void> saveResume(Resume resume)` (Upsert: insere ou atualiza)
    *   `Future<void> deleteResume(String id)`

## 3. Gerenciamento de Estado e Reatividade (`lib/features/resume/presentation`)
Atualizaremos o Riverpod para gerenciar o fluxo de dados persistentes.

### 3.1. Providers
*   **`resumeRepositoryProvider`**: Provê a instância do repositório.
*   **`resumeListProvider`**: Gerencia a lista de currículos disponíveis na "Home".
*   **`currentResumeProvider`**: Gerencia o currículo atualmente em edição.
    *   **Auto-Save Inteligente:** Implementar lógica de *debounce* (atraso de ~1s após a última edição) para salvar no banco automaticamente sem travar a UI.

### 3.2. Integração com a UI
*   Ajustar `EducationProvider`, `ExperienceProvider`, etc., para atualizar o `currentResumeProvider`.
*   Na tela inicial, carregar a lista de currículos ao iniciar.

## 4. Etapas de Execução
1.  **Configuração:** Configurar `DatabaseHelper` e scripts SQL.
2.  **Camada de Dados:** Implementar DataSource e Repository.
3.  **Integração:** Criar/Atualizar Providers e conectar com a UI.
4.  **Validação:** Testar criação, edição, fechamento do app e reabertura para confirmar persistência.

## Perguntas/Validações
*   *Backend Futuro:* A estrutura proposta (Repository + IDs UUID) já deixa o app 100% pronto para sincronização com API REST/GraphQL.
*   *Dados Pessoais:* Armazenar `PersonalData` como JSON na tabela `resumes` é aceitável para você? (Simplifica a query e não perde flexibilidade).
