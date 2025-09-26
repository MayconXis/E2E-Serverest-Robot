# 🚀 ServeRest QA Automação Robot Framework Express/Browser

Este projeto foi produzido em squad e consiste na implementação de testes automatizados **Web UI** para a aplicação **ServeRest** (disponível em `https://compassuolfront.serverest.dev/`), utilizando o **Robot Framework** e a **Browser Library (Playwright)**.

O objetivo é validar os fluxos críticos de negócio, como cadastro de usuários, login, gerenciamento de produtos e manipulação da lista de compras, seguindo as boas práticas de automação e a metodologia QAlity.

## 🛠️ Requisitos e Tecnologias

| Tecnologia | Descrição |
| :--- | :--- |
| **Robot Framework** | Framework de automação principal. |
| **Browser Library** | Utilizada para automação Web UI (baseada em Playwright). |
| **Python** | Linguagem de execução. |
| **JSONLibrary** | Para manipulação eficiente de arquivos de dados (fixtures). |
| **FakerLibrary** | Para geração de dados dinâmicos em alguns cenários. |

---

## 📐 Estrutura do Projeto

O projeto adota uma arquitetura modular baseada em **Keyword-Driven Testing** e no conceito de **Page Objects** (via arquivos `resource`).

### 📂 Arquivos de Configuração e Utilitários

| Arquivo/Diretório | Descrição |
| :--- | :--- |
| `resources/env.resource` | Define as **URLs base** para a aplicação Web (`${BASE_URL}`) e a API (`${API_URL}`). |
| `resources/base.resource` | O ponto central, importando bibliotecas essenciais e definindo keywords de setup global como **`Start Session`** e **`Get Fixtures`** (para carregar dados de teste). |
| `resources/fixtures/` | Contém os arquivos **JSON de *fixtures*** com dados de teste (`users.json`, `products.json`, etc.). |

### 📄 Arquivos de Páginas e Componentes

| Arquivo | Palavras-Chave (Keywords) Principais | Foco |
| :--- | :--- | :--- |
| `resources/pages/LoginPage.resource` | **`Submit Login Form`** e **`User Should Be Logged In`**. | Ações e validações da tela de Login. |
| `resources/cadastroKeyword.resource` | **`Criar Usuario Dinamico`**, **`Criar Usuario Estatico`**, e cenários de e-mail inválido. | Fluxos de Cadastro de Usuário e validação de regras. |
| `resources/components/Alert.resource` | **`ALert should be`**. | Validação de mensagens de erro ou sucesso em caixas de alerta. |
| `resources/components/Notice.resource` | **`Notice should be`** e **`Notice should be email sem @`**. | Validação de mensagens de *notice* e erros específicos de input. |
| `resources/backup/pages.resource` | **`Go To signup page`** e **`Go to signup form`**. | Keywords para navegação estruturada. |
| `resources/pages/ProductPage.resource` | **`Setup Suite Environment`**. | Setup de ambiente que usa a API para criar/deletar dados e faz login UI, garantindo pré-condições. |

---

## 💻 Casos de Teste Implementados

Os casos de teste estão divididos logicamente em arquivos `.robot` cobrindo diferentes áreas da aplicação.

### 1. `online.robot`

| Test Case | Descrição |
| :--- | :--- |
| **`Serverest deve estar online`** | Inicia a sessão e verifica se o título da página é **"Front - ServeRest"**. |

### 2. `cadastro.robot`

| Test Case | Descrição |
| :--- | :--- |
| **`Cadastrar Usuario dinamico com sucesso`** | Utiliza dados dinâmicos gerados pelo keyword **`Criar Usuario Dinamico`**. |
| **`Cadastrar Usuario Estatico`** | Realiza o cadastro utilizando dados estáticos. |
| **`Cadastrar Usuario com email duplicado`** | Tenta submeter o mesmo usuário estático duas vezes e verifica o alerta **"Este email já está sendo usado"**. |
| **`Verificar Campos obrigatorios vazios no formulario de cadastro`** | Tenta submeter o formulário vazio, validando que as mensagens de **Nome é obrigatório**, **Email é obrigatório** e **Password é obrigatório** são exibidas. |
| **`Verificar Cadastro com email incorreto sem @`** | Testa a validação de formato de e-mail inválido, sem o caractere `@`. |
| **`Verificar Cadastro com email incorreto`** | Testa a validação de formato de e-mail inválido, esperando o alerta **"Email deve ser um email válido"**. |

### 3. `login.robot`

| Test Case | Descrição |
| :--- | :--- |
| **`Deve validar login com sucesso`** | Cadastra um usuário dinamicamente e, em seguida, realiza o login com sucesso. |
| **`Não deve cadastrar email duplicado`** | Executa o fluxo de registro de um e-mail duplicado, validando a mensagem de erro. |

### 4. `produto.robot`

| Test Case | Descrição |
| :--- | :--- |
| **`Fazer cadastro como administrador`** | Realiza o cadastro de um novo usuário, marcando a opção para registrar como administrador. |
| **`Login no site e criação de um produto`** | Efetua o login com o admin e realiza o cadastro de um novo produto (Teclado). |

### 5. `produtos.robot`

| Test Case | Descrição |
| :--- | :--- |
| **`Deve excluir produto`** | Efetua login, navega para a listagem de produtos, clica no botão de exclusão e verifica a ausência do produto **"Teclado"**. |
| **`Deve Clicar no Botão Editar`** | Efetua login, navega para a listagem de produtos e clica no botão de edição para o produto **"Mouse"**. |

### 6. `product_list.robot`

| Test Case | Descrição |
| :--- | :--- |
| **`Deve adicionar um produto a Lista de Compras`** | Adiciona o produto configurado no **`Setup Suite Environment`** à lista de compras e verifica a sua presença. |
| **`Deve limpar a lista de produtos`** | Navega para a lista de compras, limpa a lista e verifica a mensagem **"Seu carrinho está vazio"**. |
