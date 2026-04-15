# Token Manager

## 📋 Sobre o Projeto

Este projeto implementa um sistema robusto de gerenciamento de tokens que mantém exatamente 100 tokens UUID pré-gerados, com um limite máximo de 100 tokens ativos simultaneamente. O sistema inclui liberação automática de tokens após 2 minutos de uso e gerenciamento inteligente de disponibilidade.

## 🚀 Funcionalidades Principais

- **100 Tokens Únicos**: Tokens UUID pré-gerados e gerenciados
- **Limite de Ativação**: Máximo de 100 tokens ativos simultaneamente
- **Liberação Automática**: Tokens são automaticamente liberados após 2 minutos de uso
- **Gerenciamento de Limite**: Quando o limite é atingido, o token mais antigo é automaticamente liberado
- **Histórico de Uso**: Rastreamento completo do histórico de uso de cada token
- **API RESTful**: Endpoints JSON para todas as operações
- **Processo Supervisionado**: GenServer para verificação periódica de tokens expirados
- **Health Check**: Endpoint `/health` para monitoramento e load balancers
- **Telemetria**: Métricas e eventos para monitoramento em produção
- **Logging Estruturado**: Logs consistentes com contexto para produção


## 🛠️ Tecnologias Utilizadas

- **Phoenix 1.8** - Framework web
- **Elixir** - Linguagem de programação
- **PostgreSQL** - Banco de dados
- **Ecto** - ORM e queries
- **GenServer** - Processos supervisionados para auto-liberação
- **Telemetry** - Métricas e eventos para monitoramento
- **ExDoc** - Geração de documentação

## 📦 Instalação

```bash
# Instalar dependências
mix deps.get

# Configurar o banco de dados
mix ecto.setup

# Iniciar o servidor
mix phx.server
```

O servidor estará disponível em `http://localhost:4000`

## 🧪 Testes

```bash
# Executar todos os testes
mix test

# Executar testes com cobertura
mix test --cover
```

## 📡 API Endpoints

### Health Check
```bash
GET /health
```
Retorna o status de saúde do sistema (database, token manager, métricas). Útil para load balancers e monitoramento.

**Resposta**:
- `200 OK`: Sistema saudável
- `503 Service Unavailable`: Sistema com problemas

### Ativar Token
```bash
POST /api/tokens/activate
Body: {"user_id": "uuid-string"}
```

### Listar Tokens
```bash
GET /api/tokens?state=available|active|all
```

### Obter Token por ID
```bash
GET /api/tokens/:token_id
```

### Histórico de Uso
```bash
GET /api/tokens/:token_id/usages
```

### Limpar Tokens Ativos
```bash
DELETE /api/tokens/active
```

## 📖 Documentação

A documentação completa do projeto, incluindo referência da API e todos os módulos, está disponível em:

**[📖 Ver Documentação Completa](https://marcosflaviogs.github.io/token-manager/)**

A documentação é gerada automaticamente pelo ExDoc e está disponível localmente em `docs/` após executar `mix docs`.

## 🏗️ Estrutura do Projeto

```
lib/
  token_manager/
    token/              # Módulos de gerenciamento de tokens
      context.ex        # Facade principal
      registration.ex   # Ativação de tokens
      release.ex        # Liberação de tokens
      queries.ex        # Consultas
      history.ex        # Histórico de uso
      expiration.ex     # Gerenciamento de expiração
      manager.ex        # GenServer para auto-liberação
      logger.ex         # Logging estruturado
      token_schema.ex   # Schema do token
      token_usage_schema.ex  # Schema de histórico
  token_manager_web/
    controllers/
      token/            # Controllers da API
      health_controller.ex  # Health check endpoint
    telemetry.ex        # Configuração de telemetria

test/                   # Testes
docs/                   # Documentação gerada pelo ExDoc
```

## ⚙️ Configuração

### Configuração Básica

O sistema é configurável através de `config/config.exs`:

```elixir
config :token_manager, TokenManager.Tokens,
  max_active_tokens: 100,
  token_lifetime_minutes: 2,
  check_interval_seconds: 30
```

### Variáveis de Ambiente (Produção)

Para produção, configure as seguintes variáveis de ambiente:

**Obrigatórias**:
- `DATABASE_URL` - String de conexão PostgreSQL
- `SECRET_KEY_BASE` - Chave secreta (gere com `mix phx.gen.secret`)
- `PHX_HOST` - Hostname da aplicação

**Opcionais**:
- `PORT` - Porta HTTP (padrão: 4000)
- `POOL_SIZE` - Tamanho do pool de conexões (padrão: 10)
- `MAX_ACTIVE_TOKENS` - Máximo de tokens ativos (padrão: 100)
- `TOKEN_LIFETIME_MINUTES` - Tempo de vida do token (padrão: 2)
- `CHECK_INTERVAL_SECONDS` - Intervalo de verificação (padrão: 30)

**Exemplo**:
```bash
export DATABASE_URL=ecto://postgres:password@localhost:5432/token_manager_prod
export SECRET_KEY_BASE=$(mix phx.gen.secret)
export PHX_HOST=api.example.com
export PORT=4000
```

## 🚀 Produção

### Funcionalidades de Produção

- ✅ **Health Check**: Endpoint `/health` para monitoramento
- ✅ **Telemetria**: Métricas para monitoramento (Phoenix LiveDashboard)
- ✅ **Logging Estruturado**: Logs consistentes com contexto
- ✅ **Configuração via Ambiente**: Todas as configurações via variáveis de ambiente

### Monitoramento

O sistema emite eventos de telemetria para:
- Ativação de tokens (sucesso/falha)
- Liberação de tokens (sucesso/falha)
- Verificação de expiração
- Checks periódicos do manager

## 📝 Licença

Este projeto foi desenvolvido como parte de um teste técnico.
