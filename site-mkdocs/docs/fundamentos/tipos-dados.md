# Fundamentos de Solidity para Iniciantes

Este guia é para primeira aula. A ideia é entender o básico antes de ir para os contratos práticos.

## Estrutura mínima de um contrato

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MeuPrimeiroContrato {
    uint256 public numero;
}
```

- `pragma` define a versão do compilador
- `contract` é o bloco principal
- `numero` é uma variável de estado (fica salva na blockchain)

## Tipos básicos

- `uint` ou `uint256`: inteiro sem sinal (mais usado)
- `int`: inteiro com sinal
- `bool`: `true` ou `false`
- `address`: endereço de carteira/contrato
- `string`: texto
- `bytes` e `bytes32`: dados em formato binário

Exemplo:

```solidity
uint256 public idade = 20;
bool public ativo = true;
address public dono;
string public nome = "Ana";
```

## Variáveis de estado vs locais

- Variável de estado: vive no contrato e persiste
- Variável local: existe só durante a função

```solidity
uint256 public contador;

function somarUm() public {
    uint256 incremento = 1; // variável local
    contador += incremento; // variável de estado
}
```

## Funções básicas

- `view`: le estado, não altera
- `pure`: não le nem altera estado
- sem `view/pure`: altera estado

```solidity
function incrementar() public {
    contador += 1;
}

function lerContador() public view returns (uint256) {
    return contador;
}

function soma(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b;
}
```

## Mapping (dicionário)

`mapping` conecta chave -> valor.

```solidity
mapping(address => uint256) public saldos;

function depositarSaldo(uint256 valor) public {
    saldos[msg.sender] += valor;
}
```

Para iniciantes:
- chave: `address`
- valor: `uint256`
- uso comum: saldos, permissões, votos

## Arrays e Struct (introdução)

Array = lista. Struct = tipo customizado.

```solidity
struct Aluna {
    string nome;
    uint256 idade;
}

Aluna[] public alunas;

function adicionarAluna(string memory nome, uint256 idade) public {
    alunas.push(Aluna(nome, idade));
}
```

## Variáveis globais importantes

- `msg.sender`: quem chamou a função
- `msg.value`: quanto ETH foi enviado
- `block.timestamp`: horário aproximado do bloco

```solidity
function quemChamou() public view returns (address) {
    return msg.sender;
}
```

### Unidades de valor (wei, gwei, ether)

Em Solidity, valores monetários são inteiros em wei.

- `1 ether = 10^18 wei`
- `1 gwei = 10^9 wei`

Exemplo:

```solidity
uint256 public umEther = 1 ether; // 1000000000000000000
uint256 public taxaGas = 20 gwei; // 20000000000
```

## Validações com require

Use `require` para regras de segurança.

```solidity
function sacar(uint256 valor) public {
    require(valor > 0, "Valor precisa ser maior que zero");
    // continua só se a regra passar
}
```

Se `require` falhar, a transação é revertida.

## Eventos (o que aconteceu)

Eventos ajudam front-end e indexadores a saber o que ocorreu.

```solidity
event Deposito(address indexed usuario, uint256 valor);

function depositar() public payable {
    require(msg.value > 0, "Envie ETH");
    emit Deposito(msg.sender, msg.value);
}
```

## Erros comuns de quem está começando

- esquecer `memory` em parâmetros `string`
- esquecer `emit` ao disparar evento
- usar `view` em função que altera estado
- não validar entrada com `require`
- usar nome de função com espaço
- usar variável com caractere inválido

## `memory`, `storage` e `calldata` sem mistério

- `storage`: persistente no contrato
- `memory`: temporário durante chamada
- `calldata`: entrada somente leitura em função `external`

Exemplo rápido:

```solidity
string public nome;

function setNome(string memory novoNome) public {
    nome = novoNome; // grava em storage
}

function comparar(string calldata valor) external pure returns (bool) {
    return bytes(valor).length > 0;
}
```

## Checklist de validação em aula

- O contrato compila sem erro
- Cada função tem um teste de sucesso
- Pelo menos um teste de falha com `require`
- Eventos principais foram observados no log
- Teste com duas contas para ensinar `msg.sender`

## Ordem sugerida de estudo

1. Este guia (fundamentos)
2. Visibilidade (`public`, `private`, `internal`, `external`)
3. Funções, eventos e modifiers
4. Contratos práticos da pasta `basicos/`

Com essa base, `uint`, `mapping` e os demais conceitos ficam muito mais fáceis de ensinar na primeira aula.
