Vou realizar as melhorias solicitadas focando principalmente no template de PDF e em ajustes finos nos formulários.

**Arquitetura Identificada:**
O projeto utiliza um arquivo central de modelos (`lib/models/curriculo_model.dart`) que **já contém** os campos estruturados de endereço (Rua, Cidade, etc.), o que simplifica a tarefa pois não será necessário alterar o banco de dados ou regenerar código.

**Plano Detalhado:**

### 1. Formação Acadêmica (PDF e Form)
- **Formulário:** Renomear rótulos em `EducationFormPage` para clareza: "Área de Estudo" -> "Curso" e "Grau" -> "Tipo de Formação".
- **PDF (`ModernTemplate`):** Inverter a ordem de exibição:
  - **Antes:** Instituição (Negrito) \n Grau (Itálico)
  - **Depois:** Curso – Tipo de Formação (Negrito) \n Instituição (Normal) \n Período

### 2. Dados de Contato (PDF)
- **PDF:** Adicionar rótulos explícitos ("Telefone:", "E-mail:", "LinkedIn:", "Endereço:") antes de cada item na barra lateral.

### 3. Endereço (PDF)
- **PDF:** Otimizar a função `_formatAddress` para exibir os novos campos estruturados (Rua, Número, Bairro, Cidade-UF) de forma legível, garantindo que o CEP apareça de forma discreta ao final.

### 4. Habilidades (Correção de Bug)
- **Diagnóstico:** As habilidades provavelmente estão invisíveis devido ao baixo contraste (texto branco sobre fundo transparente em cima de sidebar colorida) ou problema de layout.
- **Correção:** Ajustar o estilo das "tags" de habilidade no PDF para garantir contraste adequado (ex: fundo branco translúcido com texto na cor principal, ou vice-versa).

### 5. Nome do Currículo
- **PDF:** Remover a exibição de `resume.title` da barra lateral do PDF.

### 6. Validação
- Revisar o código para garantir que todos os campos estão conectados e sendo exibidos.

**Arquivos a serem editados:**
- `lib/core/services/pdf/templates/modern_template.dart` (Layout do PDF)
- `lib/features/resume/presentation/pages/education_form_page.dart` (Rótulos do Form)
