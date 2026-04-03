# Aprenda Solidity com Exemplos Práticos

Bem-vindo! Este é um mini-curso progressivo com 12 contratos organizados em 3 níveis de dificuldade que cobrem os fundamentos essenciais de Solidity até padrões reais de produção.

## Trilha Pedagógica em 3 Níveis

| Nível | Contratos | Descrição |
|-------|-----------|-----------|
| **Básicos** | 7 contratos | Conceitos essenciais |
| **Intermediários** | 5 contratos | Bridge para concepções avançadas |
| **Tokens** | 2 contratos | Padrões de produção (ERC20 e ERC721) |

## Ordem Sugerida de Estudo

### Fundamentos Teóricos

Antes dos contratos práticos, siga esta ordem de estudo:

1. [Fundamentos (tipos, uint, mapping, require, msg.sender)](fundamentos/tipos-dados.md)
2. [Visibilidade (public, private, internal, external)](fundamentos/visibilidade.md)
3. [Funções, eventos e modifiers](fundamentos/funcoes-eventos-modifiers.md)
4. [Nomenclatura no Solidity](fundamentos/nomenclatura.md)
5. [Guia prático do Remix](fundamentos/remix.md)
6. [FAQ de dúvidas e erros comuns](fundamentos/faq.md)

### Contratos Práticos

| # | Contrato | Conceitos | Dificuldade |
|---|----------|-----------|-------------|
| 1 | [Contador](basicos/contador.md) | Estado • Funções | ⭐ Básico |
| 2 | [Votação](basicos/votacao.md) | Mapping • Lógica | ⭐ Básico |
| 3 | [Cofrinho](basicos/cofrinho.md) | Payable • ETH Real | ⭐⭐ Iniciante |
| 4 | [Admin](basicos/admin.md) | msg.sender • Modifier | ⭐⭐ Iniciante |
| 5 | [Faucet](basicos/faucet.md) | Timestamp • Controle | ⭐⭐ Iniciante |
| 6 | [Cara ou Coroa](basicos/cara-ou-coroa.md) | Hash • Pseudo-Random | ⭐⭐⭐ Intermediário |
| 7 | [Registro](basicos/registro.md) | Struct • Arrays | ⭐⭐⭐ Intermediário |

## O que você vai aprender

- **Estado & Variáveis** — como dados persistem na blockchain
- **Funções & Lógica** — programação básica
- **Payable & ETH** — lidar com dinheiro real
- **Segurança** — modifiers, require, access control
- **Padrões Reais** — ownership, rate limiting, tokenomics
- **Tipos de Dados** — uint, mapping, struct, arrays
- **Blockchain Primitives** — msg.sender, block.timestamp, keccak256

## Como Testar

Copie o código de qualquer contrato e:

1. Abra [Remix IDE](https://remix.ethereum.org)
2. Crie um arquivo novo
3. Cole o código
4. Compile (`Ctrl+S`)
5. Deploy e interaja!

## Estrutura do Curso

```
MentoriaBlockchain/
├── fundamentos/     # Guias teóricos
├── basicos/         # 7 contratos básicos
├── intermediarios/  # 5 contratos intermediários
└── tokens/          # ERC20 e ERC721
```
