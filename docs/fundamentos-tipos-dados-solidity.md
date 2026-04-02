# Fundamentos de Solidity para Iniciantes

Este guia e para primeira aula. A ideia e entender o basico antes de ir para os contratos praticos.

## 1) Estrutura minima de um contrato

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MeuPrimeiroContrato {
    uint256 public numero;
}
```

- `pragma` define a versao do compilador
- `contract` e o bloco principal
- `numero` e uma variavel de estado (fica salva na blockchain)

## 2) Tipos basicos

- `uint` ou `uint256`: inteiro sem sinal (mais usado)
- `int`: inteiro com sinal
- `bool`: `true` ou `false`
- `address`: endereco de carteira/contrato
- `string`: texto
- `bytes` e `bytes32`: dados em formato binario

Exemplo:

```solidity
uint256 public idade = 20;
bool public ativo = true;
address public dono;
string public nome = "Ana";
```

## 3) Variaveis de estado vs locais

- Variavel de estado: vive no contrato e persiste
- Variavel local: existe so durante a funcao

```solidity
uint256 public contador;

function somarUm() public {
    uint256 incremento = 1; // variavel local
    contador += incremento; // variavel de estado
}
```

## 4) Funcoes basicas

- `view`: le estado, nao altera
- `pure`: nao le nem altera estado
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

## 5) Mapping (dicionario)

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
- uso comum: saldos, permissoes, votos

## 6) Arrays e Struct (introducao)

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

## 7) Variaveis globais importantes

- `msg.sender`: quem chamou a funcao
- `msg.value`: quanto ETH foi enviado
- `block.timestamp`: horario aproximado do bloco

```solidity
function quemChamou() public view returns (address) {
    return msg.sender;
}
```

## 8) Validacoes com require

Use `require` para regras de seguranca.

```solidity
function sacar(uint256 valor) public {
    require(valor > 0, "Valor precisa ser maior que zero");
    // continua so se a regra passar
}
```

Se `require` falhar, a transacao e revertida.

## 9) Eventos (o que aconteceu)

Eventos ajudam front-end e indexadores a saber o que ocorreu.

```solidity
event Deposito(address indexed usuario, uint256 valor);

function depositar() public payable {
    require(msg.value > 0, "Envie ETH");
    emit Deposito(msg.sender, msg.value);
}
```

## 10) Erros comuns de quem esta comecando

- esquecer `memory` em parametros `string`
- esquecer `emit` ao disparar evento
- usar `view` em funcao que altera estado
- nao validar entrada com `require`

## Ordem sugerida de estudo

1. Este guia (fundamentos)
2. Visibilidade (`public`, `private`, `internal`, `external`)
3. Funcoes, eventos e modifiers
4. Contratos praticos da pasta `exemplos/`

Com essa base, `uint`, `mapping` e os demais conceitos ficam muito mais faceis de ensinar na primeira aula.
