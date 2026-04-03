# Tokens

Esta seção contém implementações didáticas dos padrões de tokens mais importantes do Ethereum.

## Padrões Disponíveis

| Token | Tipo | Descrição |
|-------|------|-----------|
| [ERC20](erc20.md) | Fungível | Tokens intercambiáveis (como criptomoedas) |
| [ERC721](erc721.md) | Não-Fungível | Tokens únicos (NFTs) |

## Diferença Principal

| Característica | ERC20 | ERC721 |
|----------------|-------|--------|
| Fungibilidade | Todos iguais | Cada um único |
| Identidade | Sem ID por token | ID único por token |
| Transferência | Por quantidade | Por token ID |
| Uso comum | Criptomoedas, utility tokens | NFTs, colecionáveis |
| Exemplos | USDT, USDC, LINK | CryptoPunks, BAYC |

## ERC20 (Fungível)

Tokens onde cada unidade é idêntica e intercambiável.
Como dinheiro: R$10 é R$10, independente da nota.

## ERC721 (Não-Fungível)

Tokens onde cada um tem identidade única.
Como arte: cada NFT é único e tem valor próprio.
