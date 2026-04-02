# 🧪 Aprenda Solidity com Exemplos Práticos

Bem-vindo! Este é um mini-curso progressivo com 12 contratos organizados em 3 níveis de dificuldade que cobrem os fundamentos essenciais de Solidity até padrões reais de produção.

## 🎯 Trilha Pedagógica em 3 Níveis

**Nível 1: Básicos** (7 contratos) — conceitos essenciais  
**Nível 2: Intermediários** (5 contratos) — bridge para concepções avançadas  
**Nível 3: Tokens** (2 contratos) — padrões de produção (ERC20 e ERC721)

## 📚 Ordem Sugerida pra Aula

| # | Contrato | Conceitos | Dificuldade |
|---|----------|-----------|-------------|
| 1️⃣ | **Contador** | Estado • Funções | ⭐ Básico |
| 2️⃣ | **Votação** | Mapping • Lógica | ⭐ Básico |
| 3️⃣ | **Cofrinho** | Payable • ETH Real | ⭐⭐ Iniciante |
| 4️⃣ | **Admin** | msg.sender • Modifier | ⭐⭐ Iniciante |
| 5️⃣ | **Faucet** | Timestamp • Controle | ⭐⭐ Iniciante |
| 6️⃣ | **Cara ou Coroa** | Hash • Pseudo-Random | ⭐⭐⭐ Intermediário |
| 7️⃣ | **Registro** | Struct • Arrays | ⭐⭐⭐ Intermediário |

---

## 📖 Guias Essenciais para Iniciantes

Antes dos contratos práticos, siga esta ordem de estudo:

1. Fundamentos (tipos, `uint`, `mapping`, `require`, `msg.sender`): [docs/fundamentos-tipos-dados-solidity.md](docs/fundamentos-tipos-dados-solidity.md)
2. Visibilidade (`public`, `private`, `internal`, `external`): [docs/visibilidade-solidity.md](docs/visibilidade-solidity.md)
3. Funcoes, eventos e modifiers: [docs/funcoes-eventos-modifiers-solidity.md](docs/funcoes-eventos-modifiers-solidity.md)
4. Nomenclatura no Solidity: [docs/nomenclatura-solidity-underscore.md](docs/nomenclatura-solidity-underscore.md)
5. Guia pratico do Remix: [docs/remix-guia-pratico.md](docs/remix-guia-pratico.md)
6. FAQ de duvidas e erros comuns: [docs/faq-erros-comuns-solidity.md](docs/faq-erros-comuns-solidity.md)

---

## 🎯 O que cada um ensina

### 🧮 1. Contador (Ultra Básico)

**Problema:** Como guardar um número que persista na blockchain e seja acessível a todos?

**Conceitos:**
- Variável de estado (`uint256`)
- Leitura automática (`public`)
- Alteração de estado simples
- Funções básicas sem retorno

**Use case:** Aprender o mínimo necessário

---

### 🗳️ 2. Votação 

**Problema:** Como registrar votos de forma justa, impedindo que alguém vote duas vezes?

**Conceitos:**
- `mapping` (dicionário blockchain)
- Lógica de negócio (`require`)
- Controle simples de acesso
- Estrutura condicional

**Use case:** Engajamento • Lógica real

---

### 💰 3. Cofrinho (Depositar/Retirar ETH)

**Problema:** Como gerenciar diferentes saldos de usuários e permitir depósitos/saques?

**Conceitos:**
- Função `payable`
- `msg.value` (ETH recebido)
- `msg.sender` (quem chamou)
- Transferência de ETH (`.transfer()`)
- Segurança básica

**Use case:** Primeira vez com dinheiro real

---

### 🔐 4. Admin (Controle de Dono)

**Problema:** Como garantir que apenas o proprietário do contrato possa executar ações críticas?

**Conceitos:**
- `msg.sender` (identidade)
- `constructor()` (inicialização)
- `modifier` (reutilizável)
- Padrão de **ownership** (MUITO usado em Web3)

**Use case:** Proteger funções administrativas

---

### 🎁 5. Faucet (Distribuidor)

**Problema:** Como distribuir recursos periodicamente, impedindo que alguém saque múltiplas vezes em poucos minutos?

**Conceitos:**
- `block.timestamp` (tempo do blockchain)
- Controle de taxa (rate limiting)
- Integração com tokens
- Lógica real de DeFi

**Use case:** Aplicação prática de Web3

---

### 🎲 6. Cara ou Coroa

**Problema:** Como criar um sorteio/jogo em um ambiente determinístico como a blockchain?

**Conceitos:**
- Pseudo-random com `keccak256()`
- Hash de dados
- Limitações da blockchain (determinismo)
- Diversão! 🎉

**Use case:** Deixar a aula leve • Aprender sobre randomness

---

### 🧾 7. Registro (Cartório)

**Problema:** Como armazenar múltiplos registros com dados estruturados e histórico completo?

**Conceitos:**
- `struct` (tipos customizados)
- `arrays` (listas)
- Persistência em blockchain
- Iteração de dados

**Use case:** Aplicação real • Notarização

---

## 🧠 O que você cobre com esses 7 contratos

✅ **Estado & Variáveis** — como dados persistem  
✅ **Funções & Lógica** — programação básica  
✅ **Payable & ETH** — lidar com dinheiro real  
✅ **Segurança** — modifiers, require, access control  
✅ **Padrões Reais** — ownership, rate limiting, tokenomics  
✅ **Tipos de Dados** — uint, mapping, struct, arrays  
✅ **Blockchain Primitives** — msg.sender, block.timestamp, keccak256

---

## 📂 Estrutura de Arquivos

```
MentoriaBlockchain/
├── README.md
├── basicos/
│   ├── 1_Contador.sol
│   ├── 2_Votacao.sol
│   ├── 3_Cofrinho.sol
│   ├── 4_Admin.sol
│   ├── 5_Faucet.sol
│   ├── 6_CaraOuCoroa.sol
│   └── 7_Registro.sol
├── intermediarios/
│   ├── 8_Whitelist.sol
│   ├── 9_Leilao.sol
│   ├── 10_MultiSig.sol
│   ├── 11_Staking.sol
│   └── 12_Marketplace.sol
└── tokens/
    ├── MyERC20.sol
    └── MyERC721.sol
```

---

## 🌉 Contratos Bridge (Intermediário)

Após dominar os 7 básicos, explore esses contratos que conectam conceitos preparando para tokens e DeFi.

| # | Contrato | Conceitos | Dificuldade |
|---|----------|-----------|-------------|
| 8️⃣ | **Whitelist** | Array • Mapping • Access Control | ⭐⭐ Intermediário |
| 9️⃣ | **Leilão** | Tracking bids • Refund logic | ⭐⭐ Intermediário |
| 🔟 | **MultiSig** | Voting • Proposals • Execution | ⭐⭐⭐ Avançado |
| 1️⃣1️⃣ | **Staking** | Lock period • Rewards • Claim | ⭐⭐⭐ Avançado |
| 1️⃣2️⃣ | **Marketplace** | Inventory • Comissões • Vendas | ⭐⭐⭐ Avançado |

### 🏳️ 8. Whitelist (Controle de Acesso)

**Problema:** Como fazer uma pré-venda restrita apenas para endereços aprovados?

**Conceitos:**
- Array de endereços
- Mapping para verificação rápida
- Access control pattern

**Use case:** Presale, whitelist em lançamento

---

### 🏛️ 9. Leilão (Bidding System)

**Problema:** Como implementar um leilão onde o maior lance vence?

**Conceitos:**
- Tracking de bids
- Comparação de valores
- Refund logic
- Time-based logic

**Use case:** NFT auctions, presales

---

### 🗝️ 10. MultiSig Simples (Múltiplas Assinaturas)

**Problema:** Como exigir aprovação de múltiplos signatários antes de executar uma ação?

**Conceitos:**
- Voting pattern
- Proposals
- Threshold logic
- Execution control

**Use case:** Tesouro coletivo, DAOs, contratos seguros de produção

---

### 💎 11. Staking (Lock & Reward)

**Problema:** Como incentivar usuários que delegam seus fundos com recompensas?

**Conceitos:**
- Lock period
- Time-based rewards
- Claim mechanism
- APY/rate calculations

**Use case:** Yield farming, staking pools, incentivos

---

### 🛍️ 12. Marketplace (Buy/Sell)

**Problema:** Como criar um marketplace P2P com múltiplos vendedores e comissão da plataforma?

**Conceitos:**
- Inventory management
- Comissões
- Vendedor tracking
- Withdraw pattern

**Use case:** NFT marketplace, peer-to-peer trading, e-commerce Web3

---

## 🪙 Padrões de Tokens (Avançado)

Após dominar os 7 exemplos, você pode explorar implementações reais de tokens!

### 🔷 ERC20 (Fungível - Criptomoedas)
Implementação completa do padrão ERC20 para criar suas próprias criptomoedas.

**Conceitos:**
- `transfer()` e `transferFrom()` — enviar tokens
- `balanceOf()` — saldo de um endereço
- `approve()` e `allowance()` — autorização delegada
- Events (`Transfer`, `Approval`)
- Decimals e supply total

**Use case:** Criar seu próprio token (tipo seu próprio "Bitcoin")

### 🎨 ERC721 (Não-Fungível - NFTs)
Implementação completa do padrão ERC721 para criar coleções de NFTs.

**Conceitos:**
- `tokenURI()` — metadados do NFT (imagem, propriedades)
- `ownerOf()` — quem possui um token específico
- `mint()` e `burn()` — criar e destruir NFTs
- `safeTransferFrom()` — transferência segura
- Events (`Transfer`, `Approval`)

**Use case:** Criar sua primeira coleção de NFTs (arte digital, certificados, colecionáveis)

---

## 🚀 Como Testar

Copie o código de qualquer arquivo `.sol` e:

1. Abra [Remix IDE](https://remix.ethereum.org)
2. Crie um arquivo novo
3. Cole o código
4. Compile (`Ctrl+S`)
5. Deploy e interaja!

Para um passo a passo completo de ambiente, contas, envio de ETH e leitura de logs:

- [docs/remix-guia-pratico.md](docs/remix-guia-pratico.md)

## ❓ Dúvidas Frequentes

Se os alunos travarem em erros de compilação/revert, consulte:

- [docs/faq-erros-comuns-solidity.md](docs/faq-erros-comuns-solidity.md)

---

Bora codar! 🎓
