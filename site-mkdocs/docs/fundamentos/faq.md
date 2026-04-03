# FAQ de Dúvidas Frequentes em Solidity

## Qual a diferença entre wei, gwei e ether?

- `1 ether = 10^18 wei`
- `1 gwei = 10^9 wei`
- `wei` é a menor unidade.

Em contratos, quase tudo é armazenado em wei.

## Por que minha transação reverteu?

Motivos comuns:
- `require` falhou (regra de negócio)
- saldo insuficiente
- usuário sem permissão (`onlyOwner`)
- valor enviado incorreto em função `payable`

Dica: sempre leia a mensagem do `require` no output da transação.

## Diferença entre `view`, `pure` e função normal

- `view`: le estado, não altera
- `pure`: não le e não altera estado
- normal: altera estado e gera transação

## `memory`, `storage` e `calldata` confundem. Como pensar?

- `storage`: dados persistentes da blockchain
- `memory`: dados temporários durante a execução
- `calldata`: dados de entrada de funções externas (somente leitura)

Regra prática:
- parâmetro `string` em função `public`: use `memory`
- parâmetro em função `external`: prefira `calldata` quando possível

## O que é gas na prática?

Gas é o custo computacional da operação.

Custos altos costumam vir de:
- loops longos
- muitas escritas em storage
- estruturas grandes retornadas on-chain

## Posso confiar em `block.timestamp`?

Use para janelas de tempo aproximadas (cooldown, expiração simples).
Não use como única fonte de aleatoriedade ou para regras extremamente sensíveis.

## Por que aleatoriedade em blockchain é difícil?

Porque a blockchain é determinística: todos os nós precisam chegar no mesmo resultado.
Para sorteio sério, use oráculo de random (ex.: VRF).

## `transfer` vs `call` para enviar ETH

Hoje, `call` é preferido por compatibilidade e flexibilidade.

Padrão recomendado:

```solidity
(bool ok, ) = payable(destino).call{value: valor}("");
require(ok, "Falha no envio");
```

## O que não esquecer antes de deploy real

- validar controle de acesso
- emitir eventos nas ações críticas
- revisar mensagens de erro
- testar cenários de falha
- limitar superfícies de ataque (funções externas desnecessárias)

## Erros de sintaxe muito comuns de iniciantes

- nome de função com espaço (inválido)
- identificadores com caracteres não suportados pelo compilador/linter
- esquecer ponto e vírgula
- esquecer `emit` ao disparar evento
