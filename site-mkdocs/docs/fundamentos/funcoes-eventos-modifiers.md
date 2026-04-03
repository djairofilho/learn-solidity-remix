# Funções, Eventos e Modifiers em Solidity

Este guia explica três pilares da maioria dos contratos:

- funções
- eventos
- modifiers

## Funções

Funções são blocos de lógica executados no contrato.

Tipos comuns:

- `public`: pode ser chamada de dentro e de fora
- `external`: focada em chamada de fora
- `internal`: só dentro do contrato e filhos
- `private`: só no próprio contrato

Mutabilidade:

- `view`: le estado, não altera
- `pure`: não le nem altera estado
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

## Eventos

Eventos registram ações importantes no log da blockchain.

Para que servem:

- front-end escutar mudanças
- indexadores (como The Graph) processarem histórico
- auditoria de operações

Exemplo:

```solidity
event Deposito(address indexed usuario, uint256 valor);

function depositar() public payable {
    require(msg.value > 0, "Valor inválido");
    emit Deposito(msg.sender, msg.value);
}
```

Boas práticas:

- emitir evento em ação crítica (mint, burn, transferência, saque)
- usar `indexed` em campos de filtro (ex.: `address`)
- manter nomes claros e padrão consistente

## Modifiers

Modifiers são regras reutilizáveis antes/depois da execução da função.

Uso típico:

- controle de acesso (`onlyOwner`)
- validação de estado (`whenNotPaused`)
- validação de parâmetros

Exemplo:

```solidity
address public owner;

constructor() {
    owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner, "Não autorizado");
    _;
}

function setOwner(address novoOwner) public onlyOwner {
    require(novoOwner != address(0), "Endereço inválido");
    owner = novoOwner;
}
```

## Exemplo completo (juntando os 3)

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
        require(msg.sender == owner, "Não autorizado");
        _;
    }

    function depositar() external payable {
        require(msg.value > 0, "Valor inválido");
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

## Erros comuns

- esquecer `emit` ao disparar evento
- usar modifier sem mensagem clara no `require`
- marcar função como `view` quando ela altera estado
- não emitir eventos em funções sensíveis

## Dúvidas que sempre aparecem em aula

### "Por que essa função custa gas e a outra não?"

- funções `view`/`pure` chamadas externamente para leitura não geram transação
- funções que alteram estado sempre geram transação e pagam gas

### "Event guarda estado?"

Não. Evento é log para consulta/indexação, não substitui variável de estado.

### "Modifier é segurança automática?"

Modifier ajuda a centralizar regra, mas a regra ainda precisa ser correta e cobrir todos os caminhos da função.

## Boas práticas rápidas

- valide parâmetros no início da função
- atualize estado antes de interações externas
- emita evento após ação relevante
- prefira mensagens de erro curtas e objetivas
- para envio de ETH, prefira `call` com verificação de sucesso

## Regra rápida para aula

- função: o que o contrato faz
- evento: o que o contrato anuncia
- modifier: quem pode fazer e em que condição

Com isso, seus exemplos ficam mais próximos de contratos reais de produção.
