# Visibilidade em Solidity

Neste guia, você vai entender os 4 modificadores de visibilidade mais usados em funções e variáveis:

- public
- private
- internal
- external

Eles controlam quem pode acessar uma função/variável e de onde.

## Resumo rápido

| Visibilidade | Mesmo contrato | Contratos filhos | Outros contratos | Chamadas externas |
|---|---|---|---|---|
| `public` | Sim | Sim | Sim | Sim |
| `private` | Sim | Não | Não | Não |
| `internal` | Sim | Sim | Não (direto) | Não |
| `external` | Não (direto) | Não (direto) | Sim | Sim |

## public

Acesso mais aberto. Pode ser chamado:

- dentro do próprio contrato
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

Observação: variável `public` ganha automaticamente uma função getter.

## private

Acesso mais restrito. Só o contrato atual enxerga.

- não pode ser acessado por contratos filhos
- não pode ser acessado por fora

### Exemplo

```solidity
uint256 private segredo;

function definirSegredo(uint256 valor) public {
    segredo = valor;
}
```

Importante: `private` esconde no nível da linguagem, mas os dados da blockchain ainda podem ser inspecionados por ferramentas de leitura de estado.

## internal

Intermediário entre `public` e `private`.

- contrato atual: sim
- contratos filhos (herança): sim
- contratos externos sem herança: não direto

### Exemplo

```solidity
function _calcularTaxa(uint256 valor) internal pure returns (uint256) {
    return (valor * 2) / 100;
}
```

Padrão comum: funções auxiliares com prefixo `_` como `internal`.

## external

Pensado para ser chamado de fora do contrato.

- pode ser chamado por front-end, carteira e outros contratos
- não pode ser chamado internamente de forma direta (`minhaFuncao()`)
- se precisar chamar de dentro, use `this.minhaFuncao()` (chamada externa, mais cara)

### Exemplo

```solidity
function votar(string calldata candidato) external {
    // lógica de voto
}
```

Dica: em parâmetros dinâmicos (`string`, `bytes`, arrays), `external + calldata` costuma ser mais eficiente que `public + memory`.

## Quando usar cada um

- Use `public` para funções comuns e simples.
- Use `private` para detalhes internos que não devem ser reutilizados por herança.
- Use `internal` para lógica que deve ser reaproveitada por contratos filhos.
- Use `external` para funções focadas em chamadas de fora e melhor eficiência com `calldata`.

## Dúvidas frequentes

### "private deixa meus dados secretos?"

Não. `private` restringe acesso no código Solidity, mas dados on-chain podem ser lidos por ferramentas de exploração de estado.

### "Posso chamar external de dentro do contrato?"

Diretamente (`minhaFuncao()`) não. Para isso, teria que usar `this.minhaFuncao()`, que vira chamada externa e custa mais gas.

### "Quando escolher public vs external?"

- prefira `public` quando também precisa chamar internamente
- prefira `external` para funções usadas de fora, especialmente com parâmetros dinâmicos

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
