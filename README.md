# Karate-DSL - Projeto de Testes de API

Projeto de automação de testes de API utilizando **Karate DSL**, um framework baseado em Gherkin para testes de APIs REST.

## 📋 Sobre o Projeto

Este projeto implementa testes automatizados para APIs REST usando Karate DSL, proporcionando:
- Testes de API simples e expressivos em linguagem Gherkin
- Validação de respostas HTTP
- Testes de integração
- Geração de relatórios detalhados

## 🛠️ Tecnologias

- **Java** - Linguagem de programação
- **Maven** - Gerenciador de dependências e build
- **Karate DSL** - Framework de testes de API
- **JUnit** - Framework de testes

## 📦 Estrutura do Projeto

```
karate-desafio/
├── pom.xml                 # Configuração Maven
├── src/
│   └── test/              # Testes e features do Karate
└── target/                # Artefatos compilados
    ├── classes/           # Classes compiladas
    ├── features/          # Features geradas
    └── karate-reports/    # Relatórios dos testes
```

## 🚀 Como Executar

### Pré-requisitos
- Java 8 ou superior instalado
- Maven 3.6+ instalado

### Instalação e Execução

1. **Clone o repositório:**
```bash
git clone <seu-repositorio>
cd karate-desafio
```

2. **Execute os testes:**
```bash
mvn test
```

3. **Execute um teste específico:**
```bash
mvn test -Dtest=NomeDaClasse
```

## 📊 Relatórios

Os relatórios dos testes são gerados automaticamente em:
```
target/karate-reports/
```

Abra o arquivo `index.html` em um navegador para visualizar os resultados completos.

## 📝 Escrevendo Testes

Os testes são definidos em arquivos `.feature` usando Gherkin:

```gherkin
Feature: Teste de API

  Scenario: Exemplo de teste
    Given url 'https://api.example.com'
    When method GET
    Then status 200
```

## 🔧 Configuração Maven

O projeto está configurado com Maven (veja [pom.xml](pom.xml)) e inclui:
- Plugin Karate para execução de testes
- Dependências necessárias para testes de API

## 📚 Documentação

Para mais informações sobre Karate DSL, visite:
- [Documentação Oficial](https://karatelabs.github.io/karate/)

---