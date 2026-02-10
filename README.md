# 🚀 Curso de DBT com DuckDB

Ambiente simplificado e pronto para uso de **DBT (Data Build Tool)** com **DuckDB** para aprendizado e prática. Este repositório contém exemplos progressivos que vão do básico ao intermediário, perfeito para quem está começando com DBT.

## 📋 O que é este projeto?

Este é um ambiente Docker completo que permite você aprender e praticar DBT sem precisar configurar nada manualmente. Com apenas um comando, você terá:

- ✅ DBT instalado e configurado
- ✅ DuckDB como banco de dados (sem necessidade de servidor)
- ✅ Dados de exemplo pré-carregados
- ✅ 3 exemplos progressivos de uso
- ✅ Interface gráfica para visualizar documentação e lineage

## 🎯 Exemplos Incluídos

O projeto contém **3 exemplos progressivos**:

### 1. **Hello World** (`01_hello_world.sql`)
O exemplo mais simples possível: um modelo que retorna uma mensagem e a data/hora atual. Perfeito para entender a estrutura básica de um modelo DBT.

```sql
select
  'Hello dbt + DuckDB' as message,
  current_timestamp as created_at
```

### 2. **Exemplo Prático** (`stg_usuarios.sql` e `stg_vendas.sql`)
Modelos de staging que fazem transformações básicas nos dados:
- **`stg_usuarios`**: Limpa e tipa dados de usuários
- **`stg_vendas`**: Limpa e tipa dados de vendas

Demonstra conceitos de:
- Uso de `{{ ref() }}` para referenciar seeds
- Casting de tipos
- Filtros básicos (`where email is not null`)

### 3. **Exemplo Intermediário** (`fct_vendas_por_usuario.sql`)
Um modelo de marts (camada analítica) que:
- Combina dados de usuários e vendas
- Calcula métricas agregadas (total de vendas, receita total)
- Demonstra relacionamentos entre tabelas
- Usa CTEs (Common Table Expressions)
- Ordena resultados

## 🛠️ Pré-requisitos

- **Docker** e **Docker Compose** instalados
- Acesso à internet (para baixar a imagem na primeira vez)

## 🚀 Como Usar

### 1. Clone o repositório

```bash
git clone <url-do-repositorio>
cd Intro_DBT_duckdb_DEH
```

### 2. Suba o ambiente

```bash
docker compose up -d --build
```

Este comando irá:
- Construir a imagem Docker com DBT e DuckDB
- Criar e iniciar o container
- Montar o diretório `dbt/` no container

### 3. Execute os exemplos

Entre no container e execute os comandos DBT:

```bash
# Entrar no container
docker compose exec dbt bash

# Dentro do container, executar:
dbt seed    # Carrega os dados de exemplo (CSVs)
dbt run     # Executa todos os modelos
dbt docs generate  # Gera a documentação
```

Ou execute tudo de uma vez:

```bash
docker compose exec dbt bash -lc "dbt seed && dbt run && dbt docs generate"
```

### 4. Visualize a Interface Gráfica

Para ver a documentação e o grafo de dependências (lineage):

```bash
docker compose exec dbt bash -lc "dbt docs serve --host 0.0.0.0 --port 8080"
```

Depois acesse no navegador: **http://localhost:8080**

## 📁 Estrutura do Projeto

```
Intro_DBT_duckdb_DEH/
├── docker-compose.yml          # Configuração do Docker
├── Dockerfile                   # Imagem Docker com DBT + DuckDB
├── dbt/
│   ├── dbt_project.yml         # Configuração do projeto DBT
│   ├── profiles/
│   │   └── profiles.yml        # Configuração de conexão com DuckDB
│   ├── seeds/                  # Dados de entrada (CSVs)
│   │   ├── usuarios.csv
│   │   └── vendas.csv
│   ├── models/                 # Modelos DBT (SQL)
│   │   ├── 01_hello_world.sql
│   │   ├── staging/
│   │   │   ├── stg_usuarios.sql
│   │   │   └── stg_vendas.sql
│   │   └── marts/
│   │       └── fct_vendas_por_usuario.sql
│   └── target/                 # Arquivos gerados (logs, docs, etc)
└── README.md
```

## 📊 Dados de Exemplo

O projeto inclui dois arquivos CSV com dados de exemplo:

### `usuarios.csv`
- **4 usuários** com id, nome, email e data de criação
- Um usuário sem email (para demonstrar filtros)

### `vendas.csv`
- **5 vendas** com id, usuário, valor e data
- Relacionadas aos usuários do seed anterior

## 🎓 Comandos Úteis

### Comandos DBT Básicos

```bash
# Verificar configuração
dbt debug

# Carregar seeds (CSVs)
dbt seed

# Executar todos os modelos
dbt run

# Executar um modelo específico
dbt run --select 01_hello_world

# Executar modelos de uma pasta
dbt run --select staging.*

# Gerar documentação
dbt docs generate

# Servir documentação (interface web)
dbt docs serve --host 0.0.0.0 --port 8080

# Ver o grafo de dependências
dbt ls
```

### Comandos Docker

```bash
# Subir ambiente
docker compose up -d

# Ver logs
docker compose logs -f dbt

# Parar ambiente
docker compose down

# Parar e remover volumes (limpar banco)
docker compose down -v

# Reconstruir imagem
docker compose up -d --build
```

## 🔍 Entendendo os Exemplos

### Exemplo 1: Hello World
**Arquivo:** `models/01_hello_world.sql`

Este é o modelo mais simples possível. Ele não depende de nenhum outro modelo ou seed, apenas retorna valores estáticos. Use este exemplo para:
- Entender a sintaxe básica de um modelo DBT
- Ver como o DBT compila e executa SQL
- Testar se o ambiente está funcionando

### Exemplo 2: Staging (Prático)
**Arquivos:** `models/staging/stg_usuarios.sql` e `models/staging/stg_vendas.sql`

Estes modelos demonstram a camada de **staging** (preparação de dados):
- **`stg_usuarios`**: Lê o seed `usuarios`, faz casting de tipos e filtra registros sem email
- **`stg_vendas`**: Lê o seed `vendas` e faz casting de tipos

Conceitos aprendidos:
- `{{ ref('nome_do_seed') }}` - Referencia um seed ou modelo
- Casting de tipos (`cast(id as integer)`)
- Filtros SQL básicos

### Exemplo 3: Marts (Intermediário)
**Arquivo:** `models/marts/fct_vendas_por_usuario.sql`

Este modelo demonstra a camada de **marts** (camada analítica):
- Combina dados de múltiplos modelos usando `{{ ref() }}`
- Usa CTEs (Common Table Expressions)
- Faz agregações (`count`, `sum`, `min`, `max`)
- Faz JOINs entre tabelas
- Ordena resultados

Conceitos aprendidos:
- Relacionamentos entre modelos
- Agregações e métricas
- Estrutura de camadas (staging → marts)

## 🎨 Interface Gráfica (dbt docs)

A interface gráfica do DBT permite você:

1. **Ver todos os modelos** e suas descrições
2. **Visualizar o grafo de dependências** (lineage) - veja como os modelos se relacionam
3. **Inspecionar o SQL compilado** de cada modelo
4. **Ver estatísticas** de execução

Para acessar:
```bash
docker compose exec dbt bash -lc "dbt docs serve --host 0.0.0.0 --port 8080"
```

Depois abra: **http://localhost:8080**

## 🐛 Solução de Problemas

### Erro: "Cannot open file"
Se aparecer erro sobre não conseguir abrir o arquivo do DuckDB, certifique-se de que o `profiles.yml` está apontando para o caminho correto (`/usr/app/curso_dbt_duckdb.duckdb`).

### Erro: "port is already allocated"
A porta 8080 está em uso. Você pode:
- Parar o processo que está usando a porta
- Ou mudar a porta no `docker-compose.yml`

### Erro de sintaxe SQL
Lembre-se: **não use `;` no final dos modelos SQL** dentro do DBT. O DBT adiciona o ponto e vírgula automaticamente quando compila.

## 📚 Próximos Passos

Agora que você entendeu o básico, experimente:

1. **Criar novos modelos** baseados nos exemplos
2. **Adicionar mais dados** nos seeds
3. **Criar testes** com `dbt test`
4. **Adicionar documentação** nos modelos usando `docs`
5. **Explorar macros** do DBT
6. **Criar snapshots** para histórico de dados

## 📝 Notas Importantes

- O banco DuckDB é criado automaticamente na primeira execução
- Os dados ficam persistidos no arquivo `curso_dbt_duckdb.duckdb` dentro do diretório `dbt/`
- O container fica rodando em background (`tail -f /dev/null`) para você poder executar comandos quando quiser
- Todos os arquivos do projeto são montados como volume, então mudanças são refletidas imediatamente

## 🤝 Contribuindo

Sinta-se à vontade para:
- Adicionar mais exemplos
- Melhorar a documentação
- Reportar problemas
- Sugerir melhorias

## 📄 Licença

Este projeto é para fins educacionais.

---

**Divirta-se aprendendo DBT! 🎉**
