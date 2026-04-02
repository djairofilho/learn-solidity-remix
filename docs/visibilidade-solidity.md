# Visibilidade em Solidity

Neste guia, voce vai entender os 4 modificadores de visibilidade mais usados em funcoes e variaveis:

- public
- private
- internal
- external

Eles controlam quem pode acessar uma funcao/variavel e de onde.

## Resumo rapido

| Visibilidade | Mesmo contrato | Contratos filhos | Outros contratos | Chamadas externas |
|---|---|---|---|---|
| `public` | Sim | Sim | Sim | Sim |
| `private` | Sim | Nao | Nao | Nao |
| `internal` | Sim | Sim | Nao (direto) | Nao |
| `external` | Nao (direto) | Nao (direto) | Sim | Sim |

## 1. public

Acesso mais aberto. Pode ser chamado:

- dentro do proprio contrato
- por contratos filhos
- por outros contratos
- por carteiras/front-end

### Exemplo

```solidity
uint256 public total;

function incrementar() public {
    total += 1;
}
```

Observacao: variavel `public` ganha automaticamente uma funcao getter.

## 2. private

Acesso mais restrito. So o contrato atual enxerga.

- nao pode ser acessado por contratos filhos
- nao pode ser acessado por fora

### Exemplo

```solidity
uint256 private segredo;

function definirSegredo(uint256 valor) public {
    segredo = valor;
}
```

Importante: `private` esconde no nivel da linguagem, mas os dados da blockchain ainda podem ser inspecionados por ferramentas de leitura de estado.

## 3. internal

Intermediario entre `public` e `private`.

- contrato atual: sim
- contratos filhos (heranca): sim
- contratos externos sem heranca: nao direto

### Exemplo

```solidity
function _calcularTaxa(uint256 valor) internal pure returns (uint256) {
    return (valor * 2) / 100;
}
```

Padrao comum: funcoes auxiliares com prefixo `_` como `internal`.

## 4. external

Pensado para ser chamado de fora do contrato.

- pode ser chamado por front-end, carteira e outros contratos
- nao pode ser chamado internamente de forma direta (`minhaFuncao()`)
- se precisar chamar de dentro, use `this.minhaFuncao()` (chamada externa, mais cara)

### Exemplo

```solidity
function votar(string calldata candidato) external {
    // logica de voto
}
```

Dica: em parametros dinamicos (`string`, `bytes`, arrays), `external + calldata` costuma ser mais eficiente que `public + memory`.

## Quando usar cada um

- Use `public` para funcoes comuns e simples.
- Use `private` para detalhes internos que nao devem ser reutilizados por heranca.
- Use `internal` para logica que deve ser reaproveitada por contratos filhos.
- Use `external` para funcoes focadas em chamadas de fora e melhor eficiencia com `calldata`.

## Duvidas frequentes

### "private deixa meus dados secretos?"

Nao. `private` restringe acesso no codigo Solidity, mas dados on-chain podem ser lidos por ferramentas de exploracao de estado.

### "Posso chamar external de dentro do contrato?"

Diretamente (`minhaFuncao()`) nao. Para isso, teria que usar `this.minhaFuncao()`, que vira chamada externa e custa mais gas.

### "Quando escolher public vs external?"

- prefira `public` quando tambem precisa chamar internamente
- prefira `external` para funcoes usadas de fora, especialmente com parametros dinamicos

## Exemplo completo

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExemploVisibilidade {
    uint256 public contador;
    uint256 private segredo;

    function incrementar() public {
        contador += 1;
    }

    function setSegredo(uint256 valor) public {
        segredo = valor;
    }

    function _dobro(uint256 x) internal pure returns (uint256) {
        return x * 2;
    }

    function calcularDobroExterno(uint256 x) external pure returns (uint256) {
        return x * 2;
    }
}
```
