# 🧪 Exemplos Práticos de Solidity

Bem-vindo! Este é um mini-curso progressivo com 7 contratos que cobrem os fundamentos essenciais de Solidity, do básico ao intermediário.

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

Antes dos exemplos praticos, siga esta ordem:

1. Fundamentos (tipos, `uint`, `mapping`, `require`, `msg.sender`): [docs/fundamentos-tipos-dados-solidity.md](docs/fundamentos-tipos-dados-solidity.md)
2. Visibilidade (`public`, `private`, `internal`, `external`): [docs/visibilidade-solidity.md](docs/visibilidade-solidity.md)
3. Funcoes, eventos e modifiers: [docs/funcoes-eventos-modifiers-solidity.md](docs/funcoes-eventos-modifiers-solidity.md)
4. Nomenclatura no Solidity: [docs/nomenclatura-solidity-underscore.md](docs/nomenclatura-solidity-underscore.md)

---

## 🎯 O que cada um ensina

### 🧮 1. Contador (Ultra Básico)
- Variável de estado (`uint256`)
- Leitura automática (`public`)
- Alteração de estado simples
- Funções básicas sem retorno

**Use case:** Aprender o mínimo necessário

---

### 🗳️ 2. Votação 
- `mapping` (dicionário blockchain)
- Lógica de negócio (`require`)
- Controle simples de acesso
- Estrutura condicional

**Use case:** Engajamento • Lógica real

---

### 💰 3. Cofrinho (Depositar/Retirar ETH)
- Função `payable`
- `msg.value` (ETH recebido)
- `msg.sender` (quem chamou)
- Transferência de ETH (`.transfer()`)
- Segurança básica

**Use case:** Primeira vez com dinheiro real

---

### 🔐 4. Admin (Controle de Dono)
- `msg.sender` (identidade)
- `constructor()` (inicialização)
- `modifier` (reutilizável)
- Padrão de **ownership** (MUITO usado em Web3)

**Use case:** Proteger funções administrativas

---

### 🎁 5. Faucet (Distribuidor)
- `block.timestamp` (tempo do blockchain)
- Controle de taxa (rate limiting)
- Integração com tokens
- Lógica real de DeFi

**Use case:** Aplicação prática de Web3

---

### 🎲 6. Cara ou Coroa
- Pseudo-random com `keccak256()`
- Hash de dados
- Limitações da blockchain (determinismo)
- Diversão! 🎉

**Use case:** Deixar a aula leve • Aprender sobre randomness

---

### 🧾 7. Registro (Cartório)
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
├── exemplos/
│   ├── 1_Contador.sol
│   ├── 2_Votacao.sol
│   ├── 3_Cofrinho.sol
│   ├── 4_Admin.sol
│   ├── 5_Faucet.sol
│   ├── 6_CaraOuCoroa.sol
│   └── 7_Registro.sol
└── tokens/
    ├── ERC20.sol
    └── ERC721.sol
```

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

---

## 💡 Dicas Pedagógicas

- **Comece com Contador** — instale os conceitos básicos
- **Pule para Votação** — deixa engajado com lógica real
- **Antes do Cofrinho** — explique msg.value e payable
- **Admin é obrigatório** — modifier é ESSENCIAL em Web3
- **Faucet + seu ERC20** — primeiro contrato "conectado"
- **Cara ou Coroa é quebra-galho** — todos vão querer testar uma vez
- **Registro fecha brilhantemente** — aplicação real de tudo

---

## 📘 Documentação Extra

- Fundamentos para primeira aula (`uint`, `mapping`, `require`, `msg.sender`): [docs/fundamentos-tipos-dados-solidity.md](docs/fundamentos-tipos-dados-solidity.md)
- Visibilidade (`public`, `private`, `internal`, `external`): [docs/visibilidade-solidity.md](docs/visibilidade-solidity.md)
- Nomenclatura com `_` em Solidity: [docs/nomenclatura-solidity-underscore.md](docs/nomenclatura-solidity-underscore.md)
- Funcoes, eventos e modifiers: [docs/funcoes-eventos-modifiers-solidity.md](docs/funcoes-eventos-modifiers-solidity.md)

---

Bora codar! 🎓
