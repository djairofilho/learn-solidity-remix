# Padrões de Nomenclatura no Solidity

Este guia resume as convenções mais usadas e alinhadas ao estilo oficial do Solidity.

## 1) Contratos e arquivos

Para contratos, use CapWords (tambem chamado PascalCase):

- `ERC20`
- `ERC721`
- `MeuTokenGovernanca`

Quando um arquivo possui um contrato principal, o nome do arquivo normalmente segue o mesmo formato:

- `ERC20.sol`
- `ERC721.sol`
- `MeuTokenGovernanca.sol`

## 2) Funções e variáveis

Use mixedCase (camelCase) para funcoes e variaveis:

```solidity
uint256 public totalSupply;

function transfer(address to, uint256 amount) external returns (bool) {
    return true;
}
```

## 3) Prefixo _ (underscore)

O prefixo `_` e uma convencao de equipe, nao uma regra obrigatoria da linguagem.

Uso comum:

- funcoes auxiliares `internal`/`private`
- variaveis internas que voce quer destacar

Exemplo:

```solidity
uint256 private _taxBps;

function _beforeTokenTransfer(address from, address to, uint256 amount) internal {
    // hook interno
}
```

Regra pratica:

- `public` e `external`: normalmente sem `_`
- `internal` e `private`: podem usar `_` quando melhorar legibilidade

## 4) Constantes e imutáveis

Use `UPPER_SNAKE_CASE` para constantes:

```solidity
uint256 public constant MAX_SUPPLY = 1_000_000 ether;
uint256 private constant BASIS_POINTS = 10_000;
```

Para `immutable`, o estilo pode seguir `UPPER_SNAKE_CASE` ou mixedCase, mas o mais comum em contratos de token e manter consistencia com constantes.

## 5) O que evitar

- misturar varios estilos no mesmo projeto
- usar `_` em tudo sem criterio
- nomes de contrato em `snake_case` ou `camelCase`
- nome de arquivo sem relacao com o contrato principal

## 6) Convenção sugerida para este repo

- pastas: `lower_snake_case`
- contratos e arquivos principais: `CapWords` (ex.: `ERC20.sol`)
- funcoes e variaveis: `mixedCase`
- `internal`/`private`: `_` opcional por legibilidade
- constantes: `UPPER_SNAKE_CASE`

Essa combinacao deixa o codigo didatico para aula e alinhado com praticas comuns do ecossistema Solidity.
