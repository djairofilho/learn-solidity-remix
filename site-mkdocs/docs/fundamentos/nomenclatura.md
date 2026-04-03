# Padrões de Nomenclatura no Solidity

Este guia resume as convenções mais usadas e alinhadas ao estilo oficial do Solidity.

## Contratos e arquivos

Para contratos, use CapWords (também chamado PascalCase):

- `ERC20`
- `ERC721`
- `MeuTokenGovernanca`

Quando um arquivo possui um contrato principal, o nome do arquivo normalmente segue o mesmo formato:

- `ERC20.sol`
- `ERC721.sol`
- `MeuTokenGovernanca.sol`

## Funções e variáveis

Use mixedCase (camelCase) para funções e variáveis:

```solidity
uint256 public totalSupply;

function transfer(address to, uint256 amount) external returns (bool) {
    return true;
}
```

## Prefixo _ (underscore)

O prefixo `_` é uma convenção de equipe, não uma regra obrigatória da linguagem.

Uso comum:

- funções auxiliares `internal`/`private`
- variáveis internas que você quer destacar

Exemplo:

```solidity
uint256 private _taxBps;

function _beforeTokenTransfer(address from, address to, uint256 amount) internal {
    // hook interno
}
```

Regra prática:

- `public` e `external`: normalmente sem `_`
- `internal` e `private`: podem usar `_` quando melhorar legibilidade

## Constantes e imutáveis

Use `UPPER_SNAKE_CASE` para constantes:

```solidity
uint256 public constant MAX_SUPPLY = 1_000_000 ether;
uint256 private constant BASIS_POINTS = 10_000;
```

Para `immutable`, o estilo pode seguir `UPPER_SNAKE_CASE` ou mixedCase, mas o mais comum em contratos de token é manter consistência com constantes.

## O que evitar

- misturar vários estilos no mesmo projeto
- usar `_` em tudo sem critério
- nomes de contrato em `snake_case` ou `camelCase`
- nome de arquivo sem relação com o contrato principal

## Convenção sugerida para este repo

- pastas: `lower_snake_case`
- contratos e arquivos principais: `CapWords` (ex.: `ERC20.sol`)
- funções e variáveis: `mixedCase`
- `internal`/`private`: `_` opcional por legibilidade
- constantes: `UPPER_SNAKE_CASE`

Essa combinação deixa o código didático para aula e alinhado com práticas comuns do ecossistema Solidity.
