# Funcoes, Eventos e Modifiers em Solidity

Este guia explica tres pilares da maioria dos contratos:

- funcoes
- eventos
- modifiers

## 1) Funcoes

Funcoes sao blocos de logica executados no contrato.

Tipos comuns:

- `public`: pode ser chamada de dentro e de fora
- `external`: focada em chamada de fora
- `internal`: so dentro do contrato e filhos
- `private`: so no proprio contrato

Mutabilidade:

- `view`: le estado, nao altera
- `pure`: nao le nem altera estado
- sem `view/pure`: altera estado

Exemplo:

```solidity
uint256 public contador;

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

## 2) Eventos

Eventos registram acoes importantes no log da blockchain.

Para que servem:

- front-end escutar mudancas
- indexadores (como The Graph) processarem historico
- auditoria de operacoes

Exemplo:

```solidity
event Deposito(address indexed usuario, uint256 valor);

function depositar() public payable {
    require(msg.value > 0, "Valor invalido");
    emit Deposito(msg.sender, msg.value);
}
```

Boas praticas:

- emitir evento em acao critica (mint, burn, transferencia, saque)
- usar `indexed` em campos de filtro (ex.: `address`)
- manter nomes claros e padrao consistente

## 3) Modifiers

Modifiers sao regras reutilizaveis antes/depois da execucao da funcao.

Uso tipico:

- controle de acesso (`onlyOwner`)
- validacao de estado (`whenNotPaused`)
- validacao de parametros

Exemplo:

```solidity
address public owner;

constructor() {
    owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner, "Nao autorizado");
    _;
}

function setOwner(address novoOwner) public onlyOwner {
    require(novoOwner != address(0), "Endereco invalido");
    owner = novoOwner;
}
```

## 4) Exemplo completo (juntando os 3)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CofrinhoComOwner {
    address public owner;
    mapping(address => uint256) public saldos;

    event Deposito(address indexed usuario, uint256 valor);
    event Saque(address indexed usuario, uint256 valor);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Nao autorizado");
        _;
    }

    function depositar() external payable {
        require(msg.value > 0, "Valor invalido");
        saldos[msg.sender] += msg.value;
        emit Deposito(msg.sender, msg.value);
    }

    function sacar(uint256 valor) external {
        require(saldos[msg.sender] >= valor, "Saldo insuficiente");
        saldos[msg.sender] -= valor;
        payable(msg.sender).transfer(valor);
        emit Saque(msg.sender, valor);
    }

    function sacarTaxa(uint256 valor) external onlyOwner {
        payable(owner).transfer(valor);
    }
}
```

## 5) Erros comuns

- esquecer `emit` ao disparar evento
- usar modifier sem mensagem clara no `require`
- marcar funcao como `view` quando ela altera estado
- nao emitir eventos em funcoes sensiveis

## 6) Duvidas que sempre aparecem em aula

### "Por que essa funcao custa gas e a outra nao?"

- funcoes `view`/`pure` chamadas externamente para leitura nao geram transacao
- funcoes que alteram estado sempre geram transacao e pagam gas

### "Event guarda estado?"

Nao. Evento e log para consulta/indexacao, nao substitui variavel de estado.

### "Modifier e seguranca automatica?"

Modifier ajuda a centralizar regra, mas a regra ainda precisa ser correta e cobrir todos os caminhos da funcao.

## 7) Boas praticas rapidas

- valide parametros no inicio da funcao
- atualize estado antes de interacoes externas
- emita evento apos acao relevante
- prefira mensagens de erro curtas e objetivas
- para envio de ETH, prefira `call` com verificacao de sucesso

## 8) Regra rapida para aula

- funcao: o que o contrato faz
- evento: o que o contrato anuncia
- modifier: quem pode fazer e em que condicao

Com isso, seus exemplos ficam mais proximos de contratos reais de producao.
